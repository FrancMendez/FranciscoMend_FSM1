`timescale 1ns / 1ps
module clk_psc ( 
input 
wire clk_in, 
input 
wire reset, 
output 
reg clk_out ); parameter integer MAX_COUNT = 50_000_000 - 1; 
wire [31:0] counter = 0; always @(posedge clk_in or posedge reset) begin if (reset) begin counter <= 0; clk_out <= 0; end else begin if (counter == MAX_COUNT) begin counter <= 0; clk_out <= ~clk_out; end else begin counter <= counter + 1; end end end end
module