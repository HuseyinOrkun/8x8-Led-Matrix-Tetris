`timescale 1ns / 1ps

/////////////////////////////
//Written by Batuhan Kaynak//
/////////////////////////////
module ScoreCalculator(
    input logic clk_en,
    input logic gameState,
    input logic [1:0] scoreRows,
    output logic [3:0] digits [0:3]
    );
    
    logic [2:0] lastScoreRows;
    logic [13:0] score;
    logic [13:0] currentScore;
    int decimalScore;
    int scoreToInt;
     
    initial begin
        score = 0;
        decimalScore = 0;
        scoreToInt = 0;
    end
    
    always @ (posedge clk_en)
        begin
            if (gameState == 0)
                score <= 0;
                
            score = score + (scoreRows * 100);
            if (scoreRows == 4 && lastScoreRows == 4)
                score = score * 2;
                
            lastScoreRows = scoreRows; 
            decimalScore = score;
                                                        
            for (int i = 0; i <= 3; i++) begin     
                digits[i] = decimalScore % 10;     
                decimalScore = decimalScore / 10;
            end
        end       
endmodule
