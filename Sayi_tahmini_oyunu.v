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
    input [15:0]sw,//tuþlar sw15 R2 sw0 u17
    input btnC,//orta tus basarak baþlar
    output reg [15:0]LED,//ledler
    output reg [3:0]an, //hangi segment bloðuna atama yapýldýðýný gösteren çýkýþ
    output reg [6:0]seg// 7 segment formatýnda verilen sayý
    );
    reg[7:0] guess; // tahmin edilen sayi
    reg[7:0] diff; // guess ve gelen random sayýnýn farký
    reg[7:0]randomNum;
    reg[3:0] ranNum3=0; // seg 3 için random numberýn yüzler basamaðý
    reg[3:0] ranNum2=0; // seg 2  için random numberýn onlar basamaðý
    reg[3:0] ranNum1=0; // seg 1 için random numberýn briler basamaðý
    reg[31:0]sayac;
    reg saniyelik; // saat yavaþlatma için kullanýlan deðiþken
    initial begin
     an=0;
     seg=0;
     LED=0;
     sayac=0;
     saniyelik=1;
   end  
    wire [6:0]seg1; // ranNum1 için fpgada yanacak segment
    wire [6:0]seg2; // ranNum2 için fpgada yanacak segment
    wire [6:0]seg3; // ranNum3 için fpgada yanacak segment
    wire [6:0]seg4; // her zaman 0 olacak yanan deðer
    // gelen sayý ile yanacak olan segmentlerin atanmasýný saðlayan modül
    segment s1(ranNum1,seg1);
    segment s2(ranNum2,seg2);
    segment s3(ranNum3,seg3);
    segment s4(0,seg4);
    reg start=0; // start tuþunun aktifliðini kontrol eden deðer (fpgada orta tuþ)
    always@(*)begin
        if(start)begin
           if(sw[0]==1)begin // active butonu açýkken
                guess = sw[15:8]; // ilk 8 kýsýmdaki tuþlardan gelecek deðeri guesse atama
                // gelen sayýnýn tahmin edilecek sayýdan büyük mü küçük mü kontrolünden sonra aralarýndaki
                // farký aldýk. daha sonra 16'þar aralýklar ile farkýn kontrolü yapýlýr. fark büyüdükçe yanan led sayýsý arttýrýrlýr.
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
        if(btnC==1)begin // start tuþuna basýlýp basýlmadýðýnýn kontrolü
            start=1; // butona basýldýðýný anlamamýzý saðlayan deðiþken
        end
        if(start==1)begin
            if(btnU == 1)begin // startýn üstündeki tuþ. her basýldýðýnda yeni bir random sayý üretmek için var.
                // butona basýldýðý an randomNuma sayacýn o anki deðeri atýlýr
                randomNum = sayac%256; // 8 bit olacaðýnda 256 ile modunu aldýk
                ranNum3=randomNum/100; // yüzler basamaðý için 
                ranNum2= (randomNum/10)%10; // onlar basamaðý
                ranNum1= randomNum%10; // birler basamaðý için
            end
            if(sayac == 10**3/2)begin // sayac yavaþlatmak için var.
                sayac=1;
                saniyelik = ~saniyelik; // sayac her 10^3/2 oldupunda saniyeliðin deðilini alarak saat yavaþlatma saðlanýr
            end
            else 
                sayac = sayac+1;
        end
    end
    localparam LEFT=2'b00,MIDLEFT=2'b01,RIGHT=2'b10,MIDRIGHT=2'b11; // an ve segmnetleri atamak içiin yardýmcý parametreler.
    reg[1:0] state=LEFT;
    // yavaþlatýlmýþ saat
    always@(posedge saniyelik )begin
            case(state)
            // stateler an ve segmentleri doðru kullanmak için var ve her bir an bölümünü yakmak için var
            // stateler left->mideleft->midright->right->left .. þeklinde döngüde olacak hep
            // segler her case için atýlýr(segler randomNumdan gelen basamaklarýn deðerleridir)
            LEFT:begin
                seg<=seg4;
                an<=4'b0111; // en soldaki an bölümü
                state<=MIDLEFT;
            end
            MIDLEFT:begin
                seg<=seg3;
                an<=4'b1011; // en solun bir yanýndaki an bölümü
                state<=MIDRIGHT;
            end
            MIDRIGHT:begin
                seg<=seg2;
                an<=4'b1101; // en saðýn bir yanýndaki an bölümü
                state<=RIGHT;
            end
            RIGHT:begin
                seg<=seg1;
                an<=4'b1110; // en saðdaki an bölümü
                state<=LEFT;                
            end
            endcase
        end        
   // end
endmodule
