`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2025 05:00:07 PM
// Design Name: 
// Module Name: Top_module
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


module top_module (
    input clk,            // Reloj de 100MHz de la Basys3
    input btnC,           // Botón central como reset
    input [2:0] sw, // SW[2:0] como entradas A, B, C
    output  [1:0] led             // LED0 como señal de desbloqueo
);

    wire clk_1Hz;
    wire rst;

    // Instancia del prescaler 
    clk_psc #(.MAX_COUNT(50_000_000)) prescaler_inst (
        .clk_in(clk),
        .reset(btnC),
        .clk_out(clk_1Hz)
    );

    assign rst = btnC;

    FSM1 fsm_inst (
        .clk(clk_1Hz),
        .rst(rst),
        .A(sw[0]),
        .B(sw[1]),
        .C(sw[2]),
        .unlock(led[0])
    );

endmodule