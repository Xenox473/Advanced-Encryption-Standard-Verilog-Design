`timescale 1ns / 10ps

module tb_byteSubstitution();
	

	reg [127:0] tb_input_data;
	reg [127:0] tb_output_data;
	integer tb_test_case;

	byteSubstitution DUT (.input_data(tb_input_data), .output_data(tb_output_data));

	initial
	begin
		tb_test_case = 0;
		tb_input_data = 128'h7A7A7A7A7A7A7A7A7A7A7A7A7A7A7A7A;
		#5
		if (tb_output_data == 128'hDADADADADADADADADADADADADADADADA)
		begin
			$info("Passed test case %d", tb_test_case);
		end else begin
			$error ("Failed test case %d", tb_test_case);
		end
		tb_test_case = 1;
		tb_input_data = 128'hAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAE;
		#5
		if (tb_output_data == 128'hE4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4)
		begin	
			$info("Passed test case %d", tb_test_case);
		end else begin
			$error ("Failed test case %d", tb_test_case);
		end
		tb_test_case = 2;
		tb_input_data = 128'h3F43B35E6D76ABDD09872E489A6CBB23;
		#5
		if (tb_output_data == 128'h751A6D583C3862C101173152B850EA26)
		begin	
			$info("Passed test case %d", tb_test_case);
		end else begin
			$error ("Failed test case %d", tb_test_case);
		end
		tb_test_case = 3;
		tb_input_data = 128'h88888888888888888888888888888888;
		#5
		if (tb_output_data == 128'hC4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4)
		begin	
			$info("Passed test case %d", tb_test_case);
		end else begin
			$error ("Failed test case %d", tb_test_case);
		end
		tb_test_case = 4;
		tb_input_data = 128'h606162636465666768696A6B6C6D6E6F;
		#5
		if (tb_output_data == 128'hD0EFAAFB434D338545F9027F503C9FA8)
		begin	
			$info("Passed test case %d", tb_test_case);
		end else begin
			$error ("Failed test case %d", tb_test_case);
		end
		tb_test_case = 5;
		tb_input_data = 128'h00112233445566778899AABBCCDDEEFF;
		#5
		if (tb_output_data == 128'h638293C31BFC33F5C4EEACEA4BC12816)
		begin	
			$info("Passed test case %d", tb_test_case);
		end else begin
			$error ("Failed test case %d", tb_test_case);
		end
	end
endmodule
