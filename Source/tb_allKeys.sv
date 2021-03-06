`timescale 1ns/10ps

module tb_allKeys();
   localparam	CLK_PERIOD	= 10;
   localparam	CHECK_DELAY = 1;
   localparam   ROUND = 10;
   
   
   integer test_case_num = 0;
   
   //DUT portmap signals
   reg [127:0] tb_keyword;
   reg tb_HCLK, tb_n_rst, tb_keyEna, tb_ena;
   reg [127:0] tb_subkey0, tb_subkey1, tb_subkey2, tb_subkey3, tb_subkey4, tb_subkey5, tb_subkey6, tb_subkey7, tb_subkey8, tb_subkey9;
   reg [127:0] subkey0, subkey1, subkey2, subkey3, subkey4, subkey5, subkey6, subkey7, subkey8, subkey9;


   //DUT port map
   allKeys DUT(
		.HCLK(tb_HCLK),
		.n_rst(tb_n_rst),
		.ena(tb_ena),
	       .keyword(tb_keyword),
.keyEna(tb_keyEna),
.subkey0(subkey0), .subkey1(subkey1), .subkey2(subkey2), .subkey3(subkey3), .subkey4(subkey4), .subkey5(subkey5), .subkey6(subkey6), .subkey7(subkey7), .subkey8(subkey8), .subkey9(subkey9)
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
	tb_keyEna = 0;
	tb_n_rst = 0;
	@(posedge tb_HCLK)
	tb_n_rst = 1;
	@(posedge tb_HCLK)
	@(posedge tb_HCLK)

	//Test case 1
	test_case_num = 0;
	tb_keyword       =    128'h000102030405060708090a0b0c0d0e0f;
	tb_keyEna = 1;
	period(12);
	
	tb_subkey0 = 128'hd6aa74fdd2af72fadaa678f1d6ab76fe;
	tb_subkey1= 		128'hb692cf0b643dbdf1be9bc5006830b3fe;
	tb_subkey2= 		128'hb6ff744ed2c2c9bf6c590cbf0469bf41;
	tb_subkey3= 		128'h47f7f7bc95353e03f96c32bcfd058dfd;
	tb_subkey4= 		128'h3caaa3e8a99f9deb50f3af57adf622aa;
	tb_subkey5= 		128'h5e390f7df7a69296a7553dc10aa31f6b;
	tb_subkey6= 		128'h14f9701ae35fe28c440adf4d4ea9c026;
	tb_subkey7= 	128'h47438735a41c65b9e016baf4aebf7ad2;
	tb_subkey8= 	128'h549932d1f08557681093ed9cbe2c974e;
	tb_subkey9= 	128'h13111d7fe3944a17f307a78b4d2b30c5;  
       if(subkey0 == tb_subkey0) begin
	  $info("Correct subkey Value for test case %d", test_case_num);
       end else begin
	  $error("Incorrect subkey value for test case %d", test_case_num);
       end
	test_case_num += 1;
if(subkey1 == tb_subkey1) begin
	  $info("Correct subkey Value for test case %d", test_case_num);
       end else begin
	  $error("Incorrect subkey value for test case %d", test_case_num);
       end
	test_case_num += 1;
if(subkey2 == tb_subkey2) begin
	  $info("Correct subkey Value for test case %d", test_case_num);
       end else begin
	  $error("Incorrect subkey value for test case %d", test_case_num);
       end
	test_case_num += 1;
if(subkey3 == tb_subkey3) begin
	  $info("Correct subkey Value for test case %d", test_case_num);
       end else begin
	  $error("Incorrect subkey value for test case %d", test_case_num);
       end
	test_case_num += 1;
if(subkey4 == tb_subkey4) begin
	  $info("Correct subkey Value for test case %d", test_case_num);
       end else begin
	  $error("Incorrect subkey value for test case %d", test_case_num);
       end
	test_case_num += 1;
if(subkey5 == tb_subkey5) begin
	  $info("Correct subkey Value for test case %d", test_case_num);
       end else begin
	  $error("Incorrect subkey value for test case %d", test_case_num);
       end
	test_case_num += 1;
if(subkey6 == tb_subkey6) begin
	  $info("Correct subkey Value for test case %d", test_case_num);
       end else begin
	  $error("Incorrect subkey value for test case %d", test_case_num);
       end
	test_case_num += 1;
if(subkey7 == tb_subkey7) begin
	  $info("Correct subkey Value for test case %d", test_case_num);
       end else begin
	  $error("Incorrect subkey value for test case %d", test_case_num);
       end
	test_case_num += 1;
if(subkey8 == tb_subkey8) begin
	  $info("Correct subkey Value for test case %d", test_case_num);
       end else begin
	  $error("Incorrect subkey value for test case %d", test_case_num);
       end
	test_case_num += 1;
if(subkey9 == tb_subkey9) begin
	  $info("Correct subkey Value for test case %d", test_case_num);
       end else begin
	  $error("Incorrect subkey value for test case %d", test_case_num);
       end
	
     end

  task period(input integer cycle);
     repeat (cycle) begin
	@(posedge tb_HCLK);
     end
   endtask // period

endmodule

