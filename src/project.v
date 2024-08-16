/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_SUMADOR1BIT (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
wire s1, c1, s2;

    C_XOR U1 (.OUT(s1), .A(ui_in[0]), .B(ui_in[1]));
    C_AND U2 (.OUT(c1), .A(ui_in[0]), .B(ui_in[1]));
    C_XOR U3 (.OUT(uo_out[0]), .A(s1), .B(ui_in[2]));
    C_AND U4 (.OUT(s2), .A(s1), .B(ui_in[2]));
    C_XOR U5 (.OUT(uo_out[1]), .A(s2), .B(c1));

    assign uo_out [7:2]  = 6'b0;  
    assign uio_out [7:0] = 8'b0;
    assign uio_oe [7:0]  = 8'b0;

  // List all unused inputs to prevent warnings
    wire _unused = &{ena, clk, rst_n, ui_in [7:3], uio_in [7:0], 1'b0};
endmodule
