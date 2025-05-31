`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2025 04:54:27 PM
// Design Name: 
// Module Name: FSM1
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


module FSM1 (
    input  wire clk,       // Reloj del sistema
    input  wire rst,       // Reset asincrónico
    input  wire A, B, C,   // Entradas de código
    output unlock     // Salida: desbloqueo de la caja fuerte
);

    // Definición de estados
    typedef enum wire [2:0] {
        S0, // Estado inicial
        S1, // Primer A ingresado
        S2, // Segundo A ingresado
        S3, // B ingresado correctamente
        S4  // Estado de desbloqueo
    } state_t;

    state_t current_state, next_state;

    // Lógica secuencial de actualización de estado
    always @(posedge clk or posedge rst) begin
        if (rst)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Lógica combinacional de transición de estados
    always @* begin
        next_state = current_state;

        case (current_state)
            S0: if (A && !B && !C) next_state = S1;
            S1: if (A && !B && !C) next_state = S2;
            S2: if (!A && B && !C) next_state = S3;
            S3: next_state = S4;
            S4: next_state = S4; // Permanece desbloqueado hasta reset
            default: next_state = S0;
        endcase
    end

    // Salida combinacional tipo Mealy + Moore
    always @* begin
        // Por defecto, salida en 0
        unlock = 1'b0;

        // Moore: desbloqueo si estamos en estado final
        if (current_state == S4)
            unlock = 1'b1;

        // Mealy: desbloqueo inmediato si transición a S4 por condición válida
        else if (current_state == S3 && !(A || B || C))
            unlock = 1'b1;  // Por ejemplo, si sueltas todos los botones después de ingresar bien
    end

endmodule
