`timescale 1ns / 1ps
module FSM1 ( 
input 
wire clk, 
input 
wire rst, 
input 
wire A, B, C, 
output 
wire unlock ); typedef enum 
wire [2:0] { S0, S1, S2, S3, S4 } state_t; state_t current_state, next_state; always @(posedge clk or posedge rst) begin if (rst) current_state <= S0; else current_state <= next_state; end always @* begin next_state = current_state; case (current_state) S0: if (A && !B && !C) next_state = S1; S1: if (A && !B && !C) next_state = S2; S2: if (!A && B && !C) next_state = S3; S3: next_state = S4; S4: next_state = S4; default: next_state = S0; endcase end always @* begin unlock = 1'b0; if (current_state == S4) unlock = 1'b1; else if (current_state == S3 && !(A || B || C)) unlock = 1'b1; end end
module