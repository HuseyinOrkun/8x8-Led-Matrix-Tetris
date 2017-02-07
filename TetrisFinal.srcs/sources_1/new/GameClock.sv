`timescale 1ns / 1ps

/////////////////////////////
//Written by Batuhan Kaynak//
/////////////////////////////
module GameClock(
    input logic clk,
    output logic clk_en
    );
    
    reg [28:0] count;

    logic [28:0] limit = 100_000_000;
    
    always@ (posedge clk)
        begin
            count <= count + 1;
            
            if (count == limit)
                count <= 28'd0;
            if (count == 28'd0)
                clk_en <= 1'b1;
            else
                clk_en <= 1'b0;
        end
endmodule
