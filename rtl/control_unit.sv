`timescale 1ns / 1ps

import vending_pkg::*; 

module control_unit (
    input logic clk,
    input logic rst,

    input logic [1:0] coin_in,
    input logic confirm,
    input logic cancel,

    input logic can_sell,

    output logic credit_load,
    output logic clear,
    output logic mem_write,
    output logic sel_change,
    output logic load_change,
    output logic cancel_collect,
    output logic dispense,
    output logic error_out,
    output state_t state_out
);

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    assign state_out = current_state;

    always_comb begin
        next_state = current_state; 

        case (current_state)
            IDLE: begin
                if (coin_in != 2'b00) 
                    next_state = COLLECT;
            end
            
            COLLECT: begin
                if (cancel) begin
                    next_state = CHANGE;
                end else if (confirm) begin
                    next_state = CHECK;
                end
            end
            
            CHECK: begin
                if (can_sell) 
                    next_state = DISPENSE;
                else 
                    next_state = ERROR;
            end
            
            DISPENSE: begin
                next_state = CHANGE;
            end
            
            CHANGE: begin
                next_state = IDLE;
            end
            
            ERROR: begin
                if (cancel)
                    next_state = IDLE;
                else
                    next_state = ERROR;
            end
            
            default: next_state = IDLE;
        endcase
    end

    always_comb begin
        credit_load    = 1'b0;
        clear          = 1'b0;
        mem_write      = 1'b0;
        sel_change     = 1'b0;
        load_change    = 1'b0;
        cancel_collect = 1'b0;
        dispense       = 1'b0;
        error_out      = 1'b0;

        case (current_state)
            IDLE: begin
                if (coin_in != 2'b00) begin
                    credit_load = 1'b1;
                end
            end
            
            COLLECT: begin
                if (coin_in != 2'b00) begin
                    credit_load = 1'b1;
                end
                if (cancel) begin
                    cancel_collect = 1'b1;
                end
            end
            
            CHECK: begin

            end
            
            DISPENSE: begin
                dispense    = 1'b1;
                mem_write   = 1'b1;
                load_change = 1'b1;
                sel_change  = 1'b0; 
            end
            
            CHANGE: begin
                clear = 1'b1; 
                if (cancel_collect) begin
                    load_change = 1'b1;
                    sel_change  = 1'b1;
                end
            end
            
            ERROR: begin
                error_out   = 1'b1;
                sel_change  = 1'b1; 
                load_change = 1'b1;
                if (cancel) begin
                    clear = 1'b1;
                end
            end
        endcase
    end

endmodule
