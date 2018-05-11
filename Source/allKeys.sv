module allKeys
  (
   input wire 	      HCLK, n_rst, keyEna, 
   input wire [127:0] keyword,
   output reg ena,
   output reg [127:0] subkey0, subkey1, subkey2, subkey3, subkey4, subkey5, subkey6, subkey7, subkey8, subkey9
   );

   reg ena_next;

   reg [3:0] 	      round, roundNum;
   reg [127:0] 	      tempkey, tempkey_next, subkey;
   reg [127:0] 	      subkey0_next, subkey1_next, subkey2_next, subkey3_next, subkey4_next, subkey5_next, subkey6_next, subkey7_next, subkey8_next, subkey9_next;

   always_ff @ (negedge n_rst, posedge HCLK)
     begin : REG_LOGIC
	if(1'b0 == n_rst) begin
	   ena <= 0;
	   tempkey <= '0;
	   round <= 0;
	   subkey0<='0; subkey1<='0; subkey2<='0; subkey3<='0; subkey4<='0;
	   subkey5<='0; subkey6<='0; subkey7<='0; subkey8<='0; subkey9<='0;
	end else begin
	   if (keyEna && round<=10) begin
	      ena <= ena_next;
	      tempkey <= tempkey_next;
	      round <= round + 1;
	      subkey0 <= subkey0_next; subkey1 <= subkey1_next; subkey2 <= subkey2_next; subkey3 <= subkey3_next; subkey4 <= subkey4_next;
	      subkey5 <= subkey5_next; subkey6 <= subkey6_next; subkey7 <= subkey7_next; subkey8 <= subkey8_next; subkey9 <= subkey9_next;
	   end else if (!keyEna) begin
	      ena <= 0;
	      tempkey <= '0;
	      round <= '0;
	      subkey0<='0; subkey1<='0; subkey2<='0; subkey3<='0; subkey4<='0;
	      subkey5<='0; subkey6<='0; subkey7<='0; subkey8<='0; subkey9<='0;
	   end else begin
	      ena <= ena;
	      tempkey <= tempkey;
	      round <= round;
	      subkey0 <= subkey0; subkey1 <= subkey1; subkey2 <= subkey2; subkey3 <= subkey3; subkey4 <= subkey4;
	      subkey5 <= subkey5; subkey6 <= subkey6; subkey7 <= subkey7; subkey8 <= subkey8; subkey9 <= subkey9;
	   end
	end // else: !if(1'b0 == n_rst)
     end // block: REG_LOGIC
   

	always @(keyword, subkey) begin
	   ena_next = 0;
	   tempkey_next = '0;
	   subkey0_next = '0; subkey1_next = '0; subkey2_next = '0; subkey3_next = '0; subkey4_next = '0;
	   subkey5_next = '0; subkey6_next = '0; subkey7_next = '0; subkey8_next = '0; subkey9_next = '0;
	   if (round == 0) begin
	      tempkey_next = keyword;
	   end else if (round <= 10) begin
	      case(round-1)
		4'd0: begin tempkey_next = subkey; 
		   subkey0_next = subkey;end
		4'd1: begin tempkey_next = subkey; 
		   subkey0_next = subkey0; subkey1_next = subkey;end
		4'd2: begin tempkey_next = subkey; 
		   subkey0_next = subkey0; subkey1_next = subkey1; subkey2_next = subkey;end
		4'd3: begin tempkey_next = subkey; 
		   subkey0_next = subkey0; subkey1_next = subkey1; subkey2_next = subkey2; subkey3_next = subkey;end
		4'd4: begin tempkey_next = subkey; 
		   subkey0_next = subkey0; subkey1_next = subkey1; subkey2_next = subkey2; subkey3_next = subkey3; subkey4_next = subkey;end
		4'd5: begin tempkey_next = subkey; 
		   subkey0_next = subkey0; subkey1_next = subkey1; subkey2_next = subkey2; subkey3_next = subkey3; subkey4_next = subkey4; subkey5_next = subkey;end
		4'd6: begin tempkey_next = subkey; 
		   subkey0_next = subkey0; subkey1_next = subkey1; subkey2_next = subkey2; subkey3_next = subkey3; subkey4_next = subkey4; subkey5_next = subkey5;
		   subkey6_next = subkey;end
		4'd7: begin tempkey_next = subkey; 
		   subkey0_next = subkey0; subkey1_next = subkey1; subkey2_next = subkey2; subkey3_next = subkey3; subkey4_next = subkey4;
		   subkey5_next = subkey5; subkey6_next = subkey6; subkey7_next = subkey;end
		4'd8: begin tempkey_next = subkey; 
		   subkey0_next = subkey0; subkey1_next = subkey1; subkey2_next = subkey2; subkey3_next = subkey3; subkey4_next = subkey4;
		   subkey5_next = subkey5; subkey6_next = subkey6; subkey7_next = subkey7; subkey8_next = subkey;end
		4'd9: begin tempkey_next = subkey;
		   ena_next = 1;
		   subkey0_next = subkey0; subkey1_next = subkey1; subkey2_next = subkey2; subkey3_next = subkey3; subkey4_next = subkey4;
		   subkey5_next = subkey5; subkey6_next = subkey6; subkey7_next = subkey7; subkey8_next = subkey8; subkey9_next = subkey; end
	      endcase
	   end else begin
	      ena_next = ena;
	      tempkey_next = tempkey;
	      subkey0_next = subkey0; subkey1_next = subkey1; subkey2_next = subkey2; subkey3_next = subkey3; subkey4_next = subkey4;
	      subkey5_next = subkey5; subkey6_next = subkey6; subkey7_next = subkey7; subkey8_next = subkey8; subkey9_next = subkey9;
	   end // else: !if(round < 10)
	   
	end // always @ (keyword, subkey)
   

   keyScheduling KEYSCH0 (.keyword(tempkey), .roundNum(round), .subkey(subkey));

endmodule
