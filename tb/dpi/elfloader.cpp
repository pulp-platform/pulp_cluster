// Copyright 2022 ETH Zurich and University of Bologna.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Modified version of the RISC-V Frontend Server 
// (https://github.com/riscvarchive/riscv-fesvr, e41cfc3001293b5625c25412bd9b26e6e4ab8f7e)
//
// Nicole Narr <narrn@student.ethz.ch>
// Christopher Reinwardt <creinwar@student.ethz.ch>

#include <svdpi.h>
#include <cstring>
#include <string>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <assert.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <vector>
#include <map>
#include <iostream>
#include <stdint.h>

#define IS_ELF(hdr) \
  ((hdr).e_ident[0] == 0x7f && (hdr).e_ident[1] == 'E' && \
   (hdr).e_ident[2] == 'L'  && (hdr).e_ident[3] == 'F')

#define IS_ELF32(hdr) (IS_ELF(hdr) && (hdr).e_ident[4] == 1)
#define IS_ELF64(hdr) (IS_ELF(hdr) && (hdr).e_ident[4] == 2)

#define PT_LOAD 1
#define SHT_NOBITS 8
#define SHT_PROGBITS 0x1
#define SHT_GROUP 0x11

typedef struct {
  uint8_t  e_ident[16];
  uint16_t e_type;
  uint16_t e_machine;
  uint32_t e_version;
  uint32_t e_entry;
  uint32_t e_phoff;
  uint32_t e_shoff;
  uint32_t e_flags;
  uint16_t e_ehsize;
  uint16_t e_phentsize;
  uint16_t e_phnum;
  uint16_t e_shentsize;
  uint16_t e_shnum;
  uint16_t e_shstrndx;
} Elf32_Ehdr;

typedef struct {
  uint32_t sh_name;
  uint32_t sh_type;
  uint32_t sh_flags;
  uint32_t sh_addr;
  uint32_t sh_offset;
  uint32_t sh_size;
  uint32_t sh_link;
  uint32_t sh_info;
  uint32_t sh_addralign;
  uint32_t sh_entsize;
} Elf32_Shdr;

typedef struct
{
  uint32_t p_type;
  uint32_t p_offset;
  uint32_t p_vaddr;
  uint32_t p_paddr;
  uint32_t p_filesz;
  uint32_t p_memsz;
  uint32_t p_flags;
  uint32_t p_align;
} Elf32_Phdr;

typedef struct
{
  uint32_t st_name;
  uint32_t st_value;
  uint32_t st_size;
  uint8_t  st_info;
  uint8_t  st_other;
  uint16_t st_shndx;
} Elf32_Sym;

typedef struct {
  uint8_t  e_ident[16];
  uint16_t e_type;
  uint16_t e_machine;
  uint32_t e_version;
  uint64_t e_entry;
  uint64_t e_phoff;
  uint64_t e_shoff;
  uint32_t e_flags;
  uint16_t e_ehsize;
  uint16_t e_phentsize;
  uint16_t e_phnum;
  uint16_t e_shentsize;
  uint16_t e_shnum;
  uint16_t e_shstrndx;
} Elf64_Ehdr;

typedef struct {
  uint32_t sh_name;
  uint32_t sh_type;
  uint64_t sh_flags;
  uint64_t sh_addr;
  uint64_t sh_offset;
  uint64_t sh_size;
  uint32_t sh_link;
  uint32_t sh_info;
  uint64_t sh_addralign;
  uint64_t sh_entsize;
} Elf64_Shdr;

typedef struct {
  uint32_t p_type;
  uint32_t p_flags;
  uint64_t p_offset;
  uint64_t p_vaddr;
  uint64_t p_paddr;
  uint64_t p_filesz;
  uint64_t p_memsz;
  uint64_t p_align;
} Elf64_Phdr;

typedef struct {
  uint32_t st_name;
  uint8_t  st_info;
  uint8_t  st_other;
  uint16_t st_shndx;
  uint64_t st_value;
  uint64_t st_size;
} Elf64_Sym;

// Write granularity of the testbench preload (AxiWideBeWidth). Sections handed
// to the TB are aligned and non-overlapping at this granularity.
#define BUS_BYTES 8

// address and size
std::vector<std::pair<uint64_t, uint64_t>> sections;

// memory based address and content
std::map<uint64_t, std::vector<uint8_t>> mems;

// Entrypoint
uint64_t entry = 0;
int section_index = 0;

