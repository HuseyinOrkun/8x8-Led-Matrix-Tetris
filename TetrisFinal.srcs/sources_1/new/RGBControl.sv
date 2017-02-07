`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////////////////
//Part of this Module is translated Batuhan Kaynak & Alper Þahistan from Beti VHDL examples //
//////////////////////////////////////////////////////////////////////////////////////////////
module RGBControl(
        input logic clk,
        input logic [7:0] currentBlocks[0:7],
        output logic SH_CP, ST_CP, reset, DS, OE,
        output logic[7:0] KATOT
        );
              
    logic [23:0] msg ;
    logic [7:0] kirmizi, yesil, mavi;
    assign msg[23:16] = kirmizi;///////????????
    assign msg[15:8]  = yesil;
    assign msg[7:0]   = mavi;
    
    logic f;
    logic e;
    
    logic [7:0] counter=0;
    logic [8:0] index =1; //i
    logic [6:0] frame = 0; //d
    logic [2:0] rowNum= 0; //a
    
    always @(posedge clk)
        counter = counter+1;
    
    assign f = counter[7];
    assign e =~f;
    
    always @(posedge e)
        index = index +1;
    
    always_comb
    begin
        if (index<4) 
            reset=0;
       else
            reset=1;
    
    
        if (index>3 && index<28) 
             DS=msg[index-4];
        else 
            DS=0;
    
        if (index<28)
        begin
            SH_CP=f;                
            ST_CP=e;
        end
	   else
         begin
        SH_CP=0;
        ST_CP=1;
         end
    end//of always_comb
     
    always@ (posedge f)
    begin
        if (index>28 && index<409)
            OE<=0;
	else
            OE<=1;
        if (index== 410)
        begin
          rowNum <= rowNum+1;
            if (rowNum==7)
                frame <= frame+1;
        end     
    end
    
/////////////////////////////////////////////////////////////////////////////////////////////
//End of part written by Batuhan Kaynak & Alper Þahistan. Rest is written by Batuhan Kaynak//
/////////////////////////////////////////////////////////////////////////////////////////////
    
    
        
    //CANNOT SEE FIRST STATE
    
    always_comb
    begin
        if (rowNum==0) begin 
            KATOT<=8'b10000000;
        end
        else if(rowNum==1)  begin
            KATOT<=8'b01000000;
        end
        else if (rowNum==2)  begin
            KATOT<=8'b00100000;
        end
        else if (rowNum==3)  begin
            KATOT<=8'b00010000;
        end
        else if (rowNum==4)  begin
            KATOT<=8'b00001000;
        end
        else if (rowNum==5)  begin
            KATOT<=8'b00000100;
        end
        else if (rowNum==6)  begin
            KATOT<=8'b00000010;
        end
        else if (rowNum==7) begin
            KATOT<=8'b00000001;
        end
        
        yesil<=  8'b0000000;
        kirmizi<=8'b00000000;
        
        mavi <= currentBlocks[rowNum];

    end       
endmodule