module core_demux_wrap #(
  parameter  int unsigned AddrWidth       = 32         ,
  parameter  int unsigned DataWidth       = 32         ,
  parameter  int unsigned RemapAddress    = 1          ,
  parameter  int unsigned ClustAlias      = 1          ,
  parameter  int unsigned ClustAliasBase  = 12'h000    ,
  parameter  int unsigned NumExtPerf      = 5          ,
  parameter  type         core_data_req_t = logic      ,
  parameter  type         core_data_rsp_t = logic      ,
  localparam int unsigned ByteEnable      = DataWidth/8
)(
  input  logic clk_i                         ,
  input  logic rst_ni                        ,
  input  logic test_en_i                     ,
  input  logic clk_en_i                      ,
  input  logic [3:0] base_addr_i             ,
  output logic [NumExtPerf-1:0] ext_perf_o   ,
  input  core_data_req_t core_data_req_i     ,
  output core_data_rsp_t core_data_rsp_o     ,
  hci_core_intf.initiator tcdm_bus_mst_o     ,
  hci_core_intf.initiator dma_ctrl_mst_o     ,
  XBAR_PERIPH_BUS.Master eventunit_bus_mst_o ,
  XBAR_PERIPH_BUS.Master peripheral_bus_mst_o
);

XBAR_PERIPH_BUS periph_demux_bus();

// bindings for tcdm_bus_mst
logic                    tcdm_bus_mst_req;
logic [AddrWidth  - 1:0] tcdm_bus_mst_add;
logic                    tcdm_bus_mst_wen;
logic [DataWidth  - 1:0] tcdm_bus_mst_wdata;
logic [ByteEnable - 1:0] tcdm_bus_mst_be;
logic                    tcdm_bus_mst_gnt;
logic                    tcdm_bus_mst_r_valid;
logic [DataWidth  - 1:0] tcdm_bus_mst_r_rdata;

// bindings initiator -> target
assign tcdm_bus_mst_o.req     = tcdm_bus_mst_req;
assign tcdm_bus_mst_o.add     = tcdm_bus_mst_add;
assign tcdm_bus_mst_o.wen     = tcdm_bus_mst_wen;
assign tcdm_bus_mst_o.data    = tcdm_bus_mst_wdata;
assign tcdm_bus_mst_o.be      = tcdm_bus_mst_be;
// bidings target -> initiator
assign tcdm_bus_mst_gnt     = tcdm_bus_mst_o.gnt;
assign tcdm_bus_mst_r_valid = tcdm_bus_mst_o.r_valid;
assign tcdm_bus_mst_r_rdata = tcdm_bus_mst_o.r_data;

// ties initiator -> target
assign tcdm_bus_mst_o.r_ready  = '1;
assign tcdm_bus_mst_o.user     = '0;
assign tcdm_bus_mst_o.id       = '0;
assign tcdm_bus_mst_o.ecc      = '0;
assign tcdm_bus_mst_o.ereq     = '0;
assign tcdm_bus_mst_o.r_eready = '1;