extern "C" {
  char get_entry(long long *entry_ret);
  char get_section(long long *address_ret, long long *len_ret);
  char read_section(long long address, const svOpenArrayHandle buffer, long long len);
  char read_elf(const char *filename);
}

// Publish [start, end) as one section, filling gaps with zeros
static void emit_run (uint64_t start, uint64_t end, const std::map<uint64_t, uint8_t> &img)
{
  std::vector<uint8_t> mem(end - start, 0);

  for (uint64_t addr = start; addr < end; addr++) {
    std::map<uint64_t, uint8_t>::const_iterator byte = img.find(addr);
    if (byte != img.end())
      mem[addr - start] = byte->second;
  }

  sections.push_back(std::make_pair(start, end - start));
  mems[start] = mem;
}

// Return the entry point reported by the ELF file
// Must be called after reading the elf file obviously
extern "C" char get_entry(long long *entry_ret)
{
  *entry_ret = entry;
  return 0;
}

// Iterator over the section addresses and lengths
// Returns:
// 0 if there are no more sections
// 1 if there are more sections to load
extern "C" char get_section(long long *address_ret, long long *len_ret)
{
  if (section_index < sections.size()) {
    *address_ret = sections[section_index].first;
    *len_ret = sections[section_index].second;
    section_index++;
    return 1;
  } else {
    return 0;
  }
}

extern "C" char read_section(long long address, const svOpenArrayHandle buffer, long long len)
{
  // get actual pointer
  char *buf = (char *) svGetArrayPtr(buffer);

  // check that the address points to a section
  std::map<uint64_t, std::vector<uint8_t>>::const_iterator sec = mems.find(address);
  if (sec == mems.end()) {
    printf("[ELF] ERROR: No section found for address %p\n", address);
    return -1;
  }

  if ((long long)sec->second.size() > len) {
    printf("[ELF] ERROR: Buffer holds 0x%llx bytes but the section is 0x%lx bytes.\n",
           len, sec->second.size());
    return -1;
  }

  memcpy(buf, sec->second.data(), sec->second.size());

  return 0;
}

