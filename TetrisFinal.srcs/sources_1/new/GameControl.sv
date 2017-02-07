`timescale 1ns / 1ps

/////////////////////////////
//Written by Batuhan Kaynak//
/////////////////////////////

module GameControl(
    input logic clk,
    input logic button_right, button_left, button_rotate, button_down,
    output logic SH_CP, ST_CP, reset, DS, OE,
    output logic[7:0] KATOT,
    output logic [3:0] an,
    output logic a, b, c, d, e, f, g, dp
    );
    
    logic [1:0] scoreRows;
    logic gameState;
    logic [3:0] digits [0:3];
    logic clk_en;
    logic btn_right_en, btn_left_en, btn_rotate_en, btn_down_en;
    
    logic [7:0] checkedMatrix [0:7];
    
    //CHANGE GAMESTATE BACK ON BUTTON CLICK
    GameClock(clk, clk_en);
    
    ButtonSync(clk, button_right, 0, btn_right_en );
    ButtonSync(clk, button_left, 0, btn_left_en );
    ButtonSync(clk, button_rotate, 0, btn_rotate_en );
    ButtonSync(clk, button_down, 0, btn_down_en );
           
    GameLogic(clk, clk_en, btn_right_en, btn_left_en, btn_rotate_en, btn_down_en, checkedMatrix, scoreRows, gameState);
    
    RGBControl(clk, checkedMatrix, SH_CP, ST_CP, reset, DS, OE, KATOT);
    
    ScoreCalculator(clk_end, gameState, scoreRows, digits);
    SevenSegmentDisplay ssd(clk, digits[0], digits[1], digits[2], digits[3], a, b, c, d, e, f, g, dp, an);
    
endmodule
