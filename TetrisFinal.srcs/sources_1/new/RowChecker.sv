`timescale 1ns / 1ps

module RowChecker(
    input logic clk,
    input logic blockHitGround,
    input logic blockHitFallen,
    input logic [7:0] finalMatrix[0:7],
    output logic [7:0] checkedMatrix [0:7],
    output logic [1:0] scoreRows
    );
    
    logic collision;
    logic [1:0] rowCount;
    logic [2:0] lastIndex;
    logic [2:0] loopCount;
    
    
    initial begin
        rowCount = 0;
        lastIndex = 0;
        loopCount = 7;
    end
    
    always @ (*) begin
        checkedMatrix = finalMatrix;
         if (blockHitFallen || blockHitGround) begin
           for(int i = 0; i < 8; i++) begin
              if (checkedMatrix[i] == 8'b11111111) begin
                   checkedMatrix[i] = 8'b00000000;
                   collision = 1;
                   rowCount = rowCount + 1;
                   lastIndex = i;
              end 
           end
           if(collision == 1) begin
               for (int j = 0; j < rowCount; j++) begin
                   loopCount = lastIndex;
                   for (int k = 7; k > 0; k--) begin
                       checkedMatrix[loopCount] = checkedMatrix[loopCount - 1];
                       if (loopCount == 1)
                            break;
                       loopCount = loopCount - 1;
                   end
                   checkedMatrix[0] = 8'b00000000;
               end
           end
           collision = 0;
           scoreRows = rowCount;
       end
       rowCount = 0;
   end
endmodule
