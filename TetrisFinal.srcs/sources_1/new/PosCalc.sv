`timescale 1ns / 1ps

module PosCalc(
        input logic                        clk,
        input logic                   game_clk,
        input logic     [7:0] fallenBlocks[0:7],
        input logic                   btn_right_en,
        input logic                   btn_left_en,
        input logic                   btn_rotate_en,
        input logic                   btn_down_en,
        input logic [2:0] cur_pos_x,
        input logic [2:0] cur_pos_y,
        input logic [1:0]   cur_rot,
        output logic [2:0] new_pos_x,
        output logic [2:0] new_pos_y,
        output logic [1:0]   new_rot
        );
        
        always @ (*) begin
                if (btn_right_en) begin
                    new_pos_x = cur_pos_x + 1; // move right
                    new_pos_y = cur_pos_y;
                    new_rot = cur_rot;
                end else if (btn_left_en) begin //CHANGE FOR ALL PIECES
                    if (cur_pos_x > 0 ) begin
                        new_pos_x = cur_pos_x - 1; // move left
                        new_pos_y = cur_pos_y;
                        new_rot = cur_rot;
                    end else begin
                        new_pos_x = cur_pos_x;
                        new_pos_y = cur_pos_y;
                        new_rot = cur_rot;
                    end
                end else if (btn_rotate_en) begin
                    new_pos_x = cur_pos_x;
                    new_pos_y = cur_pos_y;
                    new_rot = cur_rot + 1; // rotate
                end else if (btn_down_en) begin
                    new_pos_x = cur_pos_x;
                    new_pos_y = cur_pos_y + 1; // move down
                    new_rot = cur_rot;
                end else if (game_clk) begin
                    new_pos_x = cur_pos_x;
                    new_pos_y = cur_pos_y + 1; // move down
                    new_rot = cur_rot;
                end else begin
                    new_pos_x = cur_pos_x;
                    new_pos_y = cur_pos_y;
                    new_rot = cur_rot;
                end
        end    
    endmodule
