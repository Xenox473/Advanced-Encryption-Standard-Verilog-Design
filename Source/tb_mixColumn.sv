`timescale 1ns/10ps

module tb_mixColumn();
	reg [127:0] tb_mixcol;
	reg [127:0] tb_out_diffusion;
	reg [4:0] test_case_num;
	reg tb_encrypt;

	//DUT port map
	mixColumn DUT(.state_in(tb_mixcol),.state_out(tb_out_diffusion),.encrypt(tb_encrypt));//.clock(tb_clk),
	initial begin
		//TEST CASE 2:
		test_case_num = 2;
		tb_encrypt = 1;
		tb_mixcol = 128'h10012002300340045005600670078008;
		#10
		$info("input %d", tb_mixcol);
		$info("output%d", tb_out_diffusion);
		
		if (tb_out_diffusion == 128'h0170571521f2bf1bc9fc9f9961ed7407) begin
			$info("CORRECT VALUE FOR OUT_DIFFUSION FOR TEST CASE %d", test_case_num);
		end else begin
			$error("INCORRECT VALUE FOR OUT_DIFFUSION FOR TEST CASE %d", test_case_num);
		end


		//TEST CASE 3:
		test_case_num = 3;
		tb_encrypt = 1;
		tb_mixcol = 128'h25252525252525252525252525252525;
		#10
		$info("input %d", tb_mixcol);
		$info("output%d", tb_out_diffusion);
		
		if (tb_out_diffusion == 128'h25252525252525252525252525252525) begin
			$info("CORRECT VALUE FOR OUT_DIFFUSION FOR TEST CASE %d", test_case_num);
		end else begin
			$error("INCORRECT VALUE FOR OUT_DIFFUSION FOR TEST CASE %d", test_case_num);
		end

		//TEST CASE 5:
		test_case_num = 5;
		tb_encrypt = 0;
		tb_mixcol = 128'h10012002300340045005600670078008;
		#10
		$info("input %d", tb_mixcol);
		$info("output%d", tb_out_diffusion);
		
		if (tb_out_diffusion == 128'h42ff149a6f7bf1928a73dc1635682082) begin
			$info("CORRECT VALUE FOR OUT_DIFFUSION FOR TEST CASE %d", test_case_num);
		end else begin
			$error("INCORRECT VALUE FOR OUT_DIFFUSION FOR TEST CASE %d", test_case_num);
		end

		//TEST CASE 6:
		test_case_num = 6;
		tb_encrypt = 0;
		tb_mixcol = 128'h25252525252525252525252525252525;
		#10
		$info("input %d", tb_mixcol);
		$info("output%d", tb_out_diffusion);
		
		if (tb_out_diffusion == 128'h25252525252525252525252525252525) begin
			$info("CORRECT VALUE FOR OUT_DIFFUSION FOR TEST CASE %d", test_case_num);
		end else begin
			$error("INCORRECT VALUE FOR OUT_DIFFUSION FOR TEST CASE %d", test_case_num);
		end
		
	end
endmodule
	
