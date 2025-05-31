`timescale 1ns / 1ps
module top_
module ( 
input 
wire clk, 
input 
wire btnC, 
input 
wire [2:0] sw, 
output 
wire [1:0] led ); 
wire clk_1Hz; 
wire rst; clk_psc #(.MAX_COUNT(50_000_000)) prescaler_inst ( .clk_in(clk), .reset(btnC), .clk_out(clk_1Hz) ); assign rst = btnC; FSM1 fsm_inst ( .clk(clk_1Hz), .rst(rst), .A(sw[0]), .B(sw[1]), .C(sw[2]), .unlock(led[0]) ); end
module