`timescale 1ns / 1ps

module credit_reg (
    input  logic clk,
    input  logic rst,
    input  logic clear,
    input  logic credit_load,
    input  logic [7:0] coin_value,
    output logic [7:0] credit
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            credit <= 8'b0;
        end else begin
            
            if (clear) begin
                credit <= 8'b0;
            end 
            else if (credit_load) begin
                credit <= credit + coin_value;
            end
        end
    end

endmodule
