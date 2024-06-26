/*
 * Copyright (c) 2024 Neil Powell
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_micro_mult_njp (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  //assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;
  
  wire sys_clk, sys_rst, flag, C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12;
  wire [3:0] A;
  wire [3:0] B;
  wire [7:0] MP;  
  assign sys_rst = !rst_n;
  assign sys_clk = clk;
  assign A[3:0] = ui_in[3:0];
  assign B[3:0] = ui_in[7:4];
  assign uo_out[7:0] = MP[7:0];
               
  ControlUnit P0 (.sys_clk(sys_clk), .sys_rst(sys_rst), .flag(flag), .C0(C0), .C1(C1), .C2(C2), .C3(C3), .C4(C4), .C5(C5), .C6(C6), .C7(C7), .C8(C8), .C9(C9), .C10(C10), .C11(C11), .C12(C12));

  DataPath P1 (.sys_clk(sys_clk), .sys_rst(sys_rst), .flag(flag), .inputA(A), .inputB(B), .SMP_out(MP), .enA(C0), .enB(C1), .enDPO(C2), .ABsel(C3), .sr_c1(C4), .sr_c0(C5), .enSR(C6), .SRsel(C7), .alu_c0(C8), .alu_c1(C9), .alu_c2(C10), .enACC(C11), .clrACC(C12));
  
endmodule
