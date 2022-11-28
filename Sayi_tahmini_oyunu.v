`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2022 21:59:03
// Design Name: 
// Module Name: Sayi_tahmini_oyunu
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
module Sayi_tahmini_oyunu(
    input clk,
    input btnU,
    input [15:0]sw,//tu�lar sw15 R2 sw0 u17
    input btnC,//orta tus basarak ba�lar
    output reg [15:0]LED,//ledler
    output reg [3:0]an, //hangi segment blo�una atama yap�ld���n� g�steren ��k��
    output reg [6:0]seg// 7 segment format�nda verilen say�
    );
    reg[7:0] guess; // tahmin edilen sayi
    reg[7:0] diff; // guess ve gelen random say�n�n fark�
    reg[7:0]randomNum;
    reg[3:0] ranNum3=0; // seg 3 i�in random number�n y�zler basama��
    reg[3:0] ranNum2=0; // seg 2  i�in random number�n onlar basama��
    reg[3:0] ranNum1=0; // seg 1 i�in random number�n briler basama��
    reg[31:0]sayac;
    reg saniyelik; // saat yava�latma i�in kullan�lan de�i�ken
    initial begin
     an=0;
     seg=0;
     LED=0;
     sayac=0;
     saniyelik=1;
   end  
    wire [6:0]seg1; // ranNum1 i�in fpgada yanacak segment
    wire [6:0]seg2; // ranNum2 i�in fpgada yanacak segment
    wire [6:0]seg3; // ranNum3 i�in fpgada yanacak segment
    wire [6:0]seg4; // her zaman 0 olacak yanan de�er
    // gelen say� ile yanacak olan segmentlerin atanmas�n� sa�layan mod�l
    segment s1(ranNum1,seg1);
    segment s2(ranNum2,seg2);
    segment s3(ranNum3,seg3);
    segment s4(0,seg4);
    reg start=0; // start tu�unun aktifli�ini kontrol eden de�er (fpgada orta tu�)
    always@(*)begin
        if(start)begin
           if(sw[0]==1)begin // active butonu a��kken
                guess = sw[15:8]; // ilk 8 k�s�mdaki tu�lardan gelecek de�eri guesse atama
                // gelen say�n�n tahmin edilecek say�dan b�y�k m� k���k m� kontrol�nden sonra aralar�ndaki
                // fark� ald�k. daha sonra 16'�ar aral�klar ile fark�n kontrol� yap�l�r. fark b�y�d�k�e yanan led say�s� artt�r�rl�r.
                if(guess > randomNum)begin
                    diff = guess-randomNum;
                    if(diff==0) begin
                        LED=16'b0000000000000000;
                    end
                    else if(diff < 16)begin
                         LED = 16'b0000000000000001;
                    end
                    else if(diff < 32) begin
                         LED = 16'b0000000000000011;
                    end
                    else if(diff < 48) begin
                         LED=16'b0000000000000111;
                    end
                    else if(diff < 64) begin
                         LED=16'b0000000000001111;
                    end
                    else if(diff < 80) begin
                         LED=16'b0000000000011111;
                    end
                    else if(diff < 96) begin
                         LED=16'b0000000000111111;
                    end
                    else if(diff < 112) begin
                         LED=16'b0000000001111111;
                    end
                    else if(diff < 128) begin
                         LED=16'b00000000111111111;
                    end
                    else if(diff < 144) begin
                         LED=16'b00000001111111111;
                    end
                    else if(diff < 160) begin
                         LED=16'b00000011111111111;
                    end
                    else if(diff < 176) begin
                         LED=16'b00000111111111111;
                    end
                    else if(diff < 192) begin
                         LED=16'b00001111111111111;
                    end
                    else if(diff < 208) begin
                         LED=16'b00011111111111111;
                    end
                    else if(diff < 224) begin
                         LED=16'b00111111111111111;
                    end
                    else if(diff < 240) begin
                         LED=16'b01111111111111111;
                    end
                    else begin
                         LED=16'b1111111111111111;
                    end
                    
                end
                else begin
                    diff = randomNum-guess;
                    if(diff==0) begin
                        LED=16'b0000000000000000;
                    end
                    else if(diff < 16)begin
                         LED = 16'b0000000000000001;
                    end
                    else if(diff < 32) begin
                         LED = 16'b0000000000000011;
                    end
                    else if(diff < 48) begin
                         LED=16'b0000000000000111;
                    end
                    else if(diff < 64) begin
                         LED=16'b0000000000001111;
                    end
                    else if(diff < 80) begin
                         LED=16'b0000000000011111;
                    end
                    else if(diff < 96) begin
                         LED=16'b0000000000111111;
                    end
                    else if(diff < 112) begin
                         LED=16'b0000000001111111;
                    end
                    else if(diff < 128) begin
                         LED=16'b00000000111111111;
                    end
                    else if(diff < 144) begin
                         LED=16'b00000001111111111;
                    end
                    else if(diff < 160) begin
                         LED=16'b00000011111111111;
                    end
                    else if(diff < 176) begin
                         LED=16'b00000111111111111;
                    end
                    else if(diff < 192) begin
                         LED=16'b00001111111111111;
                    end
                    else if(diff < 208) begin
                         LED=16'b00011111111111111;
                    end
                    else if(diff < 224) begin
                         LED=16'b00111111111111111;
                    end
                    else if(diff < 240) begin
                         LED=16'b01111111111111111;
                    end
                    else begin
                         LED=16'b1111111111111111;
                    end
                end
           end
           else begin
              guess=0;
           end
        end
    end
    always@(posedge clk)
    begin
        if(btnC==1)begin // start tu�una bas�l�p bas�lmad���n�n kontrol�
            start=1; // butona bas�ld���n� anlamam�z� sa�layan de�i�ken
        end
        if(start==1)begin
            if(btnU == 1)begin // start�n �st�ndeki tu�. her bas�ld���nda yeni bir random say� �retmek i�in var.
                // butona bas�ld��� an randomNuma sayac�n o anki de�eri at�l�r
                randomNum = sayac%256; // 8 bit olaca��nda 256 ile modunu ald�k
                ranNum3=randomNum/100; // y�zler basama�� i�in 
                ranNum2= (randomNum/10)%10; // onlar basama��
                ranNum1= randomNum%10; // birler basama�� i�in
            end
            if(sayac == 10**3/2)begin // sayac yava�latmak i�in var.
                sayac=1;
                saniyelik = ~saniyelik; // sayac her 10^3/2 oldupunda saniyeli�in de�ilini alarak saat yava�latma sa�lan�r
            end
            else 
                sayac = sayac+1;
        end
    end
    localparam LEFT=2'b00,MIDLEFT=2'b01,RIGHT=2'b10,MIDRIGHT=2'b11; // an ve segmnetleri atamak i�iin yard�mc� parametreler.
    reg[1:0] state=LEFT;
    // yava�lat�lm�� saat
    always@(posedge saniyelik )begin
            case(state)
            // stateler an ve segmentleri do�ru kullanmak i�in var ve her bir an b�l�m�n� yakmak i�in var
            // stateler left->mideleft->midright->right->left .. �eklinde d�ng�de olacak hep
            // segler her case i�in at�l�r(segler randomNumdan gelen basamaklar�n de�erleridir)
            LEFT:begin
                seg<=seg4;
                an<=4'b0111; // en soldaki an b�l�m�
                state<=MIDLEFT;
            end
            MIDLEFT:begin
                seg<=seg3;
                an<=4'b1011; // en solun bir yan�ndaki an b�l�m�
                state<=MIDRIGHT;
            end
            MIDRIGHT:begin
                seg<=seg2;
                an<=4'b1101; // en sa��n bir yan�ndaki an b�l�m�
                state<=RIGHT;
            end
            RIGHT:begin
                seg<=seg1;
                an<=4'b1110; // en sa�daki an b�l�m�
                state<=LEFT;                
            end
            endcase
        end        
   // end
endmodule
