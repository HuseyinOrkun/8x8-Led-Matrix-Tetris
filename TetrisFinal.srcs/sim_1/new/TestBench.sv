`timescale 1ns / 1ps

module TestBench();

    logic clk;
    logic clk_en;
    logic blockHitGround;
    logic gameState;
    int blk_1, blk_2, blk_3, blk_4;
    logic [7:0] fallenBlocks [0:7];
    logic isPossible;
    logic [7:0] finalMatrix [0:7];
    logic [7:0] checkedMatrix [0:7];
    logic blockHitFallen;
    
    logic [2:0] new_pos_x;
    logic [2:0] cur_pos_x;
    logic [2:0] new_pos_y;
    logic [2:0] cur_pos_y;
    logic [2:0] new_rot;
    
    PosCalc pc(clk, clk_en, fallenBlocks, 0, 0, 0, 0, cur_pos_x, cur_pos_y, 0, new_pos_x, new_pos_y, new_rot);
    GenerateBlock gb(clk, 0, new_pos_x, new_pos_y, new_rot, fallenBlocks, blk_1, blk_2, blk_3, blk_4, isPossible);
    TranslateToDisplay dut(clk, gameState, blk_1, blk_2, blk_3, blk_4, fallenBlocks, isPossible, finalMatrix, blockHitFallen, blockHitGround);
    RowChecker rc(clk, blockHitGround, blockHitFallen, finalMatrix, checkedMatrix, scoreRows);
    
    always begin
        clk = 1; #10; clk = 0; #10;
    end
    
    always begin
        cur_pos_x = new_pos_x; #10;
        cur_pos_y = new_pos_y; #10;
    end
    /*
    always begin
        cur_pos_x = cur_pos_x * (!blockHitGround);
        cur_pos_y = cur_pos_y * (!blockHitGround);
    end*/
    
    always begin
        clk_en = 0; #500; clk_en = 1; #10;
    end
    
    initial begin
        gameState = 1;
        cur_pos_x = 0;
        cur_pos_y = 3;
        fallenBlocks[0] = 8'b00000000;
        fallenBlocks[1] = 8'b00000000;
        fallenBlocks[2] = 8'b00000000;
        fallenBlocks[3] = 8'b00000000;
        fallenBlocks[4] = 8'b00000000;
        fallenBlocks[5] = 8'b00000000;
        fallenBlocks[6] = 8'b00000000;
        fallenBlocks[7] = 8'b00000000;
        #1001;
        cur_pos_x = 0;
        cur_pos_y = 1;
    end
endmodule
