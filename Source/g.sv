module g
(
	input wire [31:0] inputWord,
	input wire [3:0] roundNum,
	output wire [31:0] outputWord
);
	reg [7:0] byte1,byte2,byte3,byte4;
	reg [7:0] subByte1, subByte2, subByte3, subByte4;   
	reg [7:0] rc;
	reg [31:0] tempWord;
	
	always @(inputWord) begin
		byte1 = inputWord[23:16];
		byte2 = inputWord[15:8];
		byte3 = inputWord[7:0];
		byte4 = inputWord[31:24];
		rc = 8'h00;
		case(roundNum)
			1: begin
				rc = 8'h01;
			end
			2: begin
				rc = 8'h02;
			end
			3: begin
				rc = 8'h04;
			end
			4: begin
				rc = 8'h08;
			end
			5: begin
				rc = 8'h10;
			end
			6: begin
				rc = 8'h20;
			end
			7: begin
				rc = 8'h40;
			end
			8: begin
				rc = 8'h80;
			end
			9: begin
				rc = 8'h1B;
			end
			10: begin
				rc = 8'h36;
			end
		endcase
	end

	sbox SBOX (.inputByte(byte1), .outputByte(subByte1));
        sbox SBOX1 (.inputByte(byte2), .outputByte(subByte2));
        sbox SBOX2 (.inputByte(byte3), .outputByte(subByte3));
        sbox SBOX3 (.inputByte(byte4), .outputByte(subByte4));
	
	always_comb begin
        	tempWord[31:24] = subByte1 ^ rc;
        	tempWord[23:16] = subByte2;
  		tempWord[15:8] = subByte3;
		tempWord[7:0] = subByte4;
	end
	
	assign outputWord = tempWord;

endmodule 
	   
