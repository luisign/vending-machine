`timescale 1ns / 1ps

import vending_pkg::*;

module vending_top (
    input  logic clk,
    input  logic rst,
    input  logic [1:0] coin_in,
    input  logic [1:0] sel_item,
    input  logic confirm,
    input  logic cancel,

    output logic dispense,
    output logic error_out,
    output logic [7:0] change_out,
    output logic [7:0] display,
    output state_t state_out
);

    logic [7:0] coin_value;
    logic [7:0] credit;
    logic [7:0] price;
    logic [7:0] stock;
    logic [7:0] change_wire;
    logic [7:0] mux_out;

    logic can_sell;
    logic credit_load;
    logic clear;
    logic mem_write;
    logic sel_change;
    logic load_change;
    logic cancel_collect;

    assign display = credit;

    always_comb begin
        case (coin_in)
            2'b01: coin_value = 8'd25;
            2'b10: coin_value = 8'd50;
            2'b11: coin_value = 8'd100;
            default: coin_value = 8'd0;
        endcase
    end

    
    assign mux_out = (sel_change || state_out == CHANGE && cancel) ? credit : change_wire;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            change_out <= 8'b0;
        end else if (load_change || (state_out == COLLECT && cancel)) begin
            change_out <= (state_out == COLLECT && cancel) ? credit : mux_out;
        end
    end

    control_unit u_fsm (
        .clk (clk),
        .rst (rst),
        .coin_in (coin_in),
        .confirm (confirm),
        .cancel (cancel),
        .can_sell (can_sell),
        .credit_load (credit_load),
        .clear (clear),
        .mem_write (mem_write),
        .sel_change (sel_change),
        .load_change (load_change),
        .dispense (dispense),
        .error_out (error_out),
        .state_out (state_out),
        .cancel_collect(cancel_collect)
    );

    credit_reg u_credit_reg (
        .clk (clk),
        .rst (rst),
        .clear (clear),
        .credit_load (credit_load),
        .coin_value (coin_value),
        .credit (credit)
    );

    memory u_memory (
        .clk (clk),
        .rst (rst),
        .mem_write (mem_write),
        .cancel_collect (cancel_collect),
        .sel_item (sel_item),
        .price (price),
        .stock (stock)
    );

    comparator u_comparator (
        .credit (credit),
        .price (price),
        .stock (stock),
        .can_sell (can_sell)
    );

    subtractor u_subtractor (
        .credit (credit),
        .price (price),
        .change (change_wire)
    );

endmodule
