`timescale 1ns / 100ps

module tb_ahb_receiver();
	localparam CLK_PERIOD = 10;

	integer tb_testNum;	
	reg tb_HCLK;
	reg tb_HRESETn;
	reg [31:0] tb_HADDR;
	reg [31:0] tb_HRDATA;
	reg [31:0] tb_HWDATA;
	reg tb_HWRITE, tb_encrypt, tb_enable;
	reg [2:0] tb_HBURST;
	reg [2:0] tb_HSIZE;
	reg [127:0] tb_result;
	reg tb_HREADY;
	reg [127:0] tb_test;

	reg [127:0] tb_inputData, tb_KeyWord, tb_expected;
	
	always begin
		tb_HCLK = 1'b0;
		#(CLK_PERIOD/2);
		tb_HCLK = 1'b1;
		#(CLK_PERIOD/2);
	end
	
	ahb_receiver DUT (.HCLK(tb_HCLK), .HRESETn(tb_HRESETn), .HADDR(tb_HADDR), .HBURST(tb_HBURST), .HSIZE(tb_HSIZE), .HWDATA(tb_HWDATA), .HWRITE(tb_HWRITE), .HRDATA(tb_HRDATA), .inputData(tb_inputData), .keyWord(tb_KeyWord), .HREADYOUT(tb_HREADY), .result(tb_result), .encrypt(tb_encrypt), .enable(tb_enable));

	initial begin
		tb_testNum = 0;
		tb_HRESETn = 0;
		tb_HADDR = 0;
		tb_HBURST = 0;
		tb_HSIZE = 2;
		tb_HWDATA = 0;
		tb_HWRITE = 0;
		tb_result = 0;
		tb_test = 0;
		tb_expected = 0;
		//tb_HRDATA = 0;
		
		@(posedge tb_HCLK);
		tb_testNum = tb_testNum + 1;
		tb_HRESETn = 0;
		@(posedge tb_HCLK);
		tb_HADDR = 50;
		@(posedge tb_HCLK);
		tb_HWDATA = 33;
		#1ns
		@(posedge tb_HCLK);
		tb_HRESETn = 1;
	
		tb_testNum = tb_testNum + 1;
		@(posedge tb_HCLK);
		tb_HWRITE = 1;
		tb_HADDR = 100;
		tb_HWDATA = 0;
		@(posedge tb_HCLK);
		tb_HADDR = 101;
		tb_HWDATA = 32'h12121212;
		@(posedge tb_HCLK);
		tb_HADDR = 102;
		tb_HWDATA = 32'h34343434;
		@(posedge tb_HCLK);
		tb_HADDR = 103;
		tb_HWDATA = 32'h56565656;
		@(posedge tb_HCLK);
		tb_HADDR = 401;
		tb_HWDATA = 32'h12345676;
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		tb_expected = 127'h12121212343434345656565612345676;
		if(tb_inputData == tb_expected)
			$info("Test Case Passed %0d", tb_testNum);
		else
			$error("Failed test case %0d", tb_testNum);

		tb_testNum = tb_testNum + 1;
		@(posedge tb_HCLK);
		tb_HWRITE = 1;
		tb_HADDR = 100;
		tb_HWDATA = 0;
		@(posedge tb_HCLK);
		tb_HADDR = 101;
		tb_HWDATA = 32'h12121212;
		@(posedge tb_HCLK);
		tb_HWDATA = 32'h34343434;
		tb_HADDR = 102;
		@(posedge tb_HCLK);
		tb_HADDR = 103;
		tb_HWDATA = 32'h56565656;
		@(posedge tb_HCLK);
		tb_HADDR = 401;
		tb_HWDATA = 32'h12345676;
		@(posedge tb_HCLK);
		tb_HADDR = 100;
		@(posedge tb_HCLK);
		tb_HADDR = 101;
		tb_HWDATA = 32'h11111111;
		@(posedge tb_HCLK);
		tb_HADDR = 102;
		tb_HWDATA = 32'h44444444;
		@(posedge tb_HCLK);
		tb_HADDR = 103;
		tb_HWDATA = 32'h99999999;
		@(posedge tb_HCLK);
		tb_HADDR = 401;
		tb_HWDATA = 32'h12345676;
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		tb_expected = 128'h11111111444444449999999912345676;
		if(tb_inputData == tb_expected)
			$info("Test Case Passed %0d", tb_testNum);
		else
			$error("Failed test case %0d", tb_testNum);
		
		tb_testNum = tb_testNum + 1;
		@(posedge tb_HCLK);
		tb_HWRITE = 1;
		tb_HADDR = 100;
		tb_HWDATA = 0;
		@(posedge tb_HCLK);
		tb_HADDR = 101;
		tb_HWDATA = 32'h22222222;
		@(posedge tb_HCLK);
		tb_HWDATA = 32'h33333333;
		tb_HADDR = 102;
		@(posedge tb_HCLK);
		tb_HADDR = 103;
		tb_HWDATA = 32'h55555555;
		@(posedge tb_HCLK);
		tb_HADDR = 401;
		tb_HWDATA = 32'h44444444;
		@(posedge tb_HCLK);
		tb_HADDR = 200;
		@(posedge tb_HCLK);
		tb_HADDR = 201;
		tb_HWDATA = 32'h11111111;
		@(posedge tb_HCLK);
		tb_HADDR = 202;
		tb_HWDATA = 32'h44444444;
		@(posedge tb_HCLK);
		tb_HADDR = 203;
		tb_HWDATA = 32'h99999999;
		@(posedge tb_HCLK);
		tb_HADDR = 402;
		tb_HWDATA = 32'h12345676;
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		tb_expected = 0;
		if((tb_inputData == 128'h22222222333333335555555544444444) && (tb_KeyWord == 128'h11111111444444449999999912345676))
			$info("Test Case Passed %0d", tb_testNum);
		else
			$error("Failed test case %0d", tb_testNum);
	
		tb_testNum = tb_testNum + 1;
		@(posedge tb_HCLK);
		tb_HWRITE = 0;
		tb_HADDR = 100;
		tb_result = 128'h22222222333333335555555544444444;
		@(posedge tb_HCLK);
		tb_HADDR = 101;
		@(negedge tb_HCLK);
		tb_test[127:96] = tb_HRDATA;
		@(posedge tb_HCLK);
		tb_HADDR = 102;
		@(negedge tb_HCLK);
		tb_test[95:64] = tb_HRDATA;
		@(posedge tb_HCLK);
		tb_HADDR = 103;
		@(negedge tb_HCLK);
		tb_test[63:32] = tb_HRDATA;
		@(posedge tb_HCLK);
		@(negedge tb_HCLK);
		tb_test[31:0] = tb_HRDATA;
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		if(tb_test == tb_result)
			$info("Test Case Passed %0d", tb_testNum);
		else
			$error("Failed test case %0d", tb_testNum);

		tb_testNum = tb_testNum + 1;
		@(posedge tb_HCLK);
		tb_HWRITE = 1;
		tb_HADDR = 301;
		@(posedge tb_HCLK);
		tb_HADDR = 302;
		tb_HWDATA = 1;
		@(posedge tb_HCLK);
		tb_HWDATA = 1;
		@(posedge tb_HCLK);
		tb_HADDR = 403;
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		if((tb_enable == 1)&&(tb_encrypt == 1))
			$info("Test Case Passed %0d", tb_testNum);
		else
			$error("Failed test case %0d", tb_testNum);

		tb_HADDR = 0;

	end
endmodule	
