module encrypt
  (
   input wire 	       HCLK, n_rst, encrypt,ena,
   input wire [127:0]  keyword, inData,
   input wire [127:0]  subkey0, subkey1, subkey2, subkey3, subkey4, subkey5, subkey6, subkey7, subkey8, subkey9,
   output wire [127:0] result
   );


   reg [127:0] 	       lastIn, inRound, inRound_next, outRound, roundZero; 
   reg [127:0] 	       tempkey, tempkey_next;
   reg [3:0] 	       round;


   always_ff @ (negedge n_rst, posedge HCLK)
     begin : REG_LOGIC
	if(1'b0 == n_rst) begin
	   inRound <= '0;
	   tempkey <= '0;
	   round <= 0;
	end else begin
	   if (ena && encrypt && round < 10) begin
	      inRound <= inRound_next;
	      tempkey <= tempkey_next;
	      round <= round + 1;
	   end else if (!ena) begin
	      inRound <= '0;
	      tempkey <= '0;
	      round <= '0;
	   end else begin
	      inRound <= inRound;
	      tempkey <= tempkey;
	      round <= round;
	   end
	end
     end


   generalRound R1 (.encrypt(encrypt), .input_data(inRound), .keyword(tempkey), .result(outRound));
   lastRound R10 (.encrypt(encrypt), .input_data(lastIn), .keyword(subkey9),.result(result));
   assign roundZero = inData ^ keyword;
   
   always @(outRound, ena) begin
      inRound_next = '0;
      tempkey_next = '0;
      lastIn = '0;
      if (encrypt == 1) begin
	 if (round == 0) begin
	    inRound_next = roundZero;
	    tempkey_next = subkey0;
	 end else if (round < 9) begin
	    inRound_next = outRound;
	    case(round)
	      4'd0: begin tempkey_next = subkey0; end
	      4'd1: begin tempkey_next = subkey1; end
	      4'd2: begin tempkey_next = subkey2; end
	      4'd3: begin tempkey_next = subkey3; end
	      4'd4: begin tempkey_next = subkey4; end
	      4'd5: begin tempkey_next = subkey5; end
	      4'd6: begin tempkey_next = subkey6; end
	      4'd7: begin tempkey_next = subkey7; end
	      4'd8: begin tempkey_next = subkey8; end
	    endcase
	 end else begin
	    lastIn = outRound;
	    inRound_next = inRound;
	    tempkey_next = tempkey;
	 end
      end else begin // if (encrypt == 1)
	 inRound_next = '0;
	 tempkey_next = '0;
         lastIn = '0;
      end
   end
   



endmodule
