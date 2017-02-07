`timescale 1ns / 1ps

/////////////////////////////
//Written by Batuhan Kaynak//
/////////////////////////////
module GameLogic(
    input logic clk,
    input logic clk_en,
    logic btn_right_en, btn_left_en, btn_rotate_en, btn_down_en,
    output logic [7:0] checkedMatrix[0:7],
    output logic [1:0] scoreRows,
    output logic gameState
    );

    logic [2:0] count;
    logic collision;
    logic isPossible;
    logic blockHitFallen;
    logic blockHitGround;
    logic [1:0] rowCount;
    logic [7:0] finalMatrix[0:7];
    logic [7:0] fallenBlocks[0:7];
    logic [3:0] randomNum;
        
    int blk_1, blk_2, blk_3, blk_4;
    
    logic [2:0] cur_pos_x;
    logic [2:0] cur_pos_y;
    logic [1:0]   cur_rot;
    
    logic [2:0] new_pos_x;
    logic [2:0] new_pos_y;
    logic [1:0]   new_rot;
    
    logic [3:0] piece;
    
    initial begin
        cur_pos_x = 3;
        cur_pos_y = 0;
        cur_rot = 0;
        piece = 0;
        gameState = 1;
        
        fallenBlocks[0] = 8'b00000000;
        fallenBlocks[1] = 8'b00000000;
        fallenBlocks[2] = 8'b00000000;
        fallenBlocks[3] = 8'b00000000;
        fallenBlocks[4] = 8'b00000000;
        fallenBlocks[5] = 8'b00000000;
        fallenBlocks[6] = 8'b00000000;
        fallenBlocks[7] = 8'b00000000; 
    end
    
    PosCalc pc(clk, clk_en, fallenBlocks, btn_right_en, btn_left_en, btn_rotate_en, btn_down_en, cur_pos_x, cur_pos_y, cur_rot, new_pos_x, new_pos_y, new_rot);
    GenerateBlock gb(clk, piece, new_pos_x, new_pos_y, new_rot, fallenBlocks, blk_1, blk_2, blk_3, blk_4, isPossible);
    TranslateToDisplay ttd(clk, gameState, blk_1, blk_2, blk_3, blk_4, fallenBlocks, 1, finalMatrix, blockHitFallen, blockHitGround);
    RowChecker(clk, blockHitGround, blockHitFallen, finalMatrix, checkedMatrix, scoreRows);
    
    Randomizer ran(clk, randomNum);
     
    always @ (posedge clk) begin
        cur_pos_x = new_pos_x;
        cur_pos_y = new_pos_y;
        cur_rot = new_rot;
        
        if (blockHitFallen || blockHitGround) begin
            cur_pos_x = 3;
            cur_pos_y = 0;
            cur_rot = 0;
            piece = randomNum;
            fallenBlocks = checkedMatrix;
        end
        
        if (fallenBlocks[0][3] == 1) begin
            gameState = 0;
        end
    end
endmodule
