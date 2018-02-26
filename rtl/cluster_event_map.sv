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
 * cluster_event_map.sv
 * Florian Glaser <glaserf@iis.ee.ethz.ch>
 */
 
module cluster_event_map
#(
  parameter NB_CORES = 4
)
(
  // events generated inside event unit
  input  logic [NB_CORES-1:0][7:0]  sw_events_i,
  input  logic [NB_CORES-1:0]       barrier_events_i,
  input  logic [NB_CORES-1:0]       mutex_events_i,
  input  logic [NB_CORES-1:0]       dispatch_events_i,
  input  logic                      periph_fifo_event_i,

  // events from cluster blocks
  input  logic [NB_CORES-1:0][3:0]  acc_events_i,
  input  logic [NB_CORES-1:0][1:0]  dma_events_i,
  input  logic [NB_CORES-1:0][1:0]  timer_events_i,
  input  logic [NB_CORES-1:0][31:0] cluster_events_i,

  output logic [NB_CORES-1:0][31:0] events_mapped_o
);

  genvar I;

  generate
    for ( I = 0; I < NB_CORES; I++ ) begin : CL_EVENT_MAP
      assign events_mapped_o[I][31:28] = '0;
      assign events_mapped_o[I][27]    = periph_fifo_event_i;
      assign events_mapped_o[I][26:24] = '0;
      assign events_mapped_o[I][23:22] = cluster_events_i[I][1:0];
      assign events_mapped_o[I][21:19] = '0;

      assign events_mapped_o[I][18]    = dispatch_events_i[I];
      assign events_mapped_o[I][17]    = mutex_events_i[I];
      assign events_mapped_o[I][16]    = barrier_events_i[I];

      assign events_mapped_o[I][15:12] = acc_events_i[I];
      assign events_mapped_o[I][11:10] = timer_events_i[I];
      assign events_mapped_o[I][9:8]   = dma_events_i[I];
      assign events_mapped_o[I][7:0]   = sw_events_i[I];
    end
  endgenerate

endmodule
