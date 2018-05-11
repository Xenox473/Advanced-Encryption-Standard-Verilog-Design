`timescale 1ns / 100ps

module tb_AES();
   localparam CLK_PERIOD = 10;

   integer tb_testNum;	
   reg 	   tb_HCLK;
   reg 	   tb_HRESETn;
   reg [31:0] tb_HADDR;
   reg [31:0] tb_HRDATA;
   reg [31:0] tb_HWDATA;
   reg 	      tb_HWRITE;
   reg [2:0]  tb_HBURST;
   reg [2:0]  tb_HSIZE;
   reg 	      tb_HREADY;
   reg [127:0] tb_test;

   reg [127:0] tb_expected;
   reg [127:0] tb_data, tb_keyword;	
   
   always begin
      tb_HCLK = 1'b0;
      #(CLK_PERIOD/2);
      tb_HCLK = 1'b1;
      #(CLK_PERIOD/2);
   end
   
   AES DUT (.HCLK(tb_HCLK), .HRESETn(tb_HRESETn), .HADDR(tb_HADDR), .HBURST(tb_HBURST), .HSIZE(tb_HSIZE), .HWDATA(tb_HWDATA), .HWRITE(tb_HWRITE), .HRDATA(tb_HRDATA), .HREADYOUT(tb_HREADY));

   initial begin
      tb_testNum = 0;
      tb_HRESETn = 0;
      tb_HADDR = 0;
      tb_HBURST = 0;
      tb_HSIZE = 2;
      tb_HWDATA = 0;
      tb_HWRITE = 0;
      tb_test = 0;
      
      @(posedge tb_HCLK);
      tb_HRESETn = 0;
      @(posedge tb_HCLK);
      tb_HADDR = 50;
      @(posedge tb_HCLK);
      tb_HWDATA = 33;
      @(posedge tb_HCLK);
      tb_HRESETn = 1;
      @(posedge tb_HCLK);


      tb_keyword  = 128'h000102030405060708090a0b0c0d0e0f;
      tb_data     = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
      tb_expected = 127'h00112233445566778899aabbccddeeff;
      tb_testNum += 1;
      newCase(0);

      tb_keyword  = 128'h000102030405060708090a0b0c0d0e0f;
      tb_data     = 128'h00112233445566778899aabbccddeeff;
      tb_expected = 127'h69c4e0d86a7b0430d8cdb78070b4c55a;
      tb_testNum += 1;
      newCase(1);

      tb_keyword  = 128'h00112233445566778899AABBCCDDEEFF;
      tb_data     = 128'haeaeaeaeaeaeaeaeaeaeaeaeaeaeaeae;
      tb_expected = 128'h4adf494c4a532e3f53a701e95e4fbdf2;
      tb_testNum += 1;
      newCase(1);

      tb_keyword  = 128'h00112233445566778899AABBCCDDEEFF;
      tb_data     = 128'haeaeaeaeaeaeaeaeaeaeaeaeaeaeaeae;;
      tb_expected = 128'h3692a0c4262ca8352c646926d61d60f9;
      tb_testNum += 1;
      newCase(0);

      tb_keyword  = 128'hAABBCCDDEEFFAABBCCDDEEFFAABBCCDD;
      tb_data     = 128'h00110022003300440055006600770088;
      tb_expected = 128'hb1a1d2bf4e05de15f8176bfdf81836bf;
      tb_testNum += 1;
      newCase(1);

      tb_keyword  = 128'hAABBCCDDEEFFAABBCCDDEEFFAABBCCDD;
      tb_data      = 128'h00110022003300440055006600770088;
      tb_expected = 128'hb492794dbcb5aca13d796b4eddea21c1;
      tb_testNum += 1;
      newCase(0);

      tb_keyword  = 128'h11111111111111111111111111111111;
      tb_data     = 128'h00000000000000000000000000000000;
      tb_expected = 128'he0d541314e00102d6dfca8bc007b6c8a;
      tb_testNum += 1;
      newCase(1);
      
      tb_keyword  = 128'h11111111111111111111111111111111;
      tb_data     = 128'h00000000000000000000000000000000;
      tb_expected = 128'h5e749c2d64e5ef78279337670223fc08;
      tb_testNum += 1;
      newCase(0);
      
   end

   task period(input integer cycle);
      repeat (cycle) begin
	 @(posedge tb_HCLK);
      end
   endtask // period

   task newCase(input encryptSig);

      tb_HWRITE = 1;
      tb_HADDR = 302;//enable
      tb_HWDATA = 0;
      @(posedge tb_HCLK);
      //key
      tb_HWRITE = 1;
      tb_HADDR = 200;
      tb_HWDATA = 0;
      @(posedge tb_HCLK);
      tb_HADDR = 201;
      tb_HWDATA = tb_keyword[127:96];
      @(posedge tb_HCLK);
      tb_HADDR = 202;
      tb_HWDATA = tb_keyword[95:64];
      @(posedge tb_HCLK);
      tb_HADDR = 203;
      tb_HWDATA = tb_keyword[63:32];
      @(posedge tb_HCLK);
      tb_HADDR = 402;
      tb_HWDATA = tb_keyword[31:0];
      @(posedge tb_HCLK);

      tb_HADDR = 301;
      tb_HWRITE = 1;
      @(posedge tb_HCLK);
      tb_HADDR = 302;//enable
      tb_HWDATA = 1;
      @(posedge tb_HCLK);
      tb_HADDR = 403; //encrypt
      tb_HWDATA = encryptSig;
      @(posedge tb_HCLK);

      //data
      tb_HWRITE = 1;
      tb_HADDR = 100;
      @(posedge tb_HCLK);
      tb_HADDR = 101;
      tb_HWDATA = tb_data[127:96];
      @(posedge tb_HCLK);
      tb_HADDR = 102;
      tb_HWDATA = tb_data[95:64];
      @(posedge tb_HCLK);
      tb_HADDR = 103;
      tb_HWDATA = tb_data[63:32];
      @(posedge tb_HCLK);
      tb_HADDR = 401;
      tb_HWDATA = tb_data[31:0];
      period(20);

      //read result	        
      tb_HWRITE = 0;
      tb_HADDR = 100;
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
      period(2);
      tb_test[31:0] = tb_HRDATA;
      period(2);
      if(tb_test == tb_expected)
	$info("Test Case Passed %0d", tb_testNum);
      else
	$error("Failed test case %0d", tb_testNum);
   endtask

endmodule	