template <class E, class P, class Sh, class Sy>
static void load_elf(char *buf, size_t size)
{
  E  *eh = (E *)   buf;
  P  *ph = (P *)  (buf + eh->e_phoff);
  Sh *sh = (Sh *) (buf + eh->e_shoff);

  char *shstrtab = NULL;

  if(size < eh->e_phoff + (eh->e_phnum * sizeof(P))){
    printf("[ELF] ERROR: Filesize is smaller than advertised program headers (0x%lx vs 0x%lx)\n", size, eh->e_phoff + (eh->e_phnum * sizeof(P)));
    return;
  }

  entry = eh->e_entry;
  printf("[ELF] INFO: Entrypoint at %p\n", entry);

  // Flatten every loadable segment into a byte-accurate image. Segment addresses
  // are only 4-byte aligned in practice (e.g. .data_tiny_l1 @ 0x1c01c19c), so they
  // cannot be handed to the TB as-is: its preload writes whole BUS_BYTES words and
  // would round the base down, shifting the payload and clobbering the neighbour.
  std::map<uint64_t, uint8_t> img;

  for (unsigned int i = 0; i < eh->e_phnum; i++) {
    if(ph[i].p_type == PT_LOAD && ph[i].p_memsz) {
      assert(size >= ph[i].p_offset + ph[i].p_filesz);
      const uint8_t *src = (const uint8_t *)buf + ph[i].p_offset;

      for (uint64_t k = 0; k < ph[i].p_filesz; k++)
        img[ph[i].p_paddr + k] = src[k];

      // .bss-style tail: preloaded as zeros
      for (uint64_t k = ph[i].p_filesz; k < ph[i].p_memsz; k++)
        img[ph[i].p_paddr + k] = 0;
    }
  }

  // Coalesce into BUS_BYTES-aligned, non-overlapping runs. Rounding a run outwards
  // can make it touch its neighbour (two segments sharing one bus word); merging
  // them here is what keeps the shared word from being written twice.
  uint64_t run_start = 0, run_end = 0;
  bool     in_run    = false;

  for (std::map<uint64_t, uint8_t>::const_iterator it = img.begin(); it != img.end(); ) {
    uint64_t start = it->first, end = start;
    while (it != img.end() && it->first == end) { end++; it++; }

    uint64_t aligned_start = start & ~(uint64_t)(BUS_BYTES - 1);
    uint64_t aligned_end   = (end + BUS_BYTES - 1) & ~(uint64_t)(BUS_BYTES - 1);

    if (in_run && aligned_start <= run_end) {
      if (aligned_end > run_end)
        run_end = aligned_end;
    } else {
      if (in_run)
        emit_run(run_start, run_end, img);
      run_start = aligned_start;
      run_end   = aligned_end;
      in_run    = true;
    }
  }

  if (in_run)
    emit_run(run_start, run_end, img);

  if(size < eh->e_shoff + (eh->e_shnum * sizeof(Sh))){
    printf("[ELF] ERROR: Filesize is smaller than advertised section headers (0x%lx vs 0x%lx)\n",
           size, eh->e_shoff + (eh->e_shnum * sizeof(Sh)));
    return;
  }

  if(eh->e_shstrndx >= eh->e_shnum){
    printf("[ELF] ERROR: Malformed ELF file. The index of the section header strings is out of bounds (0x%lx vs max 0x%lx)",
           eh->e_shstrndx, eh->e_shnum);
    return;
  }
  
  if(size < sh[eh->e_shstrndx].sh_offset + sh[eh->e_shstrndx].sh_size){
    printf("[ELF] ERROR: Filesize is smaller than advertised size of section name table (0x%lx vs 0x%lx)\n",
           size, sh[eh->e_shstrndx].sh_offset + sh[eh->e_shstrndx].sh_size);
    return;
  }

  // Get a direct pointer to the section name section
  shstrtab = buf + sh[eh->e_shstrndx].sh_offset;
  unsigned int strtabidx = 0, symtabidx = 0;

  // Iterate over all section headers to find .strtab and .symtab
  for (unsigned int i = 0; i < eh->e_shnum; i++) {
    // Get an upper limit on how long the name can be (length of the section name section minus the offset of the name)
    unsigned int max_len = sh[eh->e_shstrndx].sh_size - sh[i].sh_name;

    // Is this the string table?
    if(strcmp(shstrtab + sh[i].sh_name, ".strtab") == 0){
      printf("[ELF] INFO: Found string table at offset 0x%lx\n", sh[i].sh_offset);
      strtabidx = i;
      continue;
    }

    // Is this the symbol table?
    if(strcmp(shstrtab + sh[i].sh_name, ".symtab") == 0){
      printf("[ELF] INFO: Found symbol table at offset 0x%lx\n", sh[i].sh_offset);
      symtabidx = i;
      continue;
    }
  }
}

extern "C" char read_elf(const char *filename)
{
  char *buf = NULL;
  Elf64_Ehdr* eh64 = NULL;
  int fd = open(filename, O_RDONLY);
  char retval = 0;
  struct stat s;
  size_t size = 0;

  if(fd == -1){
    printf("[ELF] ERROR: Unable to open file %s\n", filename);
    retval = -1;
    goto exit;
  }

  if(fstat(fd, &s) < 0) {
    printf("[ELF] ERROR: Unable to read stats for file %s\n", filename);
    retval = -1;
    goto exit_fd;
  }

  size = s.st_size;

  if(size < sizeof(Elf64_Ehdr)){
    printf("[ELF] ERROR: File %s is too small to contain a valid ELF header (0x%lx vs 0x%lx)\n", filename, size, sizeof(Elf64_Ehdr));
    retval = -1;
    goto exit_fd;
  }

  buf = (char *) mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
  if(buf == MAP_FAILED){
    printf("[ELF] ERROR: Unable to memory map file %s\n", filename);
    retval = -1;
    goto exit_fd;
  }

  printf("[ELF] INFO: File %s was memory mapped to %p\n", filename, buf);

  eh64 = (Elf64_Ehdr *) buf;

  if(!(IS_ELF32(*eh64) || IS_ELF64(*eh64))){
    printf("[ELF] ERROR: File %s does not contain a valid ELF signature\n", filename);
    retval = -1;
    goto exit_mmap;
  }

  if (IS_ELF32(*eh64)){
    load_elf<Elf32_Ehdr, Elf32_Phdr, Elf32_Shdr, Elf32_Sym>(buf, size);
  } else {
    load_elf<Elf64_Ehdr, Elf64_Phdr, Elf64_Shdr, Elf64_Sym>(buf, size);
  }

exit_mmap:
  munmap(buf, size);

exit_fd:
  close(fd);

exit:
  return retval;
}
