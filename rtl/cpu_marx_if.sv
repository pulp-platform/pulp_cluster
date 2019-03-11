// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

interface cpu_marx_if #(
  parameter WOP_CPU      = 0,
  parameter WAPUTYPE     = 0,
  parameter NUSFLAGS_CPU = 1,
  parameter NDSFLAGS_CPU = 1,
  parameter WRESULT      = 32,
  parameter WARG         = 32,
  parameter NARGS_CPU    = 3
);

  // Downstream
  logic                    req_ds_s;
  logic                    ack_ds_s;
  logic     [WAPUTYPE-1:0] type_ds_d;
  logic         [WARG-1:0] operands_ds_d [NARGS_CPU-1:0];
  logic      [WOP_CPU-1:0] op_ds_d;
  logic [NDSFLAGS_CPU-1:0] flags_ds_d;

  // Upstream
  logic                    valid_us_s;
  logic                    ready_us_s;
  logic      [WRESULT-1:0] result_us_d;
  logic [NUSFLAGS_CPU-1:0] flags_us_d;

  // The interface from the perspective of the core.
  modport cpu (
    output req_ds_s,
    output type_ds_d,
    output operands_ds_d,
    output op_ds_d,
    output flags_ds_d,
    output ready_us_s,
    input  ack_ds_s,
    input  valid_us_s,
    input  result_us_d,
    input  flags_us_d
  );

  // The interface from the perspective of the interconnect.
  modport marx (
    input  req_ds_s,
    input  type_ds_d,
    input  operands_ds_d,
    input  op_ds_d,
    input  ready_us_s,
    input  flags_ds_d,
    output ack_ds_s,
    output valid_us_s,
    output result_us_d,
    output flags_us_d
  );

endinterface
