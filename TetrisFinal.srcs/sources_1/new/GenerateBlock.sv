`timescale 1ns / 1ps

module GenerateBlock(
    input logic clk,
    input logic [2:0] piece,
    input logic [2:0] pos_x,
    input logic [2:0] pos_y,
    input logic [1:0] rot,
    input logic [7:0] fallenBlocks[0:7],
    output int blk_1, blk_2, blk_3, blk_4,
    output logic IsPossible
    );
    
    //typedef enum logic [2:0] {L_BLOCK, O_BLOCK, I_BLOCK} statetype;
    
    parameter I_BLOCK = 0;
    parameter O_BLOCK = 1;
    parameter L_BLOCK = 2;
    //parameter S_BLOCK = 3;
    //parameter Z_BLOCK = 4;
    
    //, S_BLOCK, Z_BLOCK
    logic IsPossibleEdge;
    logic IsPossibleCol;
      
    assign IsPossible = IsPossibleCol; //&& ~blockHitFallen;
    
    logic x_pos1;
    logic y_pos1;
    logic x_pos2;
    logic y_pos2;
    logic x_pos3;
    logic y_pos3;
    logic x_pos4;
    logic y_pos4;
    
    assign x_pos1 = blk_1 % 8;
    assign y_pos1 = blk_1 / 8;
    assign x_pos2 = blk_2 % 8;
    assign y_pos2 = blk_2 / 8;
    assign x_pos3 = blk_3 % 8;
    assign y_pos3 = blk_3 / 8;
    assign x_pos4 = blk_4 % 8;
    assign y_pos4 = blk_4 / 8;
    
    assign IsPossibleCol = !((fallenBlocks[y_pos1][x_pos1] == 1)||(fallenBlocks[y_pos2][x_pos2] == 1)||(fallenBlocks[y_pos3][x_pos3] == 1)||(fallenBlocks[y_pos4][x_pos4] == 1));
    
    always @ (posedge clk) begin
        //IsPossibleEdge = 1;
        case (piece)
            I_BLOCK: begin
            if (rot == 1 || rot == 3) begin
                if(int'(pos_x) < 5) begin
                    blk_1 = (pos_y * 8) + pos_x;
                    blk_2 = (pos_y * 8) + pos_x + 1;
                    blk_3 = (pos_y * 8) + pos_x + 2;
                    blk_4 = (pos_y * 8) + pos_x + 3;
                    IsPossibleEdge = 1;
                end else
                    IsPossibleEdge = 0;
            end else begin
                if(rot == 0 || rot == 2)begin
                    blk_1 = (pos_y * 8) + pos_x;
                    blk_2 = ((pos_y + 1) * 8) + pos_x;
                    blk_3 = ((pos_y + 2) * 8) + pos_x;
                    blk_4 = ((pos_y + 3) * 8) + pos_x;
                    IsPossibleEdge = 1;
                end else
                    IsPossibleEdge = 0;
                end
            end
            O_BLOCK: begin
                if(int'(pos_x)<7) begin
                    blk_1 = (pos_y * 8) + pos_x;
                    blk_2 = (pos_y * 8) + pos_x + 1;
                    blk_3 = ((pos_y + 1) * 8) + pos_x;
                    blk_4 = ((pos_y + 1) * 8) + pos_x + 1;
                    IsPossibleEdge = 1;
                end
                else
                    IsPossibleEdge = 0;
            end
            L_BLOCK: begin
                case (rot)
                    0: begin
                        if (int'(pos_x) < 7) begin
                            blk_1 = (pos_y * 8) + pos_x;
                            blk_2 = ((pos_y + 1) * 8) + pos_x;
                            blk_3 = ((pos_y + 2) * 8) + pos_x;
                            blk_4 = ((pos_y + 2) * 8) + pos_x + 1;
                            IsPossibleEdge = 1;
                        end else 
                            IsPossibleEdge = 0;
                    end
                    1: begin
                        if (int'(pos_x) < 6) begin
                        blk_1 = ((pos_y + 1) * 8) + pos_x;
                        blk_2 = (pos_y * 8) + pos_x;
                        blk_3 = (pos_y * 8) + pos_x + 1;
                        blk_4 = (pos_y * 8) + pos_x + 2;
                        IsPossibleEdge = 1;
                    end else
                        IsPossibleEdge = 0;
                    end
                    2: begin
                        if (int'(pos_x) < 7) begin
                            blk_1 = (pos_y * 8) + pos_x + 1;
                            blk_2 = ((pos_y + 1) * 8) + pos_x + 1;
                            blk_3 = ((pos_y + 2) * 8) + pos_x + 1;
                            blk_4 = (pos_y * 8) + pos_x;
                            IsPossibleEdge = 1;
                        end else
                            IsPossibleEdge = 0;
                    end
                    3: begin
                        if (int'(pos_x) < 7) begin
                            blk_1 = ((pos_y + 1) * 8) + pos_x;
                            blk_2 = ((pos_y + 1) * 8) + pos_x + 1;
                            blk_3 = ((pos_y + 1) * 8) + pos_x + 2;
                            blk_4 = (pos_y * 8) + pos_x + 2;
                            IsPossibleEdge = 1;
                        end else
                            IsPossibleEdge = 0;
                    end
                endcase
            end
            /*
            S_BLOCK: begin 
                if (rot == 0 || rot == 2) begin
                    if(int'(pos_x) < 7 && int'(pos_x) > 0) begin
                            blk_1 = (pos_y * 8) + pos_x + 1;
                            blk_2 = (pos_y * 8) + pos_x ;
                            blk_3 = ((pos_y + 1) * 8) + pos_x;
                            blk_4 = ((pos_y + 1) * 8) + pos_x - 1 ;
                            IsPossibleEdge = 1;  
                        end else
                            IsPossibleEdge = 0;
                    end
                    else
                        IsPossibleEdge = 0;
                    if(rot == 1 || rot == 3) begin
                        if(int'(pos_x) < 7) begin
                            blk_1 = (pos_y * 8) + pos_x;
                            blk_2 = ((pos_y + 1) * 8) + pos_x;
                            blk_3 = ((pos_y + 1) * 8) + pos_x + 1;
                            blk_4 = ((pos_y + 2) * 8) + pos_x + 1;
                            IsPossibleEdge = 1;
                        end else
                            IsPossibleEdge = 0;
                   end
                   else
                        IsPossibleEdge = 0;
               end
               Z_BLOCK: begin
                   if (rot == 0 || rot == 2) begin
                       if(int'(pos_x) < 6) begin
                           blk_1 = (pos_y * 8) + pos_x;
                           blk_2 = (pos_y * 8) + pos_x + 1;
                           blk_3 = ((pos_y + 1) * 8) + pos_x + 1;
                           blk_4 = ((pos_y + 1) * 8) + pos_x + 2;
                           IsPossibleEdge = 1;
                       end else
                           IsPossibleEdge = 0;
                   end else begin
                       if (int'(pos_x) < 7) begin
                           blk_1 = (pos_y * 8) + pos_x + 1;
                           blk_2 = ((pos_y + 1) * 8) + pos_x;
                           blk_3 = ((pos_y + 2) * 8) + pos_x;
                           blk_4 = ((pos_y + 1) * 8) + pos_x + 1;
                           IsPossibleEdge = 1;
                       end else
                           IsPossibleEdge = 0;
                   end
               end*/
        endcase
            
               
//            `T_BLOCK: begin
//                case (rot)
//                    0: begin
//                        blk_1 = (pos_y * 8) + pos_x + 1;
//                        blk_2 = ((pos_y + 1) * 8) + pos_x;
//                        blk_3 = ((pos_y + 1) * 8) + pos_x + 1;
//                        blk_4 = ((pos_y + 1) * `BLOCKS_WIDE) + pos_x + 2;
//                        width = 3;
//                        height = 2;
//                    end
//                    1: begin
//                        blk_1 = (pos_y * `BLOCKS_WIDE) + pos_x;
//                        blk_2 = ((pos_y + 1) * `BLOCKS_WIDE) + pos_x;
//                        blk_3 = ((pos_y + 2) * `BLOCKS_WIDE) + pos_x;
//                        blk_4 = ((pos_y + 1) * `BLOCKS_WIDE) + pos_x + 1;
//                        width = 2;
//                        height = 3;
//                    end
//                    2: begin
//                        blk_1 = (pos_y * `BLOCKS_WIDE) + pos_x;
//                        blk_2 = (pos_y * `BLOCKS_WIDE) + pos_x + 1;
//                        blk_3 = (pos_y * `BLOCKS_WIDE) + pos_x + 2;
//                        blk_4 = ((pos_y + 1) * `BLOCKS_WIDE) + pos_x + 1;
//                        width = 3;
//                        height = 2;
//                    end
//                    3: begin
//                        blk_1 = (pos_y * `BLOCKS_WIDE) + pos_x + 1;
//                        blk_2 = ((pos_y + 1) * `BLOCKS_WIDE) + pos_x + 1;
//                        blk_3 = ((pos_y + 2) * `BLOCKS_WIDE) + pos_x + 1;
//                        blk_4 = ((pos_y + 1) * `BLOCKS_WIDE) + pos_x;
//                        width = 2;
//                        height = 3;
//                    end
//                endcase
//            end
            
            
//            `J_BLOCK: begin
//                case (rot)
//                    0: begin
//                        blk_1 = (pos_y * `BLOCKS_WIDE) + pos_x + 1;
//                        blk_2 = ((pos_y + 1) * `BLOCKS_WIDE) + pos_x + 1;
//                        blk_3 = ((pos_y + 2) * `BLOCKS_WIDE) + pos_x + 1;
//                        blk_4 = ((pos_y + 2) * `BLOCKS_WIDE) + pos_x;
//                        width = 2;
//                        height = 3;
//                    end
//                    1: begin
//                        blk_1 = (pos_y * `BLOCKS_WIDE) + pos_x;
//                        blk_2 = ((pos_y + 1) * `BLOCKS_WIDE) + pos_x;
//                        blk_3 = ((pos_y + 1) * `BLOCKS_WIDE) + pos_x + 1;
//                        blk_4 = ((pos_y + 1) * `BLOCKS_WIDE) + pos_x + 2;
//                        width = 3;
//                        height = 2;
//                    end
//                    2: begin
//                        blk_1 = (pos_y * `BLOCKS_WIDE) + pos_x;
//                        blk_2 = ((pos_y + 1) * `BLOCKS_WIDE) + pos_x;
//                        blk_3 = ((pos_y + 2) * `BLOCKS_WIDE) + pos_x;
//                        blk_4 = (pos_y * `BLOCKS_WIDE) + pos_x + 1;
//                        width = 2;
//                        height = 3;
//                    end
//                    3: begin
//                        blk_1 = (pos_y * `BLOCKS_WIDE) + pos_x;
//                        blk_2 = (pos_y * `BLOCKS_WIDE) + pos_x + 1;
//                        blk_3 = (pos_y * `BLOCKS_WIDE) + pos_x + 2;
//                        blk_4 = ((pos_y + 1) * `BLOCKS_WIDE) + pos_x + 2;
//                        width = 3;
//                        height = 2;
//                    end
//                endcase
//            end
    end
endmodule
