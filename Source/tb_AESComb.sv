`timescale 1ns/10ps

module tb_AESComb();
   localparam	CLK_PERIOD	= 10;
   localparam	CHECK_DELAY = 1;
   localparam   ROUND = 10;
   
   
   integer test_case_num = 0;
   
   //DUT portmap signals
   reg [127:0] tb_keyword, tb_input_data, tb_result, tb_expected_outputs;
   reg tb_HCLK, tb_n_rst, tb_encrypt, tb_keyEna;
   
   


   //DUT port map
   AESComb DUT(
.keyEna(tb_keyEna),
		.HCLK(tb_HCLK),
		.n_rst(tb_n_rst),
.encrypt(tb_encrypt),
	       .keyword(tb_keyword),
	       .input_data(tb_input_data),
	       .AESresult(tb_result)
	       );

	always
	begin
		tb_HCLK = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_HCLK = 1'b1;
		#(CLK_PERIOD/2.0);
	end
   initial
     begin
	tb_encrypt = 0;
	tb_keyEna = 0;
	tb_n_rst = 0;
	@(posedge tb_HCLK)
	tb_n_rst = 1;
	@(posedge tb_HCLK)
	@(posedge tb_HCLK)



	//Test case 1
	test_case_num = 1;
	tb_encrypt = 0;
	tb_keyEna = 1;
	tb_keyword       =    128'h000102030405060708090a0b0c0d0e0f;
	tb_input_data       = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
	tb_expected_outputs = 128'h00112233445566778899aabbccddeeff;
	period(22);   
       if(tb_expected_outputs == tb_result) begin
	  $info("Correct result for test case %d", test_case_num);
       end else begin
	  $error("Incorrect result for test case %d", test_case_num);
       end
	period(1);
	tb_keyEna = 0;
	period(2);
 
	
	tb_encrypt = 1;	
	tb_keyEna = 1;
	tb_keyword       =    128'h000102030405060708090a0b0c0d0e0f;
	tb_input_data       = 128'h00112233445566778899aabbccddeeff;
	tb_expected_outputs = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
	period(22);
       if(tb_expected_outputs == tb_result) begin
	  $info("Correct result for test case %d", test_case_num);
       end else begin
	  $error("Incorrect result for test case %d", test_case_num);
       end
	period(1);
	tb_keyEna = 0;
	period(2);
 
	
	
	//Test case 2
	test_case_num = test_case_num + 1;
	tb_encrypt = 1;	
	tb_keyEna = 1;
	tb_keyword       =    128'h00112233445566778899AABBCCDDEEFF;
	tb_input_data       = 128'haeaeaeaeaeaeaeaeaeaeaeaeaeaeaeae;
	tb_expected_outputs = 128'h4adf494c4a532e3f53a701e95e4fbdf2;
	period(22);  
       if(tb_expected_outputs == tb_result) begin
	  $info("Correct result for test case %d", test_case_num);
       end else begin
	  $error("Incorrect result for test case %d", test_case_num);
       end
	period(1);
	tb_keyEna = 0;
	period(2);
 

	tb_encrypt = 0;
	tb_keyEna = 1;
	tb_keyword       =    128'h00112233445566778899AABBCCDDEEFF;
  
	tb_input_data       = 128'haeaeaeaeaeaeaeaeaeaeaeaeaeaeaeae;;
	tb_expected_outputs = 128'h3692a0c4262ca8352c646926d61d60f9;
	period(22);  
       if(tb_expected_outputs == tb_result) begin
	  $info("Correct result for test case %d", test_case_num);
       end else begin
	  $error("Incorrect result for test case %d", test_case_num);
       end
	period(1);
	tb_keyEna = 0;
	period(2);
 
	
	//Test Case 3
	test_case_num = test_case_num + 1;
	tb_encrypt = 1;	
	tb_keyEna = 1;
	tb_keyword       =    128'hAABBCCDDEEFFAABBCCDDEEFFAABBCCDD;
  
	tb_input_data       = 128'h00110022003300440055006600770088;
	tb_expected_outputs = 128'hb1a1d2bf4e05de15f8176bfdf81836bf;
	period(22);  
       if(tb_expected_outputs == tb_result) begin
	  $info("Correct result for test case %d", test_case_num);
       end else begin
	  $error("Incorrect result for test case %d", test_case_num);
       end
	period(1);
	tb_keyEna = 0;
	period(2);
 

	tb_encrypt = 0;
	tb_keyEna = 1;
	tb_keyword       =    128'hAABBCCDDEEFFAABBCCDDEEFFAABBCCDD;
  
	tb_input_data       = 128'h00110022003300440055006600770088;
	tb_expected_outputs = 128'hb492794dbcb5aca13d796b4eddea21c1;
	period(22);  
       if(tb_expected_outputs == tb_result) begin
	  $info("Correct result for test case %d", test_case_num);
       end else begin
	  $error("Incorrect result for test case %d", test_case_num);
       end
	period(1);
	tb_keyEna = 0;
	period(2);

	//Test Case 4
	test_case_num = test_case_num + 1;
	tb_encrypt = 1;	
	tb_keyEna = 1;
	tb_keyword       =    128'h11111111111111111111111111111111;
  
	tb_input_data       = 128'h00000000000000000000000000000000;
	tb_expected_outputs = 128'he0d541314e00102d6dfca8bc007b6c8a;
	period(22);  
       if(tb_expected_outputs == tb_result) begin
	  $info("Correct result for test case %d", test_case_num);
       end else begin
	  $error("Incorrect result for test case %d", test_case_num);
       end
	period(1);
	tb_keyEna = 0;
	period(2);
 

	tb_encrypt = 0;
	tb_keyEna = 1;
	tb_keyword       =    128'h11111111111111111111111111111111;
	tb_input_data       = 128'h00000000000000000000000000000000;
	tb_expected_outputs = 128'h5e749c2d64e5ef78279337670223fc08;
	period(22);  
       if(tb_expected_outputs == tb_result) begin
	  $info("Correct result for test case %d", test_case_num);
       end else begin
	  $error("Incorrect result for test case %d", test_case_num);
       end
	period(1);
	tb_keyEna = 0;
	period(2);
 

	//Test Case 5
	test_case_num = test_case_num + 1;
	tb_encrypt = 1;	
	tb_keyword       =    128'h00000000000000001111111111111111;
	tb_keyEna = 1;
	tb_input_data       = 128'h11111111111111110000000000000000;
	tb_expected_outputs = 128'h176f6d17991714b59e167a459c97444c;
	period(22);  
       if(tb_expected_outputs == tb_result) begin
	  $info("Correct result for test case %d", test_case_num);
       end else begin
	  $error("Incorrect result for test case %d", test_case_num);
       end
	period(1);
	tb_keyEna = 0;
	period(2);
 

	tb_encrypt = 0;
	tb_keyword       =    128'h00000000000000001111111111111111;
  	tb_keyEna = 1;
	tb_input_data       = 128'h11111111111111110000000000000000;
	tb_expected_outputs = 128'hffd2338e7eccb2f65c87a772d3d809c9;
	period(22);  
       if(tb_expected_outputs == tb_result) begin
	  $info("Correct result for test case %d", test_case_num);
       end else begin
	  $error("Incorrect result for test case %d", test_case_num);
       end
 
	
     end

  task period(input integer cycle);
     repeat (cycle) begin
	@(posedge tb_HCLK);
     end
   endtask // period

endmodule

