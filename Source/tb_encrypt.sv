`timescale 1ns/10ps

module tb_encrypt();
   localparam	HCLK_PERIOD	= 5;
   localparam	CHECK_DELAY = 1;
   localparam   ROUND = 10;
   
   
   integer test_case_num;
   
   //DUT portmap signals
   reg [127:0] tb_keyword, tb_input_data, tb_result, tb_expected_outputs;
   reg 	       tb_HCLK,  tb_encrypt,tb_n_rst,tb_ena;
   reg [127:0] subkey0, subkey1, subkey2, subkey3, subkey4, subkey5, subkey6, subkey7, subkey8, subkey9;
   
   


   //DUT port map
   encrypt DUT(
.ena(tb_ena),
	       .HCLK(tb_HCLK),
	       .n_rst(tb_n_rst),
.subkey0(subkey0), .subkey1(subkey1), .subkey2(subkey2), .subkey3(subkey3), .subkey4(subkey4), .subkey5(subkey5), .subkey6(subkey6), .subkey7(subkey7), .subkey8(subkey8), .subkey9(subkey9),
	       .encrypt(tb_encrypt),
	       .keyword(tb_keyword),
	       
	       .inData(tb_input_data),
	       .result(tb_result)

	       );

   always
     begin
	tb_HCLK = 1'b0;
	#(HCLK_PERIOD/2.0);
	tb_HCLK = 1'b1;
	#(HCLK_PERIOD/2.0);
     end
   initial
     begin
tb_ena = 0;
	tb_encrypt = 0;	
	tb_n_rst = 1;
	@(negedge tb_HCLK)
	  tb_n_rst = 0;
	@(posedge tb_HCLK)
	  tb_n_rst = 1;

	@(posedge tb_HCLK)
	  @(posedge tb_HCLK)
	subkey0 = 128'hd6aa74fdd2af72fadaa678f1d6ab76fe;
	subkey1= 		128'hb692cf0b643dbdf1be9bc5006830b3fe;
	subkey2= 		128'hb6ff744ed2c2c9bf6c590cbf0469bf41;
	subkey3= 		128'h47f7f7bc95353e03f96c32bcfd058dfd;
	subkey4= 		128'h3caaa3e8a99f9deb50f3af57adf622aa;
	subkey5= 		128'h5e390f7df7a69296a7553dc10aa31f6b;
	subkey6= 		128'h14f9701ae35fe28c440adf4d4ea9c026;
	subkey7= 	128'h47438735a41c65b9e016baf4aebf7ad2;
	subkey8= 	128'h549932d1f08557681093ed9cbe2c974e;
	subkey9= 	128'h13111d7fe3944a17f307a78b4d2b30c5;
	test_case_num = 1;
@(posedge tb_HCLK)
	  @(posedge tb_HCLK)
	tb_ena = 1;
	tb_encrypt = 1;	
	tb_keyword       =    128'h000102030405060708090a0b0c0d0e0f;
	tb_input_data       = 128'h00112233445566778899aabbccddeeff;
	tb_expected_outputs = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
	#150   
	  if(tb_expected_outputs == tb_result) begin
	     $info("Correct subkey Value for test case %d", test_case_num);
	  end else begin
	     $error("Incorrect subkey value for test case %d", test_case_num);
	  end

	
	
     end
endmodule

