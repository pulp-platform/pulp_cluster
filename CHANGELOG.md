# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- Added `CHANGELOG.md`

### Changed
- Align `Bender.yml` IPs to `ips_list.yml`
- Bump `fpu_interco` to unreleased version
- Bump `riscv` to `cv32e40p` for `pulp_soc` v3.0.0 compatibility
- Bump `axi` to v0.29.1
- Updated schematic in `doc`
- Changed tcdm_banks to `tc_sram` tech cell, remove explicit FPGA RAM instatiation. This is now supposed to be handled by tc_sram wrapping a Xilinx XPM.

### Removed
### Fixed
- ibex implementation
- ID compliance of tcdm_banks

## [2.0.0] - 2021-05-20
- Initial version prior to Changelog
