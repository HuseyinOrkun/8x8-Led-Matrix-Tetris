`timescale 1ns / 1ps

module TranslateToDisplay(
    input logic clk,
    input logic gameState,
    input int blk_1, blk_2, blk_3, blk_4,
    input logic [7:0] fallenBlocks [0:7],
    input logic isPossible,
    output logic [7:0] finalMatrix [0:7],
    output logic blockHitFallen,
    output logic blockHitGround
    );
    
    logic [2:0] x_pos1;
    logic [2:0] y_pos1;
    logic [2:0] x_pos2;
    logic [2:0] y_pos2;
    logic [2:0] x_pos3;
    logic [2:0] y_pos3;
    logic [2:0] x_pos4;
    logic [2:0] y_pos4;
    
    assign x_pos1 = blk_1 % 8;
    assign y_pos1 = blk_1 / 8;
    assign x_pos2 = blk_2 % 8;
    assign y_pos2 = blk_2 / 8;
    assign x_pos3 = blk_3 % 8;
    assign y_pos3 = blk_3 / 8;
    assign x_pos4 = blk_4 % 8;
    assign y_pos4 = blk_4 / 8;
    
    logic [7:0] blockMatrix [0:7];
    logic [7:0] blockCol;
    logic [7:0] existingCol;
    logic [7:0] finalCol;
    
    logic [7:0] lastMatrix [0:7];
    
    assign blockHitFallen =  (fallenBlocks[y_pos3 + 1][7 - x_pos3] == 1) || (fallenBlocks[y_pos4 + 1][7 - x_pos4] == 1);
    assign blockHitGround = ((blk_4 / 8) == 7 || (blk_3 / 8) == 7 || (blk_2 / 8) == 7 || (blk_1 / 8) == 7);
    
    always @ (posedge clk)
    begin
        if (gameState == 1) begin
            if (x_pos1 == 0)
                 blockMatrix[y_pos1] = int'(blockMatrix[y_pos1]) + 8'b10000000;
             else
                 blockMatrix[y_pos1] =  int'(blockMatrix[y_pos1])+  2**(7 - x_pos1);
             if (x_pos2 == 0)
                 blockMatrix[y_pos2] = int'(blockMatrix[y_pos2]) + 8'b10000000;
             else
                 blockMatrix[y_pos2] = int'(blockMatrix[y_pos2]) + 2**(7 - x_pos2);
             if (x_pos3 == 0)
                 blockMatrix[y_pos3] = int'(blockMatrix[y_pos3]) + 8'b10000000;
             else
                blockMatrix[y_pos3] = int'(blockMatrix[y_pos3]) + 2**(7 - x_pos3);          
             if (x_pos4 == 0)
                blockMatrix[y_pos4] = int'(blockMatrix[y_pos4]) + 8'b10000000;
             else
                blockMatrix[y_pos4] = int'(blockMatrix[y_pos4]) +  2**(7 - x_pos4);
             if (isPossible) begin
                for (int i = 0; i < 8; i++) begin
                    blockCol = blockMatrix[i];
                    existingCol = fallenBlocks[i];
                    for (int j = 0; j < 8; j++) begin
                        if (blockCol[j] == 1 || existingCol[j] == 1) begin
                            finalCol[j] = 1;
                        end
                        else begin
                            finalCol[j] = 0;
                        end
                    end
                    finalMatrix[i] = finalCol;
                    finalCol = 0;
                end
            end
            blockMatrix[0] = 8'b00000000;
            blockMatrix[1] = 8'b00000000;
            blockMatrix[2] = 8'b00000000;
            blockMatrix[3] = 8'b00000000;
            blockMatrix[4] = 8'b00000000;
            blockMatrix[5] = 8'b00000000;
            blockMatrix[6] = 8'b00000000;
            blockMatrix[7] = 8'b00000000;
        end else begin
            finalMatrix[0] = 8'b01111110;
            finalMatrix[1] = 8'b10000001;
            finalMatrix[2] = 8'b10100101;
            finalMatrix[3] = 8'b10000001;
            finalMatrix[4] = 8'b10100101;
            finalMatrix[5] = 8'b10011001;
            finalMatrix[6] = 8'b10000001;
            finalMatrix[7] = 8'b01111110;
        end
    end
endmodule