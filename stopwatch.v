module stopwatch (
input [1:0] KEY,
input CLOCK_50,
output reg [6:0] HEX0,
output reg [6:0] HEX1,
output reg [6:0] HEX2,
output reg [6:0] HEX3,
output reg [18:0] impulses,
output reg [3:0] one_hundred_sec,
output reg [3:0] one_tenth_sec,
output reg [3:0] one_sec,
output reg [3:0] tenth_sec,
output reg start

);


initial
begin
HEX0 = 7'b1111111;
HEX1 = 7'b1111111;
HEX2 = 7'b1111111;
HEX3 = 7'b1111111;
one_hundred_sec = 4'b0;
one_tenth_sec = 4'b0;
one_sec = 4'b0;
tenth_sec = 4'b0;
start = 1;
end
assign INV_KEY_1 = ~KEY[1];
assign INV_KEY_0 = ~KEY[0];



always @( posedge CLOCK_50 or posedge INV_KEY_1 or posedge INV_KEY_0) begin
	if (INV_KEY_1) begin
		one_hundred_sec <= 4'b0;
		one_tenth_sec <= 4'b0;
		one_sec <= 4'b0;
		tenth_sec <= 4'b0;	
	end else begin
		if (INV_KEY_0) begin
			start = ~start;
		end else begin	
		if (start) begin
			impulses <= impulses + 1;
			if (impulses == 19'b1111010000100011111) begin
				one_hundred_sec <= one_hundred_sec + 1;
				impulses <= 19'b0;
			end
			if (one_hundred_sec == 4'b1010) begin
				one_tenth_sec <= one_tenth_sec + 1;
				one_hundred_sec <= 0;
			end
			if (one_tenth_sec == 4'b1010) begin
				one_sec <= one_sec + 1;
				one_tenth_sec <= 0;
			end
			if (one_sec == 4'b1010) begin
				tenth_sec <= tenth_sec + 1;
				one_sec <= 0;
			end
			if (tenth_sec == 4'b1010) begin
				one_hundred_sec <= 4'b0;
				one_tenth_sec <= 4'b0;
				one_sec <= 4'b0;
				tenth_sec <= 4'b0;
			end
			end
		end
	end
case(one_hundred_sec)
	0: HEX0 = 7'b1000000;
	1: HEX0 = 7'b1111001;
	2: HEX0 = 7'b0100100;
	3:	HEX0 = 7'b0110000;
	4:	HEX0 = 7'b0011001;
	5:	HEX0 = 7'b0010010;
	6:	HEX0 = 7'b0000010;
	7:	HEX0 = 7'b1111000;
	8:	HEX0 = 7'b0000000;
	9:	HEX0 = 7'b0010000;
endcase


case(one_tenth_sec)
	0: HEX1 = 7'b1000000;
	1: HEX1 = 7'b1111001;
	2: HEX1 = 7'b0100100;
	3:	HEX1 = 7'b0110000;
	4:	HEX1 = 7'b0011001;
	5:	HEX1 = 7'b0010010;
	6:	HEX1 = 7'b0000010;
	7:	HEX1 = 7'b1111000;
	8:	HEX1 = 7'b0000000;
	9:	HEX1 = 7'b0010000;
endcase

case(one_sec)
	0: HEX2 = 7'b1000000;
	1: HEX2 = 7'b1111001;
	2: HEX2 = 7'b0100100;
	3:	HEX2 = 7'b0110000;
	4:	HEX2 = 7'b0011001;
	5:	HEX2 = 7'b0010010;
	6:	HEX2 = 7'b0000010;
	7:	HEX2 = 7'b1111000;
	8:	HEX2 = 7'b0000000;
	9:	HEX2 = 7'b0010000;
endcase

case(tenth_sec)
	0: HEX3 = 7'b1000000;
	1: HEX3 = 7'b1111001;
	2: HEX3 = 7'b0100100;
	3:	HEX3 = 7'b0110000;
	4:	HEX3 = 7'b0011001;
	5:	HEX3 = 7'b0010010;
	6:	HEX3 = 7'b0000010;
	7:	HEX3 = 7'b1111000;
	8:	HEX3 = 7'b0000000;
	9:	HEX3 = 7'b0010000;
endcase	
end
endmodule