data_periph_demux #(
  .ADDR_WIDTH         ( AddrWidth      ),
  .DATA_WIDTH         ( DataWidth      ),
  .BYTE_ENABLE_BIT    ( ByteEnable     ),
  .REMAP_ADDRESS      ( RemapAddress   ),
  .CLUSTER_ALIAS      ( ClustAlias     ),
  .CLUSTER_ALIAS_BASE ( ClustAliasBase )
) data_periph_demux_i (
  .clk                (  clk_i                    ),
  .rst_ni             (  rst_ni                   ),
  .test_en_i          (  test_en_i                ),
  .base_addr_i        (  base_addr_i              ),
  .data_req_i         (  core_data_req_i.req      ),
  .data_add_i         (  core_data_req_i.add      ),
  .data_wen_i         (  ~core_data_req_i.we      ), //inverted when using OR10N
  .data_wdata_i       (  core_data_req_i.data     ),
  .data_be_i          (  core_data_req_i.be       ),
  .data_gnt_o         (  core_data_rsp_o.gnt      ),
  .data_r_valid_o     (  core_data_rsp_o.r_valid  ),
  .data_r_opc_o       (   /* ucnconnected */      ),
  .data_r_rdata_o     (  core_data_rsp_o.r_data   ),

  .data_req_o_SH      (  tcdm_bus_mst_req         ),
  .data_add_o_SH      (  tcdm_bus_mst_add         ),
  .data_wen_o_SH      (  tcdm_bus_mst_wen         ),
  .data_wdata_o_SH    (  tcdm_bus_mst_wdata       ),
  .data_be_o_SH       (  tcdm_bus_mst_be          ),
  .data_gnt_i_SH      (  tcdm_bus_mst_gnt         ),
  .data_r_valid_i_SH  (  tcdm_bus_mst_r_valid     ),
  .data_r_rdata_i_SH  (  tcdm_bus_mst_r_rdata     ),

  .data_req_o_EXT     (  periph_demux_bus.req     ),
  .data_add_o_EXT     (  periph_demux_bus.add     ),
  .data_wen_o_EXT     (  periph_demux_bus.wen     ),
  .data_wdata_o_EXT   (  periph_demux_bus.wdata   ),
  .data_be_o_EXT      (  periph_demux_bus.be      ),
  .data_gnt_i_EXT     (  periph_demux_bus.gnt     ),
  .data_r_valid_i_EXT (  periph_demux_bus.r_valid ),
  .data_r_rdata_i_EXT (  periph_demux_bus.r_rdata ),
  .data_r_opc_i_EXT   (  periph_demux_bus.r_opc   ),

  .data_req_o_PE      (  peripheral_bus_mst_o.req     ),
  .data_add_o_PE      (  peripheral_bus_mst_o.add     ),
  .data_wen_o_PE      (  peripheral_bus_mst_o.wen     ),
  .data_wdata_o_PE    (  peripheral_bus_mst_o.wdata   ),
  .data_be_o_PE       (  peripheral_bus_mst_o.be      ),
  .data_gnt_i_PE      (  peripheral_bus_mst_o.gnt     ),
  .data_r_valid_i_PE  (  peripheral_bus_mst_o.r_valid ),
  .data_r_rdata_i_PE  (  peripheral_bus_mst_o.r_rdata ),
  .data_r_opc_i_PE    (  peripheral_bus_mst_o.r_opc   ),

  .perf_l2_ld_o       (  ext_perf_o [0]             ),
  .perf_l2_st_o       (  ext_perf_o [1]             ),
  .perf_l2_ld_cyc_o   (  ext_perf_o [2]             ),
  .perf_l2_st_cyc_o   (  ext_perf_o [3]             )
);

assign ext_perf_o[4] = '0;

assign periph_demux_bus.id  = '0;

assign dma_ctrl_mst_o.r_ready  = '1;
assign dma_ctrl_mst_o.user     = '0;
assign dma_ctrl_mst_o.id       = '0;
assign dma_ctrl_mst_o.ecc      = '0;
assign dma_ctrl_mst_o.ereq     = '0;
assign dma_ctrl_mst_o.r_eready = '1;

periph_demux
periph_demux_i       (
  .clk               ( clk_i                       ),
  .rst_ni            ( rst_ni                      ),

  .data_req_i        ( periph_demux_bus.req        ),
  .data_add_i        ( periph_demux_bus.add        ),
  .data_wen_i        ( periph_demux_bus.wen        ),
  .data_wdata_i      ( periph_demux_bus.wdata      ),
  .data_be_i         ( periph_demux_bus.be         ),
  .data_gnt_o        ( periph_demux_bus.gnt        ),
  .data_r_valid_o    ( periph_demux_bus.r_valid    ),
  .data_r_opc_o      ( periph_demux_bus.r_opc      ),
  .data_r_rdata_o    ( periph_demux_bus.r_rdata    ),

  .data_req_o_MH     ( dma_ctrl_mst_o.req          ),
  .data_add_o_MH     ( dma_ctrl_mst_o.add          ),
  .data_wen_o_MH     ( dma_ctrl_mst_o.wen          ),
  .data_wdata_o_MH   ( dma_ctrl_mst_o.data         ),
  .data_be_o_MH      ( dma_ctrl_mst_o.be           ),
  .data_gnt_i_MH     ( dma_ctrl_mst_o.gnt          ),
  .data_r_valid_i_MH ( dma_ctrl_mst_o.r_valid      ),
  .data_r_rdata_i_MH ( dma_ctrl_mst_o.r_data       ),
  .data_r_opc_i_MH   ( dma_ctrl_mst_o.r_opc        ),

  .data_req_o_EU     ( eventunit_bus_mst_o.req     ),
  .data_add_o_EU     ( eventunit_bus_mst_o.add     ),
  .data_wen_o_EU     ( eventunit_bus_mst_o.wen     ),
  .data_wdata_o_EU   ( eventunit_bus_mst_o.wdata   ),
  .data_be_o_EU      ( eventunit_bus_mst_o.be      ),
  .data_gnt_i_EU     ( eventunit_bus_mst_o.gnt     ),
  .data_r_valid_i_EU ( eventunit_bus_mst_o.r_valid ),
  .data_r_rdata_i_EU ( eventunit_bus_mst_o.r_rdata ),
  .data_r_opc_i_EU   ( eventunit_bus_mst_o.r_opc   )
);

endmodule: core_demux_wrap
