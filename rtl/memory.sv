`timescale 1ns / 1ps

module memory (
    input  logic clk,
    input  logic rst,
    input  logic mem_write,
    input  logic cancel_collect,
    input  logic [1:0] sel_item,
    output logic [7:0] price,
    output logic [7:0] stock
);

    logic [7:0] prices_array [0:3];
    logic [7:0] stocks_array [0:3];

    assign price = prices_array[sel_item];
    assign stock = stocks_array[sel_item];

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            prices_array[0] <= 8'd25;  
            stocks_array[0] <= 8'd5;   

            prices_array[1] <= 8'd50;  
            stocks_array[1] <= 8'd5;   

            prices_array[2] <= 8'd75;  
            stocks_array[2] <= 8'd3;   

            prices_array[3] <= 8'd100; 
            stocks_array[3] <= 8'd2;   
            
        end else begin
            if (mem_write && stocks_array[sel_item] > 8'd0) begin
                stocks_array[sel_item] <= stocks_array[sel_item] - 8'd1;
            end
            
            if (cancel_collect) begin
                prices_array <= '{default: 8'd0};
            end else begin
            prices_array[0] <= 8'd25;    

            prices_array[1] <= 8'd50;  


            prices_array[2] <= 8'd75;  
  

            prices_array[3] <= 8'd100; 
     
            end
        end
    end

endmodule
