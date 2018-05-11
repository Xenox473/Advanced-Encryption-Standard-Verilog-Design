`timescale 1ns/10ps

module tb_shiftRow();

   // Local Parameters
   integer test_case_num;

   // DUT PortMap Signals
   reg [127:0] tb_in_diffusion;
   reg [127:0] tb_shifted;
   reg tb_encrypt;
   
   // Test Bench Reference Signals
   reg [127:0] tb_expected_shifted;

   shiftRow DUT 
     (
      .encrypt(tb_encrypt),
      .in_diffusion(tb_in_diffusion),
      .shifted(tb_shifted)
      );

   initial
     begin
/*
	test_case_num = 1;
	tb_encrypt = 1;
	tb_in_diffusion = 128'h000102030405060708090A0B0C0D0E0F;
	#5 //wait half clock cycle
	//12 1 6 11 8 13 2 7 4 9 14 3 0 5 10 15
	tb_expected_shifted = 128'h0C01060B080D020704090E0300050A0F;
	if(tb_shifted == tb_expected_shifted)
	     $info("Pass: Test Case %0d",test_case_num);
	else
	     $error("Error: Test Case %0d", test_case_num);

	test_case_num += 1;
	tb_in_diffusion = 128'h112233445566778899001A1B1C1D1E1F;
	#5 //wait half clock cycle
	//12 1 6 11 8 13 2 7 4 9 14 3 0 5 10 15
	tb_expected_shifted = 128'h1C22771b991D338855001E4411661A1F;
	if(tb_shifted == tb_expected_shifted)
	     $info("Pass: Test Case %0d",test_case_num);
	else
	     $error("Error: Test Case %0d", test_case_num);

	test_case_num += 1;
	tb_in_diffusion = 128'h01f21379a3b267342921fa6c2ccc3aef;
	#5 //wait half clock cycle
	//12 1 6 11 8 13 2 7 4 9 14 3 0 5 10 15
	tb_expected_shifted = 128'h2cf2676c29cc1334a3213a7901b2faef;
	if(tb_shifted == tb_expected_shifted)
	     $info("Pass: Test Case %0d",test_case_num);
	else
	     $error("Error: Test Case %0d", test_case_num);
*/
	tb_encrypt = 0;//4
        test_case_num += 1;
	tb_in_diffusion = 128'h000102030405060708090A0B0C0D0E0F;
	#5 //wait half clock cycle
	//12 1 6 11 8 13 2 7 4 9 14 3 0 5 10 15
	tb_expected_shifted = 128'h000D0A0704010E0B0805020F0C090603;
	if(tb_shifted == tb_expected_shifted)
	     $info("Pass: Test Case %0d",test_case_num);
	else
	     $error("Error: Test Case %0d", test_case_num);
/*
	test_case_num += 1;
	tb_in_diffusion = 128'h1C22771b991D338855001E4411661A1F;
	#5 //wait half clock cycle
	//12 1 6 11 8 13 2 7 4 9 14 3 0 5 10 15
	tb_expected_shifted = 128'h112233445566778899001A1B1C1D1E1F;
	if(tb_shifted == tb_expected_shifted)
	     $info("Pass: Test Case %0d",test_case_num);
	else
	     $error("Error: Test Case %0d", test_case_num);

	test_case_num += 1;
	tb_in_diffusion = 128'h2cf2676c29cc1334a3213a7901b2faef;
	#5 //wait half clock cycle
	//12 1 6 11 8 13 2 7 4 9 14 3 0 5 10 15
	tb_expected_shifted = 128'h01f21379a3b267342921fa6c2ccc3aef;
	if(tb_shifted == tb_expected_shifted)
	     $info("Pass: Test Case %0d",test_case_num);
	else
	     $error("Error: Test Case %0d", test_case_num);
*/
	

     end

endmodule 
