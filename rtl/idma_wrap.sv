// Copyright 2022 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51

/*
 * dmac_wrap.sv
 * Thomas Benz <tbenz@iis.ee.ethz.ch>
 * Michael Rogenmoser <michaero@iis.ee.ethz.ch>
 * Georg Rutishauser <georgr@iis.ee.ethz.ch>
 */

// DMA Core wrapper

`include "axi/assign.svh"
`include "axi/typedef.svh"
`include "obi/typedef.svh"
`include "idma/typedef.svh"
`include "register_interface/typedef.svh"

`define MY_MAX(a, b) (a > b ? a : b)

module dmac_wrap #(
  parameter int unsigned NB_CORES               = 4,
  parameter int unsigned AXI_ADDR_WIDTH         = 32,
  parameter int unsigned AXI_DATA_WIDTH         = 32,
  parameter int unsigned AXI_USER_WIDTH         = 6,
  parameter int unsigned AXI_ID_WIDTH           = 4,
  parameter int unsigned PE_ID_WIDTH            = 1,
  parameter int unsigned NB_PE_PORTS            = 1,
  parameter int unsigned DATA_WIDTH             = 32,
  parameter int unsigned ADDR_WIDTH             = 32,
  parameter int unsigned BE_WIDTH               = DATA_WIDTH / 8,
  parameter int unsigned IDMA_BURST_LENGTH      = 5,
  parameter type         axi_req_t              = logic,
  parameter type         axi_resp_t             = logic,
  // bidirectional streams: range 1 to 8
  parameter int unsigned NUM_BIDIR_STREAMS      = 1,
  parameter int unsigned NB_OUTSND_BURSTS       = 8,
  // queue depth per stream
  parameter int unsigned GLOBAL_QUEUE_DEPTH     = 2,
  // mux read ports between tcdm-tcdm and tcdm-axi?BeWidth
  parameter bit          MUX_READ               = 1'b0,
  parameter bit          TCDM_MEM2BANKS         = 1'b0,
  // when using mem2banks (implies AXI_DATA_WIDTH==64):
  // 4 ports per stream if read ports muxed, otherwise 6
  // when not using mem2banks:
  // 2 ports per stream if read ports muxed, otherwise 3
  localparam int unsigned NB_TCDM_PORTS_PER_STRM = (2 + (!MUX_READ)) * (1 + TCDM_MEM2BANKS)
) (  // verilog_format: off // verible does not manage to align this :(
  input logic                    clk_i,
  input logic                    rst_ni,
  input logic                    test_mode_i,
  XBAR_PERIPH_BUS.Slave          pe_ctrl_slave[NB_PE_PORTS-1:0],
  hci_core_intf.target           ctrl_slave[0:NB_CORES-1],
  hci_core_intf.initiator        tcdm_master[0:3],
  output                         axi_req_t [NUM_BIDIR_STREAMS-1:0] ext_master_req_o,
  input                          axi_resp_t [NUM_BIDIR_STREAMS-1:0] ext_master_resp_i,
  output logic [NB_CORES-1:0]    term_event_o,
  output logic [NB_CORES-1:0]    term_irq_o,
  output logic [NB_PE_PORTS-1:0] term_event_pe_o,
  output logic [NB_PE_PORTS-1:0] term_irq_pe_o,
  output logic                   busy_o
); // verilog_format: on

  localparam int unsigned NumRegs = NB_CORES + NB_PE_PORTS;
  localparam int unsigned NumStreams = 32'd2 * NUM_BIDIR_STREAMS;
  localparam int unsigned StreamWidth = cf_math_pkg::idx_width(NumStreams);

  // CORE --> MCHAN CTRL INTERFACE BUS SIGNALS
  logic [NumRegs-1:0][ DATA_WIDTH-1:0] config_wdata;
  logic [NumRegs-1:0][ ADDR_WIDTH-1:0] config_add;
  logic [NumRegs-1:0]                  config_req;
  logic [NumRegs-1:0]                  config_wen;
  logic [NumRegs-1:0][   BE_WIDTH-1:0] config_be;
  logic [NumRegs-1:0][PE_ID_WIDTH-1:0] config_id;
  logic [NumRegs-1:0]                  config_gnt;
  logic [NumRegs-1:0][ DATA_WIDTH-1:0] config_r_rdata;
  logic [NumRegs-1:0]                  config_r_valid;
  logic [NumRegs-1:0]                  config_r_opc;
  logic [NumRegs-1:0][PE_ID_WIDTH-1:0] config_r_id;

  // tie-off pe control ports
  for (genvar i = 0; i < NB_CORES; i++) begin : gen_ctrl_registers
    assign config_add[i]         = ctrl_slave[i].add;
    assign config_req[i]         = ctrl_slave[i].req;
    assign config_wdata[i]       = ctrl_slave[i].data;
    assign config_wen[i]         = ctrl_slave[i].wen;
    assign config_be[i]          = ctrl_slave[i].be;
    assign config_id[i]          = '0;
    assign ctrl_slave[i].gnt     = config_gnt[i];
    assign ctrl_slave[i].r_opc   = config_r_opc[i];
    assign ctrl_slave[i].r_valid = config_r_valid[i];
    assign ctrl_slave[i].r_data  = config_r_rdata[i];
  end

  for (genvar i = 0; i < NB_PE_PORTS; i++) begin : gen_pe_ctrl_registers
    assign config_add[NB_CORES+i]   = pe_ctrl_slave[i].add;
    assign config_req[NB_CORES+i]   = pe_ctrl_slave[i].req;
    assign config_wdata[NB_CORES+i] = pe_ctrl_slave[i].wdata;
    assign config_wen[NB_CORES+i]   = pe_ctrl_slave[i].wen;
    assign config_be[NB_CORES+i]    = pe_ctrl_slave[i].be;
    assign config_id[NB_CORES+i]    = pe_ctrl_slave[i].id;
    assign pe_ctrl_slave[i].gnt     = config_gnt[NB_CORES+i];
    assign pe_ctrl_slave[i].r_opc   = config_r_opc[NB_CORES+i];
    assign pe_ctrl_slave[i].r_valid = config_r_valid[NB_CORES+i];
    assign pe_ctrl_slave[i].r_rdata = config_r_rdata[NB_CORES+i];
    assign pe_ctrl_slave[i].r_id    = config_r_id[NB_CORES+i];
  end

  // Types types
  typedef logic [AXI_ADDR_WIDTH-1:0] addr_t;
  typedef logic [ADDR_WIDTH-1:0]     mem_addr_t;
  typedef logic [AXI_DATA_WIDTH-1:0] data_t;
  typedef logic [AXI_ID_WIDTH-1:0]   id_t;
  typedef logic [AXI_DATA_WIDTH/8-1:0] strb_t;
  typedef logic [AXI_USER_WIDTH-1:0]   user_t;

  // // AXI4+ATOP channels typedefs
  //`AXI_TYPEDEF_ALL(axi_int, addr_t, id_t, data_t, strb_t, user_t)
  `AXI_TYPEDEF_AW_CHAN_T(axi_aw_chan_t, addr_t, id_t, user_t)
  `AXI_TYPEDEF_W_CHAN_T(axi_w_chan_t, data_t, strb_t, user_t)
  `AXI_TYPEDEF_B_CHAN_T(axi_b_chan_t, id_t, user_t)
  `AXI_TYPEDEF_AR_CHAN_T(axi_ar_chan_t, addr_t, id_t, user_t)
  `AXI_TYPEDEF_R_CHAN_T(axi_r_chan_t, data_t, id_t, user_t)
  // Memory Init typedefs
  /// init read request
  typedef struct packed {
    logic [AXI_ADDR_WIDTH-1:0]   cfg;
    logic [AXI_DATA_WIDTH-1:0]   term;
    logic [AXI_DATA_WIDTH/8-1:0] strb;
    logic [AXI_ID_WIDTH-1:0]     id;
  } init_req_chan_t;

  typedef struct packed {
    init_req_chan_t req_chan;
    logic           req_valid;
    logic           rsp_ready;
  } init_req_t;

  typedef struct packed {logic [AXI_DATA_WIDTH-1:0] init;} init_rsp_chan_t;

  typedef struct packed {
    init_rsp_chan_t rsp_chan;
    logic           rsp_valid;
    logic           req_ready;
  } init_rsp_t;

  // OBI typedefs (ADDR_WIDTH)
  `OBI_TYPEDEF_MINIMAL_A_OPTIONAL(a_optional_t)
  `OBI_TYPEDEF_MINIMAL_R_OPTIONAL(r_optional_t)
  `OBI_TYPEDEF_A_CHAN_T(obi_a_chan_t, ADDR_WIDTH, AXI_DATA_WIDTH, AXI_ID_WIDTH, a_optional_t)
  `OBI_TYPEDEF_R_CHAN_T(obi_r_chan_t, AXI_DATA_WIDTH, AXI_ID_WIDTH, r_optional_t)
  `OBI_TYPEDEF_REQ_T(obi_req_t, obi_a_chan_t)
  `OBI_TYPEDEF_RSP_T(obi_rsp_t, obi_r_chan_t)

  obi_req_t [NUM_BIDIR_STREAMS-1:0]
    obi_read_req_from_dma,
    obi_read_req_from_rrc,
    obi_reorg_req_from_dma,
    obi_reorg_req_from_rrc,
    obi_write_req_from_dma,
    obi_write_req_from_rrc,
    obi_read_req_muxed;
  obi_rsp_t [NUM_BIDIR_STREAMS-1:0]
    obi_read_rsp_to_dma,
    obi_read_rsp_to_rrc,
    obi_reorg_rsp_to_dma,
    obi_reorg_rsp_to_rrc,
    obi_write_rsp_to_dma,
    obi_write_rsp_to_rrc,
    obi_read_rsp_to_mux;

  // OBI typedefs (AXI_ADDR_WIDTH)
  `OBI_TYPEDEF_A_CHAN_T(obi2axi_a_chan_t, AXI_ADDR_WIDTH, AXI_DATA_WIDTH, AXI_ID_WIDTH, a_optional_t)
  `OBI_TYPEDEF_REQ_T(obi2axi_req_t, obi2axi_a_chan_t)

  obi2axi_req_t [NUM_BIDIR_STREAMS-1:0]
    obi2axi_read_req_from_dma,
    obi2axi_reorg_req_from_dma,
    obi2axi_write_req_from_dma;

  // BUS definitions
  axi_req_t  [NUM_BIDIR_STREAMS-1:0] soc_req;
  axi_resp_t [NUM_BIDIR_STREAMS-1:0] soc_rsp;
  axi_req_t  [       NumStreams-1:0] dma_req;
  axi_resp_t [       NumStreams-1:0] dma_rsp;

  // interface to structs
  for (genvar s = 0; s < NUM_BIDIR_STREAMS; s++) begin : gen_connect_interface
    assign ext_master_req_o[s] = soc_req[s];
    assign soc_rsp[s]          = ext_master_resp_i[s];
  end

  // connect RW axi buses
  for (genvar s = 0; s < NUM_BIDIR_STREAMS; s++) begin : gen_rw_axi_connection

    assign dma_req[2*s].ar = '0;
    assign dma_req[2*s].ar_valid = '0;
    assign dma_req[2*s].r_ready = '0;

    assign dma_req[2*s+1].aw = '0;
    assign dma_req[2*s+1].aw_valid = '0;
    assign dma_req[2*s+1].w = '0;
    assign dma_req[2*s+1].w_valid = '0;
    assign dma_req[2*s+1].b_ready = '0;

    axi_rw_join #(
      .axi_req_t (axi_req_t),
      .axi_resp_t(axi_resp_t)
    ) i_init_axi_rw_join (
      .clk_i,
      .rst_ni,
      .slv_read_req_i  (dma_req[2*s+1]),
      .slv_read_resp_o (dma_rsp[2*s+1]),
      .slv_write_req_i (dma_req[2*s]),
      .slv_write_resp_o(dma_rsp[2*s]),
      .mst_req_o       (soc_req[s]),
      .mst_resp_i      (soc_rsp[s])
    );
  end

  // Register BUS definitions
  localparam int unsigned RegAddrWidth = 32'd10;
  `REG_BUS_TYPEDEF_ALL(dma_regs, logic[RegAddrWidth-1:0], logic[DATA_WIDTH-1:0],
    logic[BE_WIDTH-1:0])
  dma_regs_req_t [NumRegs-1:0] dma_regs_req;
  dma_regs_rsp_t [NumRegs-1:0] dma_regs_rsp;

  // iDMA struct definitions
  localparam int unsigned TFLenWidth = AXI_ADDR_WIDTH;
  localparam int unsigned NumDim = 32'd3;  // Support 2D midend for 2D transfers
  localparam int unsigned RepWidth = 32'd32;
  localparam int unsigned StrideWidth = 32'd32;
  typedef logic [TFLenWidth-1:0] tf_len_t;
  typedef logic [RepWidth-1:0]   reps_t;
  typedef logic [StrideWidth-1:0] strides_t;

  typedef logic [StreamWidth-1:0] stream_width_t;

  // iDMA request / response types
  `IDMA_TYPEDEF_FULL_REQ_T(idma_req_t, id_t, addr_t, tf_len_t)
  `IDMA_TYPEDEF_FULL_RSP_T(idma_rsp_t, addr_t)

  // iDMA ND request
  `IDMA_TYPEDEF_FULL_ND_REQ_T(idma_nd_req_t, idma_req_t, reps_t, strides_t)

  logic [StreamWidth-1:0] stream_idx;

  idma_nd_req_t [NumStreams-1:0] twod_req_queue;
  idma_nd_req_t  twod_req;
  idma_req_t [NumStreams-1:0] idma_req;
  idma_rsp_t [NumStreams-1:0] idma_rsp;

  logic                       one_fe_valid;
  logic [NumStreams-1:0]      fe_valid, twod_queue_valid, be_valid, be_rsp_valid;
  logic [NumStreams-1:0]      fe_ready, twod_queue_ready, be_ready, be_rsp_ready;
  logic [NumStreams-1:0]      trans_complete, midend_busy;
  idma_pkg::idma_busy_t [NumStreams-1:0] idma_busy;

  logic [NumStreams-1:0][31:0] done_id, next_id;

  // ------------------------------------------------------
  // FRONTEND
  // ------------------------------------------------------

  for (genvar i = 0; i < NumRegs; i++) begin : gen_core_regs
    periph_to_reg #(
      .AW   (RegAddrWidth),
      .DW   (DATA_WIDTH),
      .BW   (BE_WIDTH<<1),
      .IW   (PE_ID_WIDTH),
      .req_t(dma_regs_req_t),
      .rsp_t(dma_regs_rsp_t)
    ) i_pe_translate (
      .clk_i,
      .rst_ni,
      .req_i    (config_req[i]),
      .add_i    (config_add[i][RegAddrWidth-1:0]),
      .wen_i    (config_wen[i]),
      .wdata_i  (config_wdata[i]),
      .be_i     (config_be[i]),
      .id_i     (config_id[i]),
      .gnt_o    (config_gnt[i]),
      .r_rdata_o(config_r_rdata[i]),
      .r_opc_o  (config_r_opc[i]),
      .r_id_o   (config_r_id[i]),
      .r_valid_o(config_r_valid[i]),
      .reg_req_o(dma_regs_req[i]),
      .reg_rsp_i(dma_regs_rsp[i])
    );
  end

  idma_reg32_3d #(
    .NumRegs       (NumRegs),
    .NumStreams    (NumStreams),
    .IdCounterWidth(32'd32),
    .reg_req_t     (dma_regs_req_t),
    .reg_rsp_t     (dma_regs_rsp_t),
    .dma_req_t     (idma_nd_req_t)
  ) i_idma_reg32_3d (
    .clk_i,
    .rst_ni,
    .dma_ctrl_req_i(dma_regs_req),
    .dma_ctrl_rsp_o(dma_regs_rsp),
    .dma_req_o     (twod_req),
    .req_valid_o   (one_fe_valid),
    .req_ready_i   (fe_ready[stream_idx]),
    .next_id_i     (next_id[stream_idx]),
    .stream_idx_o  (stream_idx),
    .done_id_i     (done_id),
    .busy_i        (idma_busy),
    .midend_busy_i (midend_busy)
  );

  always_comb begin : proc_connect_valids
    fe_valid             = '0;
    fe_valid[stream_idx] = one_fe_valid;
  end

  // interrupts and events (currently broadcast tx_cplt event only)
  assign term_event_pe_o = |trans_complete ? '1 : '0;
  assign term_irq_pe_o   = '0;
  assign term_event_o    = |trans_complete ? '1 : '0;
  assign term_irq_o      = '0;

  assign busy_o          = |midend_busy | |idma_busy;

  localparam int unsigned ID_WIDTH = 32;

  for (genvar s = 0; s < NumStreams; s++) begin : gen_streams

    // ------------------------------------------------------
    // ID counters
    // ------------------------------------------------------
    idma_transfer_id_gen #(
      .IdWidth(ID_WIDTH)
    ) i_idma_transfer_id_gen (
      .clk_i,
      .rst_ni,
      .issue_i    (fe_valid[s] & fe_ready[s]),
      .retire_i   (trans_complete[s]),
      .next_o     (next_id[s]),
      .completed_o(done_id[s])
    );


    // ------------------------------------------------------
    // MIDEND
    // ------------------------------------------------------
    // global (2D) request FIFO
    stream_fifo #(
      .DEPTH(GLOBAL_QUEUE_DEPTH),
      .T    (idma_nd_req_t)
    ) i_3D_request_fifo (
      .clk_i,
      .rst_ni,
      .flush_i   (1'b0),
      .testmode_i(test_mode_i),
      .usage_o   (  /*NOT CONNECTED*/),
      .data_i    (twod_req),
      .valid_i   (fe_valid[s]),
      .ready_o   (fe_ready[s]),
      .data_o    (twod_req_queue[s]),
      .valid_o   (twod_queue_valid[s]),
      .ready_i   (twod_queue_ready[s])
    );

    localparam logic [1:0][31:0] RepWidths = '{default: 32'd32};

    idma_nd_midend #(
      .NumDim       (NumDim),
      .addr_t       (addr_t),
      .idma_req_t   (idma_req_t),
      .idma_rsp_t   (idma_rsp_t),
      .idma_nd_req_t(idma_nd_req_t),
      .RepWidths    (RepWidths)
    ) i_idma_3D_midend (
      .clk_i,
      .rst_ni,
      .nd_req_i         (twod_req_queue[s]),
      .nd_req_valid_i   (twod_queue_valid[s]),
      .nd_req_ready_o   (twod_queue_ready[s]),
      .nd_rsp_o         (  /*NOT CONNECTED*/),
      .nd_rsp_valid_o   (trans_complete[s]),
      .nd_rsp_ready_i   (1'b1),                 // Always ready to accept completed transfers
      .burst_req_o      (idma_req[s]),
      .burst_req_valid_o(be_valid[s]),
      .burst_req_ready_i(be_ready[s]),
      .burst_rsp_i      (idma_rsp[s]),
      .burst_rsp_valid_i(be_rsp_valid[s]),
      .burst_rsp_ready_o(be_rsp_ready[s]),
      .busy_o           (midend_busy[s])
    );

    // ------------------------------------------------------
    // BACKEND
    // ------------------------------------------------------

    // even channels: copy out data
    if (s[0] == 1'b0) begin : gen_cpy_out

      // Meta Channel Widths
      localparam int unsigned axi_aw_chan_width = axi_pkg::aw_width(
        AXI_ADDR_WIDTH, AXI_ID_WIDTH, AXI_USER_WIDTH
      );
      localparam int unsigned init_req_chan_width = $bits(init_req_chan_t);
      localparam int unsigned obi_a_chan_width = $bits(obi_a_chan_t);


      typedef struct packed {
        init_req_chan_t req_chan;
        logic [`MY_MAX(init_req_chan_width, obi_a_chan_width)-init_req_chan_width:0] padding;
      } init_read_req_chan_padded_t;

      typedef struct packed {
        obi_a_chan_t a_chan;
        logic [`MY_MAX(init_req_chan_width, obi_a_chan_width)-obi_a_chan_width:0] padding;
      } obi_read_a_chan_padded_t;

      typedef union packed {
        init_read_req_chan_padded_t init;
        obi_read_a_chan_padded_t obi;
      } read_meta_channel_t;

      typedef struct packed {
        axi_aw_chan_t aw_chan;
        logic [`MY_MAX(axi_aw_chan_width, init_req_chan_width)-axi_aw_chan_width:0] padding;
      } axi_write_aw_chan_padded_t;

      typedef struct packed {
        init_req_chan_t req_chan;
        logic [`MY_MAX(axi_aw_chan_width, init_req_chan_width)-init_req_chan_width:0] padding;
      } init_write_req_chan_padded_t;

      typedef union packed {
        axi_write_aw_chan_padded_t   axi;
        init_write_req_chan_padded_t init;
      } write_meta_channel_t;

      // local buses
      init_req_t init_read_req, init_write_req;
      init_rsp_t init_read_rsp, init_write_rsp;

      // BINDING between ADD_WIDTH <-> AXI_ADDR_WIDTH
      assign obi_read_req_from_dma[s/2].req     = obi2axi_read_req_from_dma[s/2].req    ;
      assign obi_read_req_from_dma[s/2].a.addr  = obi2axi_read_req_from_dma[s/2].a.addr ;
      assign obi_read_req_from_dma[s/2].a.we    = obi2axi_read_req_from_dma[s/2].a.we   ;
      assign obi_read_req_from_dma[s/2].a.be    = obi2axi_read_req_from_dma[s/2].a.be   ;
      assign obi_read_req_from_dma[s/2].a.wdata = obi2axi_read_req_from_dma[s/2].a.wdata;
      assign obi_read_req_from_dma[s/2].rready  = obi2axi_read_req_from_dma[s/2].rready ;

      idma_backend_synth_r_obi_rw_init_w_axi #(
        .DataWidth           ( AXI_DATA_WIDTH    ),
        .AddrWidth           ( AXI_ADDR_WIDTH    ),
        .UserWidth           ( AXI_USER_WIDTH    ),
        .AxiIdWidth          ( AXI_ID_WIDTH      ),
        .NumAxInFlight       ( NB_OUTSND_BURSTS  ),
        .BufferDepth         ( 32'd3             ),
        .TFLenWidth          ( TFLenWidth        ),
        .MemSysDepth         ( 32'd0             ),
        .CombinedShifter     ( 1'b0              ),
        .RAWCouplingAvail    ( 1'b0              ),
        .MaskInvalidData     ( 1'b0              ),
        .HardwareLegalizer   ( 1'b1              ),
        .RejectZeroTransfers ( 1'b1              ),
        .ErrorHandling       ( 1'b0              ),
        .Burst_len           ( IDMA_BURST_LENGTH )
      ) i_idma_backend_r_obi_rw_init_w_axi (
        .clk_i              ( clk_i                                   ),
        .rst_ni             ( rst_ni                                  ),
        .test_i             ( test_mode_i                             ),
        .req_valid_i        ( be_valid[s]                             ),
        .req_ready_o        ( be_ready[s]                             ),
        .req_length_i       ( idma_req[s].length                      ),
        .req_src_addr_i     ( idma_req[s].src_addr                    ),
        .req_dst_addr_i     ( idma_req[s].dst_addr                    ),
        .req_src_protocol_i ( idma_req[s].opt.src_protocol            ),
        .req_dst_protocol_i ( idma_req[s].opt.dst_protocol            ),
        .req_axi_id_i       ( idma_req[s].opt.axi_id                  ),
        .req_src_burst_i    ( idma_req[s].opt.src.burst               ),
        .req_src_cache_i    ( idma_req[s].opt.src.cache               ),
        .req_src_lock_i     ( idma_req[s].opt.src.lock                ),
        .req_src_prot_i     ( idma_req[s].opt.src.prot                ),
        .req_src_qos_i      ( idma_req[s].opt.src.qos                 ),
        .req_src_region_i   ( idma_req[s].opt.src.region              ),
        .req_dst_burst_i    ( idma_req[s].opt.dst.burst               ),
        .req_dst_cache_i    ( idma_req[s].opt.dst.cache               ),
        .req_dst_lock_i     ( idma_req[s].opt.dst.lock                ),
        .req_dst_prot_i     ( idma_req[s].opt.dst.prot                ),
        .req_dst_qos_i      ( idma_req[s].opt.dst.qos                 ),
        .req_dst_region_i   ( idma_req[s].opt.dst.region              ),
        .req_decouple_aw_i  ( idma_req[s].opt.beo.decouple_aw         ),
        .req_decouple_rw_i  ( idma_req[s].opt.beo.decouple_rw         ),
        .req_src_max_llen_i ( idma_req[s].opt.beo.src_max_llen        ),
        .req_dst_max_llen_i ( idma_req[s].opt.beo.dst_max_llen        ),
        .req_src_reduce_len_i ( idma_req[s].opt.beo.src_reduce_len    ),
        .req_dst_reduce_len_i ( idma_req[s].opt.beo.dst_reduce_len    ),
        .req_last_i         ( idma_req[s].opt.last                    ),
        .rsp_valid_o        ( be_rsp_valid[s]                         ),
        .rsp_ready_i        ( be_rsp_ready[s]                         ),
        .rsp_cause_o        ( idma_rsp[s].pld.cause                   ),
        .rsp_err_type_o     ( idma_rsp[s].pld.err_type                ),
        .rsp_burst_addr_o   ( idma_rsp[s].pld.burst_addr              ),
        .rsp_error_o        ( idma_rsp[s].error                       ),
        .rsp_last_o         ( idma_rsp[s].last                        ),

        .eh_req_valid_i         ( '0                                  ),
        .eh_req_ready_o         (  /* NOT CONNECTED */                ),
        .eh_req_i               ( '0                                  ),

        .init_read_req_valid_o  ( init_read_req.req_valid             ),
        .init_read_req_config_o ( init_read_req.req_chan.cfg          ),
        .init_read_req_ready_i  ( init_read_rsp.req_ready             ),

        .init_read_rsp_valid_i  ( init_read_rsp.rsp_valid             ),
        .init_read_rsp_init_i   ( init_read_rsp.rsp_chan.init         ),
        .init_read_rsp_ready_o  ( init_read_req.rsp_ready             ),

        .obi_read_req_a_req_o   ( obi2axi_read_req_from_dma[s/2].req      ),
        .obi_read_req_a_addr_o  ( obi2axi_read_req_from_dma[s/2].a.addr   ),
        .obi_read_req_a_we_o    ( obi2axi_read_req_from_dma[s/2].a.we     ),
        .obi_read_req_a_be_o    ( obi2axi_read_req_from_dma[s/2].a.be     ),
        .obi_read_req_a_wdata_o ( obi2axi_read_req_from_dma[s/2].a.wdata  ),
        .obi_read_req_r_ready_o ( obi2axi_read_req_from_dma[s/2].rready   ),

        .obi_read_rsp_a_gnt_i   ( obi_read_rsp_to_dma[s/2].gnt        ),
        .obi_read_rsp_r_valid_i ( obi_read_rsp_to_dma[s/2].rvalid     ),
        .obi_read_rsp_r_rdata_i ( obi_read_rsp_to_dma[s/2].r.rdata    ),
        .obi_read_rsp_r_rid_i   ( obi_read_rsp_to_dma[s/2].r.rid      ),
        .obi_read_rsp_r_err_i   ( obi_read_rsp_to_dma[s/2].r.err      ),

        .axi_aw_id_o            ( dma_req[s].aw.id                    ),
        .axi_aw_addr_o          ( dma_req[s].aw.addr                  ),
        .axi_aw_len_o           ( dma_req[s].aw.len                   ),
        .axi_aw_size_o          ( dma_req[s].aw.size                  ),
        .axi_aw_burst_o         ( dma_req[s].aw.burst                 ),
        .axi_aw_lock_o          ( dma_req[s].aw.lock                  ),
        .axi_aw_cache_o         ( dma_req[s].aw.cache                 ),
        .axi_aw_prot_o          ( dma_req[s].aw.prot                  ),
        .axi_aw_qos_o           ( dma_req[s].aw.qos                   ),
        .axi_aw_region_o        ( dma_req[s].aw.region                ),
        .axi_aw_atop_o          ( dma_req[s].aw.atop                  ),
        .axi_aw_user_o          ( dma_req[s].aw.user                  ),
        .axi_aw_valid_o         ( dma_req[s].aw_valid                 ),
        .axi_w_data_o           ( dma_req[s].w.data                   ),
        .axi_w_strb_o           ( dma_req[s].w.strb                   ),
        .axi_w_last_o           ( dma_req[s].w.last                   ),
        .axi_w_user_o           ( dma_req[s].w.user                   ),
        .axi_w_valid_o          ( dma_req[s].w_valid                  ),
        .axi_b_ready_o          ( dma_req[s].b_ready                  ),

        .axi_aw_ready_i         ( dma_rsp[s].aw_ready                 ),
        .axi_w_ready_i          ( dma_rsp[s].w_ready                  ),
        .axi_b_id_i             ( dma_rsp[s].b.id                     ),
        .axi_b_resp_i           ( dma_rsp[s].b.resp                   ),
        .axi_b_user_i           ( dma_rsp[s].b.user                   ),
        .axi_b_valid_i          ( dma_rsp[s].b_valid                  ),

        .init_write_req_valid_o ( init_write_req.req_valid            ),
        .init_write_req_cfg_o   ( init_write_req.req_chan.cfg         ),
        .init_write_req_term_o  ( init_write_req.req_chan.term        ),
        .init_write_req_strb_o  ( init_write_req.req_chan.strb        ),
        .init_write_req_id_o    ( init_write_req.req_chan.id          ),
        .init_write_req_ready_i ( init_write_rsp.req_ready            ),

        .init_write_rsp_valid_i ( init_write_rsp.rsp_valid            ),
        .init_write_rsp_ready_o ( init_write_req.rsp_ready            ),
        .idma_busy_o            ( idma_busy[s]                        )
      );

      // use a spill register to only give responses when a request was
      // (or is) asserted
      spill_register #(
        .T(logic)
      ) i_init_read_rsp_reflect (
        .clk_i,
        .rst_ni,
        .valid_i(init_read_req.req_valid),
        .ready_o(init_read_rsp.req_ready),
        .data_i('0),  // not used
        .valid_o(init_read_rsp.rsp_valid),
        .ready_i(init_read_req.rsp_ready),
        .data_o()
      );

      //implement zero memory using init protocol
      assign init_read_rsp.rsp_chan.init = '0;
      // implement /dev/null
      spill_register #(
        .T(logic)
      ) i_init_write_rsp_reflect (
        .clk_i,
        .rst_ni,
        .valid_i(init_write_req.req_valid),
        .ready_o(init_write_rsp.req_ready),
        .data_i('0),  // not used
        .valid_o(init_write_rsp.rsp_valid),
        .ready_i(init_write_req.rsp_ready),
        .data_o()
      );

      assign init_write_rsp.rsp_chan.init = '0;

      // odd channels: copy in data
    end else begin : gen_cpy_in

      // Meta Channel Widths
      localparam int unsigned axi_ar_chan_width = axi_pkg::ar_width(
        AXI_ADDR_WIDTH, AXI_ID_WIDTH, AXI_USER_WIDTH
      );
      localparam int unsigned init_req_chan_width = $bits(init_req_chan_t);
      localparam int unsigned obi_a_chan_width = $bits(obi_a_chan_t);

      function int unsigned max_width(input int unsigned a, b);
        return (a > b) ? a : b;
      endfunction

      typedef struct packed {
        axi_ar_chan_t ar_chan;
        logic [
          `MY_MAX(
          axi_ar_chan_width, `MY_MAX(init_req_chan_width, obi_a_chan_width)
        )
          -axi_ar_chan_width:0] padding;
      } axi_read_ar_chan_padded_t;

      typedef struct packed {
        init_req_chan_t req_chan;
        logic [
          `MY_MAX(axi_ar_chan_width, `MY_MAX(init_req_chan_width, obi_a_chan_width))
          -init_req_chan_width:0] padding;
      } init_read_req_chan_padded_t;

      typedef struct packed {
        obi_a_chan_t a_chan;
        logic [
          `MY_MAX(axi_ar_chan_width, `MY_MAX(init_req_chan_width, obi_a_chan_width))
          -obi_a_chan_width:0] padding;
      } obi_read_a_chan_padded_t;

      typedef union packed {
        axi_read_ar_chan_padded_t axi;
        init_read_req_chan_padded_t init;
        obi_read_a_chan_padded_t obi;
      } read_meta_channel_t;

      typedef struct packed {
        init_req_chan_t req_chan;
        logic [`MY_MAX(init_req_chan_width, obi_a_chan_width)-init_req_chan_width:0] padding;
      } init_write_req_chan_padded_t;

      typedef struct packed {
        obi_a_chan_t a_chan;
        logic [`MY_MAX(init_req_chan_width, obi_a_chan_width)-obi_a_chan_width:0] padding;
      } obi_write_a_chan_padded_t;

      typedef union packed {
        init_write_req_chan_padded_t init;
        obi_write_a_chan_padded_t obi;
      } write_meta_channel_t;

      // local buses
      init_req_t init_read_req, init_write_req;
      init_rsp_t init_read_rsp, init_write_rsp;

      // BINDING between ADD_WIDTH <-> AXI_ADDR_WIDTH
      assign obi_reorg_req_from_dma[s/2].req     = obi2axi_reorg_req_from_dma[s/2].req    ;
      assign obi_reorg_req_from_dma[s/2].a.addr  = obi2axi_reorg_req_from_dma[s/2].a.addr ;
      assign obi_reorg_req_from_dma[s/2].a.we    = obi2axi_reorg_req_from_dma[s/2].a.we   ;
      assign obi_reorg_req_from_dma[s/2].a.be    = obi2axi_reorg_req_from_dma[s/2].a.be   ;
      assign obi_reorg_req_from_dma[s/2].a.wdata = obi2axi_reorg_req_from_dma[s/2].a.wdata;
      assign obi_reorg_req_from_dma[s/2].rready  = obi2axi_reorg_req_from_dma[s/2].rready ;

      assign obi_write_req_from_dma[s/2].req     = obi2axi_write_req_from_dma[s/2].req    ;
      assign obi_write_req_from_dma[s/2].a.addr  = obi2axi_write_req_from_dma[s/2].a.addr ;
      assign obi_write_req_from_dma[s/2].a.we    = obi2axi_write_req_from_dma[s/2].a.we   ;
      assign obi_write_req_from_dma[s/2].a.be    = obi2axi_write_req_from_dma[s/2].a.be   ;
      assign obi_write_req_from_dma[s/2].a.wdata = obi2axi_write_req_from_dma[s/2].a.wdata;
      assign obi_write_req_from_dma[s/2].rready  = obi2axi_write_req_from_dma[s/2].rready ;

      idma_backend_synth_r_axi_rw_init_rw_obi #(
        .DataWidth           (AXI_DATA_WIDTH),
        .AddrWidth           (AXI_ADDR_WIDTH),
        .UserWidth           (AXI_USER_WIDTH),
        .AxiIdWidth          (AXI_ID_WIDTH),
        .NumAxInFlight       (NB_OUTSND_BURSTS),
        .BufferDepth         (32'd3),
        .TFLenWidth          (TFLenWidth),
        .MemSysDepth         (32'd0),
        .CombinedShifter     (1'b0),
        .RAWCouplingAvail    (1'b0),
        .MaskInvalidData     (1'b0),
        .HardwareLegalizer   (1'b1),
        .RejectZeroTransfers (1'b1),
        .ErrorHandling       (1'b0)
      ) i_idma_backend_r_axi_rw_init_rw_obi (
        .clk_i              ( clk_i                                   ),
        .rst_ni             ( rst_ni                                  ),
        .test_i             ( test_mode_i                             ),
        .req_valid_i        ( be_valid[s]                             ),
        .req_ready_o        ( be_ready[s]                             ),
        .req_length_i       ( idma_req[s].length                      ),
        .req_src_addr_i     ( idma_req[s].src_addr                    ),
        .req_dst_addr_i     ( idma_req[s].dst_addr                    ),
        .req_src_protocol_i ( idma_req[s].opt.src_protocol            ),
        .req_dst_protocol_i ( idma_req[s].opt.dst_protocol            ),
        .req_axi_id_i       ( idma_req[s].opt.axi_id                  ),
        .req_src_burst_i    ( idma_req[s].opt.src.burst               ),
        .req_src_cache_i    ( idma_req[s].opt.src.cache               ),
        .req_src_lock_i     ( idma_req[s].opt.src.lock                ),
        .req_src_prot_i     ( idma_req[s].opt.src.prot                ),
        .req_src_qos_i      ( idma_req[s].opt.src.qos                 ),
        .req_src_region_i   ( idma_req[s].opt.src.region              ),
        .req_dst_burst_i    ( idma_req[s].opt.dst.burst               ),
        .req_dst_cache_i    ( idma_req[s].opt.dst.cache               ),
        .req_dst_lock_i     ( idma_req[s].opt.dst.lock                ),
        .req_dst_prot_i     ( idma_req[s].opt.dst.prot                ),
        .req_dst_qos_i      ( idma_req[s].opt.dst.qos                 ),
        .req_dst_region_i   ( idma_req[s].opt.dst.region              ),
        .req_decouple_aw_i  ( idma_req[s].opt.beo.decouple_aw         ),
        .req_decouple_rw_i  ( idma_req[s].opt.beo.decouple_rw         ),
        .req_src_max_llen_i ( idma_req[s].opt.beo.src_max_llen        ),
        .req_dst_max_llen_i ( idma_req[s].opt.beo.dst_max_llen        ),
        .req_src_reduce_len_i ( idma_req[s].opt.beo.src_reduce_len    ),
        .req_dst_reduce_len_i ( idma_req[s].opt.beo.dst_reduce_len    ),
        .req_last_i         ( idma_req[s].opt.last                    ),
        .rsp_valid_o        ( be_rsp_valid[s]                         ),
        .rsp_ready_i        ( be_rsp_ready[s]                         ),
        .rsp_cause_o        ( idma_rsp[s].pld.cause                   ),
        .rsp_err_type_o     ( idma_rsp[s].pld.err_type                ),
        .rsp_burst_addr_o   ( idma_rsp[s].pld.burst_addr              ),
        .rsp_error_o        ( idma_rsp[s].error                       ),
        .rsp_last_o         ( idma_rsp[s].last                        ),

        .eh_req_valid_i         ( '0                                  ),
        .eh_req_ready_o         (  /* NOT CONNECTED */                ),
        .eh_req_i               ( '0                                  ),

        .axi_ar_id_o        ( dma_req[s].ar.id                          ),
        .axi_ar_addr_o      ( dma_req[s].ar.addr                        ),
        .axi_ar_len_o       ( dma_req[s].ar.len                         ),
        .axi_ar_size_o      ( dma_req[s].ar.size                        ),
        .axi_ar_burst_o     ( dma_req[s].ar.burst                       ),
        .axi_ar_lock_o      ( dma_req[s].ar.lock                        ),
        .axi_ar_cache_o     ( dma_req[s].ar.cache                       ),
        .axi_ar_prot_o      ( dma_req[s].ar.prot                        ),
        .axi_ar_qos_o       ( dma_req[s].ar.qos                         ),
        .axi_ar_region_o    ( dma_req[s].ar.region                      ),
        .axi_ar_user_o      ( dma_req[s].ar.user                        ),
        .axi_ar_valid_o     ( dma_req[s].ar_valid                       ),
        .axi_r_ready_o      ( dma_req[s].r_ready                        ),

        .axi_ar_ready_i     ( dma_rsp[s].ar_ready                       ),
        .axi_r_id_i         ( dma_rsp[s].r.id                           ),
        .axi_r_data_i       ( dma_rsp[s].r.data                         ),
        .axi_r_resp_i       ( dma_rsp[s].r.resp                         ),
        .axi_r_last_i       ( dma_rsp[s].r.last                         ),
        .axi_r_user_i       ( dma_rsp[s].r.user                         ),
        .axi_r_valid_i      ( dma_rsp[s].r_valid                        ),

        .init_read_req_valid_o  ( init_read_req.req_valid               ),
        .init_read_req_config_o ( init_read_req.req_chan.cfg            ),
        .init_read_req_ready_i  ( init_read_rsp.req_ready               ),

        .init_read_rsp_valid_i (init_read_rsp.rsp_valid                 ),
        .init_read_rsp_init_i  ( init_read_rsp.rsp_chan.init            ),
        .init_read_rsp_ready_o ( init_read_req.rsp_ready                ),

        .obi_read_req_a_req_o   ( obi2axi_reorg_req_from_dma[s/2].req       ),
        .obi_read_req_a_addr_o  ( obi2axi_reorg_req_from_dma[s/2].a.addr    ),
        .obi_read_req_a_we_o    ( obi2axi_reorg_req_from_dma[s/2].a.we      ),
        .obi_read_req_a_be_o    ( obi2axi_reorg_req_from_dma[s/2].a.be      ),
        .obi_read_req_a_wdata_o ( obi2axi_reorg_req_from_dma[s/2].a.wdata   ),
        .obi_read_req_r_ready_o ( obi2axi_reorg_req_from_dma[s/2].rready    ),

        .obi_read_rsp_a_gnt_i   ( obi_reorg_rsp_to_dma[s/2].gnt         ),
        .obi_read_rsp_r_valid_i ( obi_reorg_rsp_to_dma[s/2].rvalid      ),
        .obi_read_rsp_r_rdata_i ( obi_reorg_rsp_to_dma[s/2].r.rdata     ),
        .obi_read_rsp_r_rid_i   ( obi_reorg_rsp_to_dma[s/2].r.rid       ),
        .obi_read_rsp_r_err_i   ( obi_reorg_rsp_to_dma[s/2].r.err       ),

        .init_write_req_valid_o ( init_write_req.req_valid              ),
        .init_write_req_cfg_o   ( init_write_req.req_chan.cfg           ),
        .init_write_req_term_o  ( init_write_req.req_chan.term          ),
        .init_write_req_strb_o  ( init_write_req.req_chan.strb          ),
        .init_write_req_id_o    ( init_write_req.req_chan.id            ),
        .init_write_req_ready_i (init_write_rsp.req_ready               ),

        .init_write_rsp_valid_i ( init_write_rsp.rsp_valid              ),
        .init_write_rsp_ready_o (init_write_req.rsp_ready               ),

        .obi_write_req_a_req_o    ( obi2axi_write_req_from_dma[s/2].req     ),
        .obi_write_req_a_addr_o   ( obi2axi_write_req_from_dma[s/2].a.addr  ),
        .obi_write_req_a_we_o     ( obi2axi_write_req_from_dma[s/2].a.we    ),
        .obi_write_req_a_be_o     ( obi2axi_write_req_from_dma[s/2].a.be    ),
        .obi_write_req_a_wdata_o  ( obi2axi_write_req_from_dma[s/2].a.wdata ),
        .obi_write_req_a_aid_o    ( obi2axi_write_req_from_dma[s/2].a.aid   ),
        .obi_write_req_r_ready_o  ( obi2axi_write_req_from_dma[s/2].rready  ),

        .obi_write_rsp_a_gnt_i    ( obi_write_rsp_to_dma[s/2].gnt       ),
        .obi_write_rsp_r_valid_i  ( obi_write_rsp_to_dma[s/2].rvalid    ),
        .obi_write_rsp_r_rdata_i  ( obi_write_rsp_to_dma[s/2].r.rdata   ),

        .idma_busy_o              ( idma_busy[s]                        )
      );

      // use a spill register to only give responses when a request was
      // (or is) asserted
      spill_register #(
        .T(logic)
      ) i_init_read_rsp_reflect (
        .clk_i,
        .rst_ni,
        .valid_i(init_read_req.req_valid),
        .ready_o(init_read_rsp.req_ready),
        .data_i('0),  // not used
        .valid_o(init_read_rsp.rsp_valid),
        .ready_i(init_read_req.rsp_ready),
        .data_o()
      );
      //implement zero memory using init protocol
      assign init_read_rsp.rsp_chan.init = '0;
      // implement /dev/null
      spill_register #(
        .T(logic)
      ) i_init_write_rsp_reflect (
        .clk_i,
        .rst_ni,
        .valid_i(init_write_req.req_valid),
        .ready_o(init_write_rsp.req_ready),
        .data_i('0),  // not used
        .valid_o(init_write_rsp.rsp_valid),
        .ready_i(init_write_req.rsp_ready),
        .data_o()
      );
      assign init_write_rsp.rsp_chan.init = '0;
    end : gen_cpy_in
  end : gen_streams


  // ------------------------------------------------------
  // MUX read OBI connections if specified
  // ------------------------------------------------------
  for (genvar s = 0; s < NUM_BIDIR_STREAMS; s++) begin
    if (MUX_READ) begin
      localparam obi_pkg::obi_cfg_t sbr_obi_cfg = '{
        UseRReady: 1'b1,
        CombGnt: 1'b0,
        AddrWidth: ADDR_WIDTH,
        DataWidth: AXI_DATA_WIDTH,
        IdWidth: 1,
        Integrity: 1'b0,
        BeFull: 1'b1,
        OptionalCfg: obi_pkg::ObiMinimalOptionalConfig
      };

      // iDMA OBI

      obi_mux #(
        .SbrPortObiCfg       ( sbr_obi_cfg   ),
        .MgrPortObiCfg       ( sbr_obi_cfg   ),
        .sbr_port_obi_req_t  ( obi_req_t     ),
        .sbr_port_a_chan_t   ( obi_a_chan_t  ),
        .sbr_port_obi_rsp_t  ( obi_rsp_t     ),
        .sbr_port_r_chan_t   ( obi_r_chan_t  ),
        .mgr_port_obi_req_t  ( obi_req_t     ),
        .mgr_port_obi_rsp_t  ( obi_rsp_t     ),
        .NumSbrPorts         ( 2             ),
        .NumMaxTrans         ( 2             ),
        .UseIdForRouting     ( 1'b0          )
      ) obi_read_mux_i (
        .clk_i,
        .rst_ni,
        .testmode_i     (test_mode_i),
        .sbr_ports_req_i({obi_reorg_req_from_dma[s], obi_read_req_from_dma[s]}),
        .sbr_ports_rsp_o({obi_reorg_rsp_to_dma[s], obi_read_rsp_to_dma[s]}),
        .mgr_port_req_o (obi_read_req_muxed[s]),
        .mgr_port_rsp_i (obi_read_rsp_to_mux[s])
      );
      assign obi_reorg_req_from_rrc[s] = '0;
      assign obi_reorg_rsp_to_rrc[s]   = '0;
    end else begin  // if (MUX_READ)
      // pass through the read req/rsp from/to dma
      assign obi_read_req_muxed[s]  = obi_read_req_from_dma[s];
      assign obi_read_rsp_to_dma[s] = obi_read_rsp_to_mux[s];

      obi_rready_converter #(
        .obi_a_chan_t(obi_a_chan_t),
        .obi_r_chan_t(obi_r_chan_t),
        .Depth(1)
      ) obi_rready_converter_reorg_i (
        .clk_i,
        .rst_ni,
        .test_mode_i,
        .sbr_a_chan_i  ( obi_reorg_req_from_dma[s].a       ),
        .req_i         ( obi_reorg_req_from_dma[s].req     ),
        .gnt_o         ( obi_reorg_rsp_to_dma[s].gnt       ),
        .rready_i      ( obi_reorg_req_from_dma[s].rready  ),
        .sbr_r_chan_o  ( obi_reorg_rsp_to_dma[s].r         ),
        .rvalid_o      ( obi_reorg_rsp_to_dma[s].rvalid    ),
        .mgr_a_chan_o  ( obi_reorg_req_from_rrc[s].a       ),
        .req_o         ( obi_reorg_req_from_rrc[s].req     ),
        .mgr_r_chan_i  ( obi_reorg_rsp_to_rrc[s].r         ),
        .gnt_i         ( obi_reorg_rsp_to_rrc[s].gnt       ),
        .rvalid_i      ( obi_reorg_rsp_to_rrc[s].rvalid    )
      );
      // We are always ready for responses, because we don't
      // send more requests than we can absorb in the fifo
      assign obi_reorg_req_from_rrc[s].rready = 1'b1;
    end  // else: !if(MUX_READ)

    obi_rready_converter #(
      .obi_a_chan_t(obi_a_chan_t),
      .obi_r_chan_t(obi_r_chan_t),
      .Depth(1)
    ) obi_rready_converter_read_i (
      .clk_i,
      .rst_ni,
      .test_mode_i,
      .sbr_a_chan_i  ( obi_read_req_muxed[s].a        ),
      .req_i         ( obi_read_req_muxed[s].req      ),
      .gnt_o         ( obi_read_rsp_to_mux[s].gnt     ),
      .rready_i      ( obi_read_req_muxed[s].rready   ),
      .sbr_r_chan_o  ( obi_read_rsp_to_mux[s].r       ),
      .rvalid_o      ( obi_read_rsp_to_mux[s].rvalid  ),
      .mgr_a_chan_o  ( obi_read_req_from_rrc[s].a     ),
      .req_o         ( obi_read_req_from_rrc[s].req   ),
      .mgr_r_chan_i  ( obi_read_rsp_to_rrc[s].r       ),
      .gnt_i         ( obi_read_rsp_to_rrc[s].gnt     ),
      .rvalid_i      ( obi_read_rsp_to_rrc[s].rvalid  )
    );
    // We are always ready for responses, because we don't
    // send more requests than we can absorb in the fifo
    assign obi_read_req_from_rrc[s].rready = 1'b1;


    obi_rready_converter #(
      .obi_a_chan_t(obi_a_chan_t),
      .obi_r_chan_t(obi_r_chan_t),
      .Depth(1)
    ) obi_rready_converter_wr_i (
      .clk_i,
      .rst_ni,
      .test_mode_i,
      .sbr_a_chan_i  ( obi_write_req_from_dma[s].a       ),
      .req_i         ( obi_write_req_from_dma[s].req     ),
      .gnt_o         ( obi_write_rsp_to_dma[s].gnt       ),
      .rready_i      ( obi_write_req_from_dma[s].rready  ),
      .sbr_r_chan_o  ( obi_write_rsp_to_dma[s].r         ),
      .rvalid_o      ( obi_write_rsp_to_dma[s].rvalid    ),
      .mgr_a_chan_o  ( obi_write_req_from_rrc[s].a       ),
      .req_o         ( obi_write_req_from_rrc[s].req     ),
      .mgr_r_chan_i  ( obi_write_rsp_to_rrc[s].r         ),
      .gnt_i         ( obi_write_rsp_to_rrc[s].gnt       ),
      .rvalid_i      ( obi_write_rsp_to_rrc[s].rvalid    )
    );
    // Same as above
    assign obi_write_req_from_rrc[s].rready = 1'b1;
  end


  // ------------------------------------------------------
  // TCDM connections
  // ------------------------------------------------------
  for (genvar s = 0; s < NUM_BIDIR_STREAMS; s++) begin
    if (TCDM_MEM2BANKS) begin : tcdm_mem2banks
      // Currently, mem2banks only implemented for AXI_DATA_WIDTH==64
      // TODO: parametrize so it works for arbitrary data widths
      initial begin : mem2banks_check_axi_width
        if (AXI_DATA_WIDTH != 64) begin
          $error("idma_wrap: AXI_DATA_WIDTH must be 64 when TCDM_MEM2BANKS is 1!");
        end
      end

      logic tcdm_master_we_0;
      logic tcdm_master_we_1;
      logic tcdm_master_we_2;
      logic tcdm_master_we_3;
      logic tcdm_master_we_4;
      logic tcdm_master_we_5;

      mem_to_banks #(
        .AddrWidth(ADDR_WIDTH),
        .DataWidth(AXI_DATA_WIDTH),
        .NumBanks (32'd2),
        .HideStrb (1'b1),
        .MaxTrans (32'd1),
        .FifoDepth(32'd1)
      ) i_mem_to_banks_write (
        .clk_i,
        .rst_ni,
        .req_i         ( obi_write_req_from_rrc[s].req                                                                     ),
        .gnt_o         ( obi_write_rsp_to_rrc[s].gnt                                                                       ),
        .addr_i        ( obi_write_req_from_rrc[s].a.addr                                                                  ),
        .wdata_i       ( obi_write_req_from_rrc[s].a.wdata                                                                 ),
        .strb_i        ( obi_write_req_from_rrc[s].a.be                                                                    ),
        .atop_i        ( '0                                                                                                ),
        .we_i          ( obi_write_req_from_rrc[s].a.we                                                                    ),
        .rvalid_o      ( obi_write_rsp_to_rrc[s].rvalid                                                                    ),
        .rdata_o       ( obi_write_rsp_to_rrc[s].r.rdata                                                                   ),
        .bank_req_o    ( {tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].req, tcdm_master[NB_TCDM_PORTS_PER_STRM*s].req}          ),
        .bank_gnt_i    ( {tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].gnt, tcdm_master[NB_TCDM_PORTS_PER_STRM*s].gnt}          ),
        .bank_addr_o   ( {tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].add, tcdm_master[NB_TCDM_PORTS_PER_STRM*s].add}          ),
        .bank_wdata_o  ( {tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].data, tcdm_master[NB_TCDM_PORTS_PER_STRM*s].data}        ),
        .bank_strb_o   ( {tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].be, tcdm_master[NB_TCDM_PORTS_PER_STRM*s].be}            ),
        .bank_atop_o   (  /* NOT CONNECTED */                                                                              ),
        .bank_we_o     ( {tcdm_master_we_1, tcdm_master_we_0}                                                              ),
        .bank_rvalid_i ( {tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].r_valid, tcdm_master[NB_TCDM_PORTS_PER_STRM*s].r_valid}  ),
        .bank_rdata_i  ( {tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].r_data, tcdm_master[NB_TCDM_PORTS_PER_STRM*s].r_data}    )
      );

      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+0].user  = '0;
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].user  = '0;
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+0].wen   = !tcdm_master_we_0;
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].wen   = !tcdm_master_we_1;
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+0].r_ready   = 1'b1;
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].r_ready   = 1'b1;
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+0].id   = '0; // TODO change?
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].id   = '0;
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+0].ecc   = '0;
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].ecc   = '0;

      mem_to_banks #(
        .AddrWidth(ADDR_WIDTH),
        .DataWidth(AXI_DATA_WIDTH),
        .NumBanks (32'd2),
        .HideStrb (1'b1),
        .MaxTrans (32'd1),
        .FifoDepth(32'd1)
      ) i_mem_to_banks_read (
        .clk_i,
        .rst_ni,
        .req_i         ( obi_read_req_from_rrc[s].req                                                                        ),
        .gnt_o         ( obi_read_rsp_to_rrc[s].gnt                                                                          ),
        .addr_i        ( obi_read_req_from_rrc[s].a.addr                                                                     ),
        .wdata_i       ( obi_read_req_from_rrc[s].a.wdata                                                                    ),
        .strb_i        ( obi_read_req_from_rrc[s].a.be                                                                       ),
        .atop_i        ( '0                                                                                                  ),
        .we_i          ( obi_read_req_from_rrc[s].a.we                                                                       ),
        .rvalid_o      ( obi_read_rsp_to_rrc[s].rvalid                                                                       ),
        .rdata_o       ( obi_read_rsp_to_rrc[s].r.rdata                                                                      ),
        .bank_req_o    ( {tcdm_master[NB_TCDM_PORTS_PER_STRM*s+3].req, tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].req }         ),
        .bank_gnt_i    ( {tcdm_master[NB_TCDM_PORTS_PER_STRM*s+3].gnt, tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].gnt }         ),
        .bank_addr_o   ( {tcdm_master[NB_TCDM_PORTS_PER_STRM*s+3].add, tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].add }         ),
        .bank_wdata_o  ( {tcdm_master[NB_TCDM_PORTS_PER_STRM*s+3].data, tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].data }       ),
        .bank_strb_o   ( {tcdm_master[NB_TCDM_PORTS_PER_STRM*s+3].be, tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].be }           ),
        .bank_atop_o   (  /* NOT CONNECTED */                                                                                ),
        .bank_we_o     ( {tcdm_master_we_3, tcdm_master_we_2}                                                                ),
        .bank_rvalid_i ( {tcdm_master[NB_TCDM_PORTS_PER_STRM*s+3].r_valid, tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].r_valid } ),
        .bank_rdata_i  ( {tcdm_master[NB_TCDM_PORTS_PER_STRM*s+3].r_data, tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].r_data }   )
      );


      //assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].boffs = '0;
      //assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].lrdy  = '0;
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].user  = '0;
      //assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+3].boffs = '0;
      //assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+3].lrdy  = '0;
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+3].user  = '0;
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].wen   = !tcdm_master_we_2;
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+3].wen   = !tcdm_master_we_3;
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].r_ready   = 1'b1;
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+3].r_ready   = 1'b1;
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].id   = '0; // TODO change?
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+3].id   = '0;
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].ecc   = '0;
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+3].ecc   = '0;


      if (!MUX_READ) begin // if we don't mux the read, we have 6*NUM_BIDIR_STREAMS interfaces and the reorg
        // interface goes straight to TCDM masters 5 and 4.
        mem_to_banks #(
          .AddrWidth(ADDR_WIDTH),
          .DataWidth(AXI_DATA_WIDTH),
          .NumBanks (32'd2),
          .HideStrb (1'b1),
          .MaxTrans (32'd1),
          .FifoDepth(32'd1)
        ) i_mem_to_banks_reorg (
          .clk_i,
          .rst_ni,
          .req_i         ( obi_reorg_req_from_rrc[s].req                                                                     ),
          .gnt_o         ( obi_reorg_rsp_to_rrc[s].gnt                                                                       ),
          .addr_i        ( obi_reorg_req_from_rrc[s].a.addr                                                                  ),
          .wdata_i       ( obi_reorg_req_from_rrc[s].a.wdata                                                                 ),
          .strb_i        ( obi_reorg_req_from_rrc[s].a.be                                                                    ),
          .atop_i        ( '0                                                                                                ),
          .we_i          ( obi_reorg_req_from_rrc[s].a.we                                                                    ),
          .rvalid_o      ( obi_reorg_rsp_to_rrc[s].rvalid                                                                    ),
          .rdata_o       ( obi_reorg_rsp_to_rrc[s].r.rdata                                                                   ),
          .bank_req_o    ( {tcdm_master[NB_TCDM_PORTS_PER_STRM*s+5].req, tcdm_master[NB_TCDM_PORTS_PER_STRM*s+4].req}        ),
          .bank_gnt_i    ( {tcdm_master[NB_TCDM_PORTS_PER_STRM*s+5].gnt, tcdm_master[NB_TCDM_PORTS_PER_STRM*s+4].gnt}        ),
          .bank_addr_o   ( {tcdm_master[NB_TCDM_PORTS_PER_STRM*s+5].add, tcdm_master[NB_TCDM_PORTS_PER_STRM*s+4].add}        ),
          .bank_wdata_o  ( {tcdm_master[NB_TCDM_PORTS_PER_STRM*s+5].data, tcdm_master[NB_TCDM_PORTS_PER_STRM*s+4].data}      ),
          .bank_strb_o   ( {tcdm_master[NB_TCDM_PORTS_PER_STRM*s+5].be, tcdm_master[NB_TCDM_PORTS_PER_STRM*s+4].be}          ),
          .bank_atop_o   (  /* NOT CONNECTED */                                                                              ),
          .bank_we_o     ( {tcdm_master_we_5, tcdm_master_we_4}                                                              ),
          .bank_rvalid_i ( {tcdm_master[NB_TCDM_PORTS_PER_STRM*s+5].r_valid,tcdm_master[NB_TCDM_PORTS_PER_STRM*s+4].r_valid} ),
          .bank_rdata_i  ( {tcdm_master[NB_TCDM_PORTS_PER_STRM*s+5].r_data,tcdm_master[NB_TCDM_PORTS_PER_STRM*s+4].r_data}   )
        );

        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+4].boffs = '0;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+4].lrdy  = '0;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+4].user  = '0;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+5].boffs = '0;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+5].lrdy  = '0;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+5].user  = '0;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+4].wen   = !tcdm_master_we_4;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+5].wen   = !tcdm_master_we_5;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+4].r_ready   = 1'b1;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+5].r_ready   = 1'b1;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+4].id   = '0; // TODO change?
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+5].id   = '0;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+4].ecc   = '0;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+5].ecc   = '0;
      end
    end else begin : passthrough_obi_to_tcdm
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s].user = '0;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s].req =  obi_write_req_from_rrc[s].req;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s].wen = !obi_write_req_from_rrc[s].a.we;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s].add = obi_write_req_from_rrc[s].a.addr;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s].data = obi_write_req_from_rrc[s].a.wdata;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s].be = obi_write_req_from_rrc[s].a.be;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s].r_ready = obi_write_req_from_rrc[s].rready;
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s].id   = '0; // TODO change?
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s].ecc   = '0;
        assign obi_write_rsp_to_rrc[s].gnt = tcdm_master[NB_TCDM_PORTS_PER_STRM*s].gnt;
        assign obi_write_rsp_to_rrc[s].rvalid = tcdm_master[NB_TCDM_PORTS_PER_STRM*s].r_valid;
        assign obi_write_rsp_to_rrc[s].r.rdata = tcdm_master[NB_TCDM_PORTS_PER_STRM*s].r_data;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].user = '0;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].req = obi_read_req_from_rrc[s].req;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].wen = !obi_read_req_from_rrc[s].a.we;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].add = obi_read_req_from_rrc[s].a.addr;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].data = obi_read_req_from_rrc[s].a.wdata;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].be = obi_read_req_from_rrc[s].a.be;
        assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].r_ready = obi_read_req_from_rrc[s].rready;
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].id   = '0;
      assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].ecc   = '0;
        assign obi_read_rsp_to_rrc[s].gnt = tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].gnt;
        assign obi_read_rsp_to_rrc[s].rvalid = tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].r_valid;
        assign obi_read_rsp_to_rrc[s].r.rdata = tcdm_master[NB_TCDM_PORTS_PER_STRM*s+1].r_data;
        if (!MUX_READ) begin : passthrough_obi_read
          assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].req = obi_reorg_req_from_rrc[s].req;
          assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].wen = !obi_reorg_req_from_rrc[s].a.we;
          assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].add = obi_reorg_req_from_rrc[s].a.addr;
          assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].data = obi_reorg_req_from_rrc[s].a.wdata;
          assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].be = obi_reorg_req_from_rrc[s].a.be;
          assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].r_ready = obi_read_req_from_rrc[s].rready;
          assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].id   = '0;
          assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].ecc   = '0;
          assign obi_reorg_rsp_to_rrc[s].gnt = tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].gnt;
          assign obi_reorg_rsp_to_rrc[s].rvalid = tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].r_valid;
          assign obi_reorg_rsp_to_rrc[s].r.rdata = tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].r_data;
          assign tcdm_master[NB_TCDM_PORTS_PER_STRM*s+2].user = '0;
        end
      end
    end
endmodule
`undef MY_MAX
