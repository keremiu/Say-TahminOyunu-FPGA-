`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2022 22:49:40
// Design Name: 
// Module Name: segment
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// segment modulü gelen num deðeri için yanacak segment deðerlerini segment deðikenine atar.
module segment(
    input[3:0]num,
    output reg[6:0]segment
    );
    always@(*)begin
        case(num)
            4'b0000:segment=7'b1000000; //0
            4'b0001:segment=7'b1111001; //1
            4'b0010:segment=7'b0100100; //2
            4'b0011:segment=7'b0110000; //3 0110000
            4'b0100:segment=7'b0011001; //4 0011001
            4'b0101:segment=7'b0010010; //5 0010010
            4'b0110:segment=7'b0000010; //6
            4'b0111:segment=7'b1111000; //7
            4'b1000:segment=7'b0000000; //8
            4'b1001:segment=7'b0010000; //9
      
        endcase
    end
    
    
endmodule
