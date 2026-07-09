`timescale 1ns / 1ps

package vending_pkg;

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        COLLECT = 3'b001,
        CHECK = 3'b010,
        DISPENSE = 3'b011,
        CHANGE = 3'b100,
        ERROR = 3'b101
    } state_t;
    
    localparam int DATA_W = 8;
    localparam int SEL_W  = 2;

endpackage
