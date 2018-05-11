`timescale 1ns/10ps

module tb_lastRound();
   localparam	CHECK_DELAY = 1;
   localparam   ROUND = 10;
   
   
   integer test_case_num;
   
   //DUT portmap signals
   reg [127:0] tb_keyword, tb_input_data, tb_result,tb_expected_outputs;
	reg[3:0] tb_roundNum;
   reg tb_encrypt;
   
  
   //DUT port map
   lastRound DUT(
		.encrypt(tb_encrypt),
	       .keyword(tb_keyword),
	       .input_data(tb_input_data),
	       .result(tb_result)
	       );


   initial
     begin

	tb_encrypt = 1;
	tb_keyword       =    128'h13111d7fe3944a17f307a78b4d2b30c5;
	tb_input_data       = 128'hbd6e7c3df2b5779e0b61216e8b10b689;
	tb_expected_outputs = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;

	#5
	if(tb_expected_outputs == tb_result) begin
	  $info("Correct subkey Value for test case %d", test_case_num);
       end else begin
	  $error("Incorrect subkey value for test case %d", test_case_num);
       end



     end
endmodule

