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

`include "pulp_soc_defines.sv"
`include "cluster_bus_defines.sv"

module cluster_bus_wrap
#(
  parameter NB_CORES         = 4 ,
  parameter AXI_ADDR_WIDTH   = 32,
  parameter AXI_DATA_WIDTH   = 64,
  parameter AXI_ID_IN_WIDTH  = 4 ,
  parameter AXI_ID_OUT_WIDTH = 6 ,
  parameter AXI_USER_WIDTH   = 6
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

  localparam AXI_STRB_WIDTH = AXI_DATA_WIDTH/8;
  localparam NB_MASTER      = `NB_MASTER;
  localparam NB_SLAVE       = `NB_SLAVE;
  localparam NB_REGION      = `NB_REGION;

  //Ensure that AXI_ID out width has the correct size with an elaboration system task
  if (AXI_ID_OUT_WIDTH < AXI_ID_IN_WIDTH + $clog2(NB_SLAVE))
    $error("ID width of AXI output ports is to small. The output id width must be input ID width + clog2(<nr slave ports>) which is %d but it was %d", AXI_ID_IN_WIDTH + $clog2(NB_SLAVE), AXI_ID_OUT_WIDTH);
  else if (AXI_ID_OUT_WIDTH > AXI_ID_IN_WIDTH + $clog2(NB_SLAVE))
    $warning("ID width of the AXI output port has the wrong length. It is larger than the required value. Trim it to the right length to get rid of this warning.");


  logic [NB_MASTER-1:0][AXI_ID_OUT_WIDTH-1:0] s_master_aw_id;
  logic [NB_MASTER-1:0][AXI_ADDR_WIDTH-1:0]   s_master_aw_addr;
  logic [NB_MASTER-1:0][7:0]                  s_master_aw_len;
  logic [NB_MASTER-1:0][2:0]                  s_master_aw_size;
  logic [NB_MASTER-1:0][1:0]                  s_master_aw_burst;
  logic [NB_MASTER-1:0]                       s_master_aw_lock;
  logic [NB_MASTER-1:0][3:0]                  s_master_aw_cache;
  logic [NB_MASTER-1:0][2:0]                  s_master_aw_prot;
  logic [NB_MASTER-1:0][3:0]                  s_master_aw_region;
  logic [NB_MASTER-1:0][AXI_USER_WIDTH-1:0]   s_master_aw_user;
  logic [NB_MASTER-1:0][3:0]                  s_master_aw_qos;
  logic [NB_MASTER-1:0]                       s_master_aw_valid;
  logic [NB_MASTER-1:0]                       s_master_aw_ready;

  logic [NB_MASTER-1:0][AXI_ID_OUT_WIDTH-1:0] s_master_ar_id;
  logic [NB_MASTER-1:0][AXI_ADDR_WIDTH-1:0]   s_master_ar_addr;
  logic [NB_MASTER-1:0][7:0]                  s_master_ar_len;
  logic [NB_MASTER-1:0][2:0]                  s_master_ar_size;
  logic [NB_MASTER-1:0][1:0]                  s_master_ar_burst;
  logic [NB_MASTER-1:0]                       s_master_ar_lock;
  logic [NB_MASTER-1:0][3:0]                  s_master_ar_cache;
  logic [NB_MASTER-1:0][2:0]                  s_master_ar_prot;
  logic [NB_MASTER-1:0][3:0]                  s_master_ar_region;
  logic [NB_MASTER-1:0][AXI_USER_WIDTH-1:0]   s_master_ar_user;
  logic [NB_MASTER-1:0][3:0]                  s_master_ar_qos;
  logic [NB_MASTER-1:0]                       s_master_ar_valid;
  logic [NB_MASTER-1:0]                       s_master_ar_ready;

  logic [NB_MASTER-1:0][AXI_DATA_WIDTH-1:0]   s_master_w_data;
  logic [NB_MASTER-1:0][AXI_STRB_WIDTH-1:0]   s_master_w_strb;
  logic [NB_MASTER-1:0]                       s_master_w_last;
  logic [NB_MASTER-1:0][AXI_USER_WIDTH-1:0]   s_master_w_user;
  logic [NB_MASTER-1:0]                       s_master_w_valid;
  logic [NB_MASTER-1:0]                       s_master_w_ready;

  logic [NB_MASTER-1:0][AXI_ID_OUT_WIDTH-1:0] s_master_b_id;
  logic [NB_MASTER-1:0][1:0]                  s_master_b_resp;
  logic [NB_MASTER-1:0]                       s_master_b_valid;
  logic [NB_MASTER-1:0][AXI_USER_WIDTH-1:0]   s_master_b_user;
  logic [NB_MASTER-1:0]                       s_master_b_ready;

  logic [NB_MASTER-1:0][AXI_ID_OUT_WIDTH-1:0] s_master_r_id;
  logic [NB_MASTER-1:0][AXI_DATA_WIDTH-1:0]   s_master_r_data;
  logic [NB_MASTER-1:0][1:0]                  s_master_r_resp;
  logic [NB_MASTER-1:0]                       s_master_r_last;
  logic [NB_MASTER-1:0][AXI_USER_WIDTH-1:0]   s_master_r_user;
  logic [NB_MASTER-1:0]                       s_master_r_valid;
  logic [NB_MASTER-1:0]                       s_master_r_ready;

  logic [NB_SLAVE-1:0][AXI_ID_IN_WIDTH-1:0]   s_slave_aw_id;
  logic [NB_SLAVE-1:0][AXI_ADDR_WIDTH-1:0]    s_slave_aw_addr;
  logic [NB_SLAVE-1:0][7:0]                   s_slave_aw_len;
  logic [NB_SLAVE-1:0][2:0]                   s_slave_aw_size;
  logic [NB_SLAVE-1:0][1:0]                   s_slave_aw_burst;
  logic [NB_SLAVE-1:0]                        s_slave_aw_lock;
  logic [NB_SLAVE-1:0][3:0]                   s_slave_aw_cache;
  logic [NB_SLAVE-1:0][2:0]                   s_slave_aw_prot;
  logic [NB_SLAVE-1:0][3:0]                   s_slave_aw_region;
  logic [NB_SLAVE-1:0][AXI_USER_WIDTH-1:0]    s_slave_aw_user;
  logic [NB_SLAVE-1:0][3:0]                   s_slave_aw_qos;
  logic [NB_SLAVE-1:0]                        s_slave_aw_valid;
  logic [NB_SLAVE-1:0]                        s_slave_aw_ready;

  logic [NB_SLAVE-1:0][AXI_ID_IN_WIDTH-1:0]   s_slave_ar_id;
  logic [NB_SLAVE-1:0][AXI_ADDR_WIDTH-1:0]    s_slave_ar_addr;
  logic [NB_SLAVE-1:0][7:0]                   s_slave_ar_len;
  logic [NB_SLAVE-1:0][2:0]                   s_slave_ar_size;
  logic [NB_SLAVE-1:0][1:0]                   s_slave_ar_burst;
  logic [NB_SLAVE-1:0]                        s_slave_ar_lock;
  logic [NB_SLAVE-1:0][3:0]                   s_slave_ar_cache;
  logic [NB_SLAVE-1:0][2:0]                   s_slave_ar_prot;
  logic [NB_SLAVE-1:0][3:0]                   s_slave_ar_region;
  logic [NB_SLAVE-1:0][AXI_USER_WIDTH-1:0]    s_slave_ar_user;
  logic [NB_SLAVE-1:0][3:0]                   s_slave_ar_qos;
  logic [NB_SLAVE-1:0]                        s_slave_ar_valid;
  logic [NB_SLAVE-1:0]                        s_slave_ar_ready;

  logic [NB_SLAVE-1:0][AXI_DATA_WIDTH-1:0]    s_slave_w_data;
  logic [NB_SLAVE-1:0][AXI_STRB_WIDTH-1:0]    s_slave_w_strb;
  logic [NB_SLAVE-1:0]                        s_slave_w_last;
  logic [NB_SLAVE-1:0][AXI_USER_WIDTH-1:0]    s_slave_w_user;
  logic [NB_SLAVE-1:0]                        s_slave_w_valid;
  logic [NB_SLAVE-1:0]                        s_slave_w_ready;

  logic [NB_SLAVE-1:0][AXI_ID_IN_WIDTH-1:0]   s_slave_b_id;
  logic [NB_SLAVE-1:0][1:0]                   s_slave_b_resp;
  logic [NB_SLAVE-1:0]                        s_slave_b_valid;
  logic [NB_SLAVE-1:0][AXI_USER_WIDTH-1:0]    s_slave_b_user;
  logic [NB_SLAVE-1:0]                        s_slave_b_ready;

  logic [NB_SLAVE-1:0][AXI_ID_IN_WIDTH-1:0]   s_slave_r_id;
  logic [NB_SLAVE-1:0][AXI_DATA_WIDTH-1:0]    s_slave_r_data;
  logic [NB_SLAVE-1:0][1:0]                   s_slave_r_resp;
  logic [NB_SLAVE-1:0]                        s_slave_r_last;
  logic [NB_SLAVE-1:0][AXI_USER_WIDTH-1:0]    s_slave_r_user;
  logic [NB_SLAVE-1:0]                        s_slave_r_valid;
  logic [NB_SLAVE-1:0]                        s_slave_r_ready;

  logic [NB_REGION-1:0][NB_MASTER-1:0][AXI_ADDR_WIDTH-1:0] s_start_addr;
  logic [NB_REGION-1:0][NB_MASTER-1:0][AXI_ADDR_WIDTH-1:0] s_end_addr;
  logic [NB_REGION-1:0][NB_MASTER-1:0]                     s_valid_rule;
  logic [NB_SLAVE-1:0][NB_MASTER-1:0]                      s_connectivity_map;

  // BINDING OF MASTER PORTS
  //                           PORT 2                                  PORT 1                                     PORT 0
  assign                     { ext_master.aw_id[AXI_ID_OUT_WIDTH-1:0], periph_master.aw_id[AXI_ID_OUT_WIDTH-1:0], tcdm_master.aw_id[AXI_ID_OUT_WIDTH-1:0] } = s_master_aw_id;
  assign                     { ext_master.aw_addr,                     periph_master.aw_addr,                     tcdm_master.aw_addr                     } = s_master_aw_addr;
  assign                     { ext_master.aw_len,                      periph_master.aw_len,                      tcdm_master.aw_len                      } = s_master_aw_len ;
  assign                     { ext_master.aw_size,                     periph_master.aw_size,                     tcdm_master.aw_size                     } = s_master_aw_size;
  assign                     { ext_master.aw_burst,                    periph_master.aw_burst,                    tcdm_master.aw_burst                    } = s_master_aw_burst;
  assign                     { ext_master.aw_lock,                     periph_master.aw_lock,                     tcdm_master.aw_lock                     } = s_master_aw_lock;
  assign                     { ext_master.aw_cache,                    periph_master.aw_cache,                    tcdm_master.aw_cache                    } = s_master_aw_cache;
  assign                     { ext_master.aw_prot,                     periph_master.aw_prot,                     tcdm_master.aw_prot                     } = s_master_aw_prot;
  assign                     { ext_master.aw_region,                   periph_master.aw_region,                   tcdm_master.aw_region                   } = s_master_aw_region;
  assign                     { ext_master.aw_user,                     periph_master.aw_user,                     tcdm_master.aw_user                     } = s_master_aw_user;
  assign                     { ext_master.aw_qos,                      periph_master.aw_qos,                      tcdm_master.aw_qos                      } = s_master_aw_qos ;
  assign                     { ext_master.aw_valid,                    periph_master.aw_valid,                    tcdm_master.aw_valid                    } = s_master_aw_valid;
  assign s_master_aw_ready = { ext_master.aw_ready,                    periph_master.aw_ready,                    tcdm_master.aw_ready                    };

  assign                     { ext_master.ar_id[AXI_ID_OUT_WIDTH-1:0], periph_master.ar_id[AXI_ID_OUT_WIDTH-1:0], tcdm_master.ar_id[AXI_ID_OUT_WIDTH-1:0] } = s_master_ar_id;
  assign                     { ext_master.ar_addr,                     periph_master.ar_addr,                     tcdm_master.ar_addr                     } = s_master_ar_addr;
  assign                     { ext_master.ar_len,                      periph_master.ar_len,                      tcdm_master.ar_len                      } = s_master_ar_len;
  assign                     { ext_master.ar_size,                     periph_master.ar_size,                     tcdm_master.ar_size                     } = s_master_ar_size;
  assign                     { ext_master.ar_burst,                    periph_master.ar_burst,                    tcdm_master.ar_burst                    } = s_master_ar_burst;
  assign                     { ext_master.ar_lock,                     periph_master.ar_lock,                     tcdm_master.ar_lock                     } = s_master_ar_lock;
  assign                     { ext_master.ar_cache,                    periph_master.ar_cache,                    tcdm_master.ar_cache                    } = s_master_ar_cache;
  assign                     { ext_master.ar_prot,                     periph_master.ar_prot,                     tcdm_master.ar_prot                     } = s_master_ar_prot;
  assign                     { ext_master.ar_region,                   periph_master.ar_region,                   tcdm_master.ar_region                   } = s_master_ar_region;
  assign                     { ext_master.ar_user,                     periph_master.ar_user,                     tcdm_master.ar_user                     } = s_master_ar_user;
  assign                     { ext_master.ar_qos,                      periph_master.ar_qos,                      tcdm_master.ar_qos                      } = s_master_ar_qos;
  assign                     { ext_master.ar_valid,                    periph_master.ar_valid,                    tcdm_master.ar_valid                    } = s_master_ar_valid;
  assign s_master_ar_ready = { ext_master.ar_ready,                    periph_master.ar_ready,                    tcdm_master.ar_ready                    };

  assign                     { ext_master.w_data,                      periph_master.w_data,                      tcdm_master.w_data                      } = s_master_w_data ;
  assign                     { ext_master.w_strb,                      periph_master.w_strb,                      tcdm_master.w_strb                      } = s_master_w_strb ;
  assign                     { ext_master.w_last,                      periph_master.w_last,                      tcdm_master.w_last                      } = s_master_w_last ;
  assign                     { ext_master.w_user,                      periph_master.w_user,                      tcdm_master.w_user                      } = s_master_w_user ;
  assign                     { ext_master.w_valid,                     periph_master.w_valid,                     tcdm_master.w_valid                     } = s_master_w_valid;
  assign s_master_w_ready  = { ext_master.w_ready,                     periph_master.w_ready,                     tcdm_master.w_ready                     };

  assign s_master_b_id     = { ext_master.b_id[AXI_ID_OUT_WIDTH-1:0],  periph_master.b_id[AXI_ID_OUT_WIDTH-1:0],  tcdm_master.b_id[AXI_ID_OUT_WIDTH-1:0]  };
  assign s_master_b_resp   = { ext_master.b_resp,                      periph_master.b_resp,                      tcdm_master.b_resp                      };
  assign s_master_b_valid  = { ext_master.b_valid,                     periph_master.b_valid,                     tcdm_master.b_valid                     };
  assign s_master_b_user   = { ext_master.b_user,                      periph_master.b_user,                      tcdm_master.b_user                      };
  assign                     { ext_master.b_ready,                     periph_master.b_ready,                     tcdm_master.b_ready                     } = s_master_b_ready;

  assign s_master_r_id     = { ext_master.r_id[AXI_ID_OUT_WIDTH-1:0],  periph_master.r_id[AXI_ID_OUT_WIDTH-1:0],  tcdm_master.r_id[AXI_ID_OUT_WIDTH-1:0]  };
  assign s_master_r_data   = { ext_master.r_data,                      periph_master.r_data,                      tcdm_master.r_data                      };
  assign s_master_r_resp   = { ext_master.r_resp,                      periph_master.r_resp,                      tcdm_master.r_resp                      };
  assign s_master_r_last   = { ext_master.r_last,                      periph_master.r_last,                      tcdm_master.r_last                      };
  assign s_master_r_user   = { ext_master.r_user,                      periph_master.r_user,                      tcdm_master.r_user                      };
  assign s_master_r_valid  = { ext_master.r_valid,                     periph_master.r_valid,                     tcdm_master.r_valid                     };
  assign                     { ext_master.r_ready,                     periph_master.r_ready,                     tcdm_master.r_ready                     } = s_master_r_ready;

  // BINDING OF SLAVE PORTS
  //                           PORT 3                                  PORT 2                                 PORT 1                                PORT 0
  assign s_slave_aw_id     = { instr_slave.aw_id[AXI_ID_IN_WIDTH-1:0], data_slave.aw_id[AXI_ID_IN_WIDTH-1:0], dma_slave.aw_id[AXI_ID_IN_WIDTH-1:0], ext_slave.aw_id[AXI_ID_IN_WIDTH-1:0] };
  assign s_slave_aw_addr   = { instr_slave.aw_addr,                    data_slave.aw_addr,                    dma_slave.aw_addr,                    ext_slave.aw_addr                    };
  assign s_slave_aw_len    = { instr_slave.aw_len,                     data_slave.aw_len,                     dma_slave.aw_len,                     ext_slave.aw_len                     };
  assign s_slave_aw_size   = { instr_slave.aw_size,                    data_slave.aw_size,                    dma_slave.aw_size,                    ext_slave.aw_size                    };
  assign s_slave_aw_burst  = { instr_slave.aw_burst,                   data_slave.aw_burst,                   dma_slave.aw_burst,                   ext_slave.aw_burst                   };
  assign s_slave_aw_lock   = { instr_slave.aw_lock,                    data_slave.aw_lock,                    dma_slave.aw_lock,                    ext_slave.aw_lock                    };
  assign s_slave_aw_cache  = { instr_slave.aw_cache,                   data_slave.aw_cache,                   dma_slave.aw_cache,                   ext_slave.aw_cache                   };
  assign s_slave_aw_prot   = { instr_slave.aw_prot,                    data_slave.aw_prot,                    dma_slave.aw_prot,                    ext_slave.aw_prot                    };
  assign s_slave_aw_region = { instr_slave.aw_region,                  data_slave.aw_region,                  dma_slave.aw_region,                  ext_slave.aw_region                  };
  assign s_slave_aw_user   = { instr_slave.aw_user,                    data_slave.aw_user,                    dma_slave.aw_user,                    ext_slave.aw_user                    };
  assign s_slave_aw_qos    = { instr_slave.aw_qos,                     data_slave.aw_qos,                     dma_slave.aw_qos,                     ext_slave.aw_qos                     };
  assign s_slave_aw_valid  = { instr_slave.aw_valid,                   data_slave.aw_valid,                   dma_slave.aw_valid,                   ext_slave.aw_valid                   };
  assign                     { instr_slave.aw_ready,                   data_slave.aw_ready,                   dma_slave.aw_ready,                   ext_slave.aw_ready                   } =  s_slave_aw_ready;

  assign s_slave_ar_id     = { instr_slave.ar_id[AXI_ID_IN_WIDTH-1:0], data_slave.ar_id[AXI_ID_IN_WIDTH-1:0], dma_slave.ar_id[AXI_ID_IN_WIDTH-1:0], ext_slave.ar_id[AXI_ID_IN_WIDTH-1:0] };
  assign s_slave_ar_addr   = { instr_slave.ar_addr,                    data_slave.ar_addr,                    dma_slave.ar_addr,                    ext_slave.ar_addr                    };
  assign s_slave_ar_len    = { instr_slave.ar_len,                     data_slave.ar_len,                     dma_slave.ar_len,                     ext_slave.ar_len                     };
  assign s_slave_ar_size   = { instr_slave.ar_size,                    data_slave.ar_size,                    dma_slave.ar_size,                    ext_slave.ar_size                    };
  assign s_slave_ar_burst  = { instr_slave.ar_burst,                   data_slave.ar_burst,                   dma_slave.ar_burst,                   ext_slave.ar_burst                   };
  assign s_slave_ar_lock   = { instr_slave.ar_lock,                    data_slave.ar_lock,                    dma_slave.ar_lock,                    ext_slave.ar_lock                    };
  assign s_slave_ar_cache  = { instr_slave.ar_cache,                   data_slave.ar_cache,                   dma_slave.ar_cache,                   ext_slave.ar_cache                   };
  assign s_slave_ar_prot   = { instr_slave.ar_prot,                    data_slave.ar_prot,                    dma_slave.ar_prot,                    ext_slave.ar_prot                    };
  assign s_slave_ar_region = { instr_slave.ar_region,                  data_slave.ar_region,                  dma_slave.ar_region,                  ext_slave.ar_region                  };
  assign s_slave_ar_user   = { instr_slave.ar_user,                    data_slave.ar_user,                    dma_slave.ar_user,                    ext_slave.ar_user                    };
  assign s_slave_ar_qos    = { instr_slave.ar_qos,                     data_slave.ar_qos,                     dma_slave.ar_qos,                     ext_slave.ar_qos                     };
  assign s_slave_ar_valid  = { instr_slave.ar_valid,                   data_slave.ar_valid,                   dma_slave.ar_valid,                   ext_slave.ar_valid                   };
  assign                     { instr_slave.ar_ready,                   data_slave.ar_ready,                   dma_slave.ar_ready,                   ext_slave.ar_ready                   } = s_slave_ar_ready;

  assign s_slave_w_data    = { instr_slave.w_data,                     data_slave.w_data,                     dma_slave.w_data,                     ext_slave.w_data                     };
  assign s_slave_w_strb    = { instr_slave.w_strb,                     data_slave.w_strb,                     dma_slave.w_strb,                     ext_slave.w_strb                     };
  assign s_slave_w_last    = { instr_slave.w_last,                     data_slave.w_last,                     dma_slave.w_last,                     ext_slave.w_last                     };
  assign s_slave_w_user    = { instr_slave.w_user,                     data_slave.w_user,                     dma_slave.w_user,                     ext_slave.w_user                     };
  assign s_slave_w_valid   = { instr_slave.w_valid,                    data_slave.w_valid,                    dma_slave.w_valid,                    ext_slave.w_valid                    };
  assign                     { instr_slave.w_ready,                    data_slave.w_ready,                    dma_slave.w_ready,                    ext_slave.w_ready                    } = s_slave_w_ready;

  assign                     { instr_slave.b_id[AXI_ID_IN_WIDTH-1:0],  data_slave.b_id[AXI_ID_IN_WIDTH-1:0],  dma_slave.b_id[AXI_ID_IN_WIDTH-1:0],  ext_slave.b_id[AXI_ID_IN_WIDTH-1:0]  } = s_slave_b_id;
  assign                     { instr_slave.b_resp,                     data_slave.b_resp,                     dma_slave.b_resp,                     ext_slave.b_resp                     } = s_slave_b_resp;
  assign                     { instr_slave.b_valid,                    data_slave.b_valid,                    dma_slave.b_valid,                    ext_slave.b_valid                    } = s_slave_b_valid;
  assign                     { instr_slave.b_user,                     data_slave.b_user,                     dma_slave.b_user,                     ext_slave.b_user                     } = s_slave_b_user;
  assign s_slave_b_ready   = { instr_slave.b_ready,                    data_slave.b_ready,                    dma_slave.b_ready,                    ext_slave.b_ready                    };

  assign                     { instr_slave.r_id[AXI_ID_IN_WIDTH-1:0],  data_slave.r_id[AXI_ID_IN_WIDTH-1:0],  dma_slave.r_id[AXI_ID_IN_WIDTH-1:0],  ext_slave.r_id[AXI_ID_IN_WIDTH-1:0]  } = s_slave_r_id;
  assign                     { instr_slave.r_data,                     data_slave.r_data,                     dma_slave.r_data,                     ext_slave.r_data                     } = s_slave_r_data;
  assign                     { instr_slave.r_resp,                     data_slave.r_resp,                     dma_slave.r_resp,                     ext_slave.r_resp                     } = s_slave_r_resp;
  assign                     { instr_slave.r_last,                     data_slave.r_last,                     dma_slave.r_last,                     ext_slave.r_last                     } = s_slave_r_last;
  assign                     { instr_slave.r_user,                     data_slave.r_user,                     dma_slave.r_user,                     ext_slave.r_user                     } = s_slave_r_user;
  assign                     { instr_slave.r_valid,                    data_slave.r_valid,                    dma_slave.r_valid,                    ext_slave.r_valid                    } = s_slave_r_valid;
  assign s_slave_r_ready   = { instr_slave.r_ready,                    data_slave.r_ready,                    dma_slave.r_ready,                    ext_slave.r_ready                    };

  // cluster bus
  axi_node #(
    .AXI_ADDRESS_W           ( AXI_ADDR_WIDTH  ),
    .AXI_DATA_W              ( AXI_DATA_WIDTH  ),
    .AXI_NUMBYTES            ( AXI_STRB_WIDTH  ),
    .AXI_ID_IN               ( AXI_ID_IN_WIDTH ),
    .AXI_USER_W              ( AXI_USER_WIDTH  ),
    .N_MASTER_PORT           ( NB_MASTER       ),
    .N_SLAVE_PORT            ( NB_SLAVE        ),
    .N_REGION                ( NB_REGION       ),
    .FIFO_DEPTH_DW           ( 2               )
  ) cluster_bus_i (
    .clk                      ( clk_i              ),
    .rst_n                    ( rst_ni             ),
    .test_en_i                ( test_en_i          ),

    .slave_awid_i             ( s_slave_aw_id      ),
    .slave_awaddr_i           ( s_slave_aw_addr    ),
    .slave_awlen_i            ( s_slave_aw_len     ),
    .slave_awsize_i           ( s_slave_aw_size    ),
    .slave_awburst_i          ( s_slave_aw_burst   ),
    .slave_awlock_i           ( s_slave_aw_lock    ),
    .slave_awcache_i          ( s_slave_aw_cache   ),
    .slave_awprot_i           ( s_slave_aw_prot    ),
    .slave_awregion_i         ( s_slave_aw_region  ),
    .slave_awqos_i            ( s_slave_aw_qos     ),
    .slave_awuser_i           ( s_slave_aw_user    ),
    .slave_awvalid_i          ( s_slave_aw_valid   ),
    .slave_awready_o          ( s_slave_aw_ready   ),

    .slave_wdata_i            ( s_slave_w_data     ),
    .slave_wstrb_i            ( s_slave_w_strb     ),
    .slave_wlast_i            ( s_slave_w_last     ),
    .slave_wuser_i            ( s_slave_w_user     ),
    .slave_wvalid_i           ( s_slave_w_valid    ),
    .slave_wready_o           ( s_slave_w_ready    ),

    .slave_bid_o              ( s_slave_b_id       ),
    .slave_bresp_o            ( s_slave_b_resp     ),
    .slave_buser_o            ( s_slave_b_user     ),
    .slave_bvalid_o           ( s_slave_b_valid    ),
    .slave_bready_i           ( s_slave_b_ready    ),

    .slave_arid_i             ( s_slave_ar_id      ),
    .slave_araddr_i           ( s_slave_ar_addr    ),
    .slave_arlen_i            ( s_slave_ar_len     ),
    .slave_arsize_i           ( s_slave_ar_size    ),
    .slave_arburst_i          ( s_slave_ar_burst   ),
    .slave_arlock_i           ( s_slave_ar_lock    ),
    .slave_arcache_i          ( s_slave_ar_cache   ),
    .slave_arprot_i           ( s_slave_ar_prot    ),
    .slave_arregion_i         ( s_slave_ar_region  ),
    .slave_aruser_i           ( s_slave_ar_user    ),
    .slave_arqos_i            ( s_slave_ar_qos     ),
    .slave_arvalid_i          ( s_slave_ar_valid   ),
    .slave_arready_o          ( s_slave_ar_ready   ),

    .slave_rid_o              ( s_slave_r_id       ),
    .slave_rdata_o            ( s_slave_r_data     ),
    .slave_rresp_o            ( s_slave_r_resp     ),
    .slave_rlast_o            ( s_slave_r_last     ),
    .slave_ruser_o            ( s_slave_r_user     ),
    .slave_rvalid_o           ( s_slave_r_valid    ),
    .slave_rready_i           ( s_slave_r_ready    ),

    .master_awid_o            ( s_master_aw_id     ),
    .master_awaddr_o          ( s_master_aw_addr   ),
    .master_awlen_o           ( s_master_aw_len    ),
    .master_awsize_o          ( s_master_aw_size   ),
    .master_awburst_o         ( s_master_aw_burst  ),
    .master_awlock_o          ( s_master_aw_lock   ),
    .master_awcache_o         ( s_master_aw_cache  ),
    .master_awprot_o          ( s_master_aw_prot   ),
    .master_awregion_o        ( s_master_aw_region ),
    .master_awqos_o           ( s_master_aw_qos    ),
    .master_awuser_o          ( s_master_aw_user   ),
    .master_awvalid_o         ( s_master_aw_valid  ),
    .master_awready_i         ( s_master_aw_ready  ),

    .master_wdata_o           ( s_master_w_data    ),
    .master_wstrb_o           ( s_master_w_strb    ),
    .master_wlast_o           ( s_master_w_last    ),
    .master_wuser_o           ( s_master_w_user    ),
    .master_wvalid_o          ( s_master_w_valid   ),
    .master_wready_i          ( s_master_w_ready   ),

    .master_bid_i             ( s_master_b_id      ),
    .master_bresp_i           ( s_master_b_resp    ),
    .master_buser_i           ( s_master_b_user    ),
    .master_bvalid_i          ( s_master_b_valid   ),
    .master_bready_o          ( s_master_b_ready   ),

    .master_arid_o            ( s_master_ar_id     ),
    .master_araddr_o          ( s_master_ar_addr   ),
    .master_arlen_o           ( s_master_ar_len    ),
    .master_arsize_o          ( s_master_ar_size   ),
    .master_arburst_o         ( s_master_ar_burst  ),
    .master_arlock_o          ( s_master_ar_lock   ),
    .master_arcache_o         ( s_master_ar_cache  ),
    .master_arprot_o          ( s_master_ar_prot   ),
    .master_arregion_o        ( s_master_ar_region ),
    .master_aruser_o          ( s_master_ar_user   ),
    .master_arqos_o           ( s_master_ar_qos    ),
    .master_arvalid_o         ( s_master_ar_valid  ),
    .master_arready_i         ( s_master_ar_ready  ),

    .master_rid_i             ( s_master_r_id      ),
    .master_rdata_i           ( s_master_r_data    ),
    .master_rresp_i           ( s_master_r_resp    ),
    .master_rlast_i           ( s_master_r_last    ),
    .master_ruser_i           ( s_master_r_user    ),
    .master_rvalid_i          ( s_master_r_valid   ),
    .master_rready_o          ( s_master_r_ready   ),

    .cfg_START_ADDR_i         ( s_start_addr       ),
    .cfg_END_ADDR_i           ( s_end_addr         ),
    .cfg_valid_rule_i         ( s_valid_rule       ),
    .cfg_connectivity_map_i   ( s_connectivity_map )
  );

  assign s_start_addr[0][0] = `MASTER_0_START_ADDR + ( cluster_id_i << 22);
  assign s_end_addr[0][0]   = `MASTER_0_END_ADDR   + ( cluster_id_i << 22);

  assign s_start_addr[0][1] = `MASTER_1_START_ADDR + ( cluster_id_i << 22);
  assign s_end_addr[0][1]   = `MASTER_1_END_ADDR   + ( cluster_id_i << 22);

  assign s_start_addr[0][2] = `MASTER_2_START_ADDR;
  assign s_end_addr[0][2]   = `MASTER_2_END_ADDR;

  assign s_valid_rule       = '1;

  assign s_connectivity_map = '1;

endmodule
