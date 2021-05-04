// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

/*
 * cluster_bus_wrap.sv
 * Davide Rossi <davide.rossi@unibo.it>
 * Antonio Pullini <pullinia@iis.ee.ethz.ch>
 * Igor Loi <igor.loi@unibo.it>
 * Francesco Conti <fconti@iis.ee.ethz.ch>
 */


`include "cluster_bus_defines.sv"
`include "axi/assign.svh"
`include "axi/typedef.svh"


module cluster_bus_wrap
    import axi_pkg::xbar_cfg_t;
    import pulp_cluster_package::addr_map_rule_t;
#(
  parameter NB_CORES              = 4 ,
  parameter AXI_ADDR_WIDTH        = 32,
  parameter AXI_DATA_WIDTH        = 64,
  parameter AXI_ID_IN_WIDTH       = 4 ,
  parameter AXI_ID_OUT_WIDTH      = 6 ,
  parameter AXI_USER_WIDTH        = 6 ,
  parameter DMA_NB_OUTSND_BURSTS  = 8 ,
  parameter TCDM_SIZE             = 0

)
(
  input logic       clk_i,
  input logic       rst_ni,
  input logic       test_en_i,
  input logic [5:0] cluster_id_i,
  AXI_BUS.Slave     data_slave,
  AXI_BUS.Slave     instr_slave,
  AXI_BUS.Slave     dma_slave,
  AXI_BUS.Slave     ext_slave,
  //INITIATOR
  AXI_BUS.Master    tcdm_master,
  AXI_BUS.Master    periph_master,
  AXI_BUS.Master    ext_master
);


  localparam NB_MASTER      = `NB_MASTER;
  localparam NB_SLAVE       = `NB_SLAVE;


  // Crossbar
  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH  ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH  ),
    .AXI_ID_WIDTH   ( AXI_ID_IN_WIDTH ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH  )
  ) axi_slaves [NB_SLAVE-1:0]();

  // assign here your axi slaves
  `AXI_ASSIGN(axi_slaves[0] , data_slave )
  `AXI_ASSIGN(axi_slaves[1] , instr_slave)
  `AXI_ASSIGN(axi_slaves[2] , dma_slave  )
  `AXI_ASSIGN(axi_slaves[3] , ext_slave  )

  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH    ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH    ),
    .AXI_ID_WIDTH   ( AXI_ID_OUT_WIDTH  ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH    )
  ) axi_masters [NB_MASTER-1:0]();

  // assign here your axi masters
  `AXI_ASSIGN(tcdm_master  , axi_masters[0])
  `AXI_ASSIGN(periph_master, axi_masters[1])
  `AXI_ASSIGN(ext_master   , axi_masters[2])

  // address map
  logic [31:0] cluster_base_addr;
  assign cluster_base_addr = 32'h1000_0000 + ( cluster_id_i << 22);
  localparam int unsigned N_RULES = 3;
  pulp_cluster_package::addr_map_rule_t [N_RULES-1:0] addr_map;


  assign addr_map[0] = '{ // TCDM
    idx:  0,
    start_addr: cluster_base_addr,
    end_addr:   cluster_base_addr + TCDM_SIZE
  };
  assign addr_map[1] = '{ // Peripherals
    idx:  1,
    start_addr: cluster_base_addr + 32'h0020_0000,
    end_addr:   cluster_base_addr + 32'h0040_0000
  };
  assign addr_map[2] = '{ // everything above cluster to ext_slave
    idx:  2,
    start_addr: cluster_base_addr + 32'h0040_0000,
    end_addr:   32'hFFFF_FFFF
  };

//  // pragma translate_off
//  `ifndef VERILATOR
//    initial begin
//      assert (AXI_ADDR_WIDTH == 32)
//        else $fatal("Address map is only defined for 32-bit addresses!");
//      assert (TCDM_SIZE <= 128*1024)
//        else $fatal(1, "TCDM size exceeds available address space in cluster bus!");
//      assert (TCDM_SIZE > 0)
//        else $fatal(1, "TCDM size must be non-zero!");
//      assert (AXI_ID_IN_WIDTH + $clog2(NB_SLAVE) <= AXI_ID_OUT_WIDTH)
//        else $fatal(1, "Insufficient AXI_ID_OUT_WIDTH!");
//    end
//  `endif

  localparam int unsigned MAX_TXNS_PER_SLV_PORT = (DMA_NB_OUTSND_BURSTS > NB_CORES) ?
                                                    DMA_NB_OUTSND_BURSTS : NB_CORES;


    localparam xbar_cfg_t AXI_XBAR_CFG = '{
                                                    NoSlvPorts: NB_SLAVE,
                                                    NoMstPorts: NB_MASTER,
                                                    MaxMstTrans: MAX_TXNS_PER_SLV_PORT,       //The TCDM ports do not support
                                                    //outstanding transactiions anyways
                                                    MaxSlvTrans: DMA_NB_OUTSND_BURSTS + NB_CORES,       //Allow up to 4 in-flight transactions
                                                    //per slave port
                                                    FallThrough: 1'b0,       //Use the reccomended default config
                                                    LatencyMode: axi_pkg::NO_LATENCY, // CUT_ALL_AX | axi_pkg::DemuxW,
                                                    AxiIdWidthSlvPorts: AXI_ID_IN_WIDTH,
                                                    AxiIdUsedSlvPorts: AXI_ID_IN_WIDTH,
                                                    AxiAddrWidth: AXI_ADDR_WIDTH,
                                                    AxiDataWidth: AXI_DATA_WIDTH,
                                                    NoAddrRules: N_RULES
                                                    };


  axi_xbar_intf #(
    .AXI_USER_WIDTH         ( AXI_USER_WIDTH                        ),
    .Cfg                    ( AXI_XBAR_CFG                          ),
    .rule_t                 ( addr_map_rule_t                       )
  ) i_xbar (
    .clk_i,
    .rst_ni,
    .test_i                 (test_en_i),
    .slv_ports              (axi_slaves),
    .mst_ports              (axi_masters),
    .addr_map_i             (addr_map),
    .en_default_mst_port_i  ('0), // disable default master port for all slave ports
    .default_mst_port_i     ('0)
  );

endmodule
