module keyScheduling
  (
   input wire [127:0]  keyword,
   input wire [3:0]    roundNum,
   output wire [127:0] subkey
   );
   /*
    */

	reg [31:0] W0, W1, W2, W3, X0, X1, X2, X3, G1;	
	
	
	always_comb begin
			W0 = keyword[127:96];
			W1 = keyword[95:64];
			W2 = keyword[63:32];
			W3 = keyword[31:0];

			X0 = G1 ^ W0;
			X1 = X0 ^ W1;
			X2 = X1 ^ W2;
			X3 = X2 ^ W3;
   			
	end

   	g func_g (.inputWord(W3), .roundNum(roundNum), .outputWord(G1));
      	
	assign subkey = {X0,X1,X2,X3};
   
endmodule 
