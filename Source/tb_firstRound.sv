`timescale 1ns/10ps

module tb_firstRound();
   localparam	CLK_PERIOD	= 10;
   localparam	CHECK_DELAY = 1;
   localparam   ROUND = 10;
   
   
   integer test_case_num;
   
   //DUT portmap signals
   reg [127:0] tb_keyword, tb_input_data, tb_result, tb_subkey, tb_expected_outputs;
reg[3:0] tb_roundNum;
   
   
   


   //DUT port map
   firstRound DUT(
.roundNum(tb_roundNum),
	       .keyword(tb_keyword),
	       .input_data(tb_input_data),
	       .o_key_add(tb_result),
.subkey(tb_subkey)
	       );


   initial
     begin
	tb_roundNum = 1;
	tb_keyword       =    128'h000102030405060708090a0b0c0d0e0f;
	tb_input_data       = 128'h00112233445566778899aabbccddeeff;
	tb_expected_outputs = 128'h00102030405060708090a0b0c0d0e0f0;
	if(tb_expected_outputs == tb_result) begin
	  $info("Correct subkey Value for test case %d", test_case_num);
       end else begin
	  $error("Incorrect subkey value for test case %d", test_case_num);
       end

     end
endmodule

