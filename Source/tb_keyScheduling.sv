`timescale 1ns/10ps

module tb_keyScheduling();
   // Local Parameters
   integer test_case_num;

   // DUT PortMap Signals
   reg [127:0] tb_keyword, tb_subkey;
   reg [3:0]   tb_roundNum;
   
   // Test Bench Reference Signals
   reg [127:0] tb_expected [0:9] = 
	       {128'hd6aa74fdd2af72fadaa678f1d6ab76fe,
		128'hb692cf0b643dbdf1be9bc5006830b3fe,
		128'hb6ff744ed2c2c9bf6c590cbf0469bf41,
		128'h47f7f7bc95353e03f96c32bcfd058dfd,
		128'h3caaa3e8a99f9deb50f3af57adf622aa,
		128'h5e390f7df7a69296a7553dc10aa31f6b,
		128'h14f9701ae35fe28c440adf4d4ea9c026,
		128'h47438735a41c65b9e016baf4aebf7ad2,
		128'h549932d1f08557681093ed9cbe2c974e,
		128'h13111d7fe3944a17f307a78b4d2b30c5};



   keyScheduling DUT 
     (
      .keyword(tb_keyword),
      .roundNum(tb_roundNum),
      .subkey(tb_subkey)
      );

   initial
     begin
	

	for (test_case_num = 1; test_case_num <= 10; test_case_num +=1) begin
     	   tb_roundNum = test_case_num;
	   tb_keyword = (tb_roundNum==1)? 128'h000102030405060708090a0b0c0d0e0f : tb_subkey;
	   #5
	     if(tb_expected[test_case_num-1] == tb_subkey) begin
		$info("Correct subkey Value for test case %d", test_case_num);
	     end else begin
		$error("Incorrect subkey value for test case %d", test_case_num);
	     end
	end // for (test_case_num == 1; test_case_num < ROUND; test_case_num +=1)

	
     end

endmodule 
