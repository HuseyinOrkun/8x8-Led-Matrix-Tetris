`timescale 1ns / 1ps

/////////////////////////////
//Written by Batuhan Kaynak//
/////////////////////////////
module Randomizer(
    input logic clk,
    output logic [3:0] randomNum
    );
    
    initial begin
        randomNum = 0;
    end
    
    always @ (posedge clk)
        begin
            if (randomNum == 2)
                randomNum <= 0;
            
            randomNum <= randomNum + 1;
            //randomNum <= {randomNum[2:0], ~(randomNum[3] ^ randomNum[2])}; //Generate a 4 bir random number.
            //random <= randomNum[1:0]; 
        end
endmodule
