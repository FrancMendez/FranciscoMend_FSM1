`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2025 05:18:30 PM
// Design Name: 
// Module Name: clk_psc
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clk_psc (
    input  wire clk_in,
    input  wire reset,
    output clk_out
);
    parameter integer MAX_COUNT = 50_000_000 - 1;

    wire [31:0] counter = 0;

    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            counter <= 0;
            clk_out <= 0;
        end else begin
            if (counter == MAX_COUNT) begin
                counter <= 0;
                clk_out <= ~clk_out;  // Alterna clk_out
            end else begin
                counter <= counter + 1;
            end
        end
    end

endmodule