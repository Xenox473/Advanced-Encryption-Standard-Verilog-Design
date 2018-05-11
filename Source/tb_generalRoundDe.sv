`timescale 1ns/10ps

module tb_generalRoundDe();
   localparam	CLK_PERIOD	= 2.5;
   localparam	CHECK_DELAY = 1;
   localparam   ROUND = 10;
reg tb_clk;
   
   
   integer test_case_num;
   
   //DUT portmap signals
   reg [127:0] tb_keyword, tb_input_data, tb_result, tb_expected;
	reg[3:0] tb_roundNum;
   reg tb_encrypt;
   
   
   always begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end


   //DUT port map
   generalRoundDe DUT(
		.encrypt(tb_encrypt),
	       .keyword(tb_keyword),
	       .input_data(tb_input_data),
	       .result(tb_result)
	       );


   initial
     begin
	tb_roundNum = 1;
	tb_encrypt = 0;
	tb_keyword =    128'hd6aa74fdd2af72fadaa678f1d6ab76fe;
	tb_input_data = 128'h89d810e8855ace682d1843d8cb128fe4;
	tb_expected = 128'h00102030405060708090a0b0c0d0e0f0;
	#10
if (tb_result == tb_expected) begin
$info ("pass %d", tb_roundNum);
end else begin
$error ("error %d", tb_roundNum);
end

/*
tb_roundNum = 1;
	tb_encrypt = 0;
	tb_keyword =    128'hd6aa74fdd2af72fadaa678f1d6ab76fe;
	tb_input_data = 128'h00102030405060708090a0b0c0d0e0f0;
	tb_expected = 128'h89d810e8855ace682d1843d8cb128fe4;
	#10
if (tb_result == tb_expected) begin
$info ("pass %d", tb_roundNum);
end else begin
$error ("error %d", tb_roundNum);
end
	tb_roundNum = 2;
	tb_keyword =    128'hb692cf0b643dbdf1be9bc5006830b3fe;
	tb_input_data = 128'h89d810e8855ace682d1843d8cb128fe4;
tb_expected = 128'h4915598f55e5d7a0daca94fa1f0a63f7;
	#10
if (tb_result == tb_expected) begin
$info ("pass %d", tb_roundNum);
end else begin
$error ("error %d", tb_roundNum);
end
	tb_roundNum = 3;
	tb_keyword =    128'hb6ff744ed2c2c9bf6c590cbf0469bf41;
	tb_input_data = 128'h4915598f55e5d7a0daca94fa1f0a63f7;
	#10
tb_expected =128'hfa636a2825b339c940668a3157244d17;
if (tb_result == tb_expected) begin
$info ("pass %d", tb_roundNum);
end else begin
$error ("error %d", tb_roundNum);
end
	tb_roundNum = 4;
	tb_keyword =    128'h47f7f7bc95353e03f96c32bcfd058dfd;
	tb_input_data = 128'hfa636a2825b339c940668a3157244d17;
	#10

tb_expected =128'h247240236966b3fa6ed2753288425b6c;
if (tb_result == tb_expected) begin
$info ("pass %d", tb_roundNum);
end else begin
$error ("error %d", tb_roundNum);
end
	tb_roundNum = 5;
	tb_keyword =    128'h3caaa3e8a99f9deb50f3af57adf622aa;
	tb_input_data = 128'h247240236966b3fa6ed2753288425b6c;
	#10
tb_expected =128'hc81677bc9b7ac93b25027992b0261996;
if (tb_result == tb_expected) begin
$info ("pass %d", tb_roundNum);
end else begin
$error ("error %d", tb_roundNum);
end
	tb_roundNum = 6;
	tb_keyword =    128'h5e390f7df7a69296a7553dc10aa31f6b;
	tb_input_data = 128'hc81677bc9b7ac93b25027992b0261996;
	#10
tb_expected =128'hc62fe109f75eedc3cc79395d84f9cf5d;
if (tb_result == tb_expected) begin
$info ("pass %d", tb_roundNum);
end else begin
$error ("error %d", tb_roundNum);
end
	tb_roundNum = 7;
	tb_keyword =    128'h14f9701ae35fe28c440adf4d4ea9c026;
	tb_input_data = 128'hc62fe109f75eedc3cc79395d84f9cf5d;
	#10
tb_expected =128'hd1876c0f79c4300ab45594add66ff41f;
if (tb_result == tb_expected) begin
$info ("pass %d", tb_roundNum);
end else begin
$error ("error %d", tb_roundNum);
end
	tb_roundNum = 8;
	tb_keyword =    128'h47438735a41c65b9e016baf4aebf7ad2;
	tb_input_data = 128'hd1876c0f79c4300ab45594add66ff41f;
	#10
tb_expected =128'hfde3bad205e5d0d73547964ef1fe37f1;
if (tb_result == tb_expected) begin
$info ("pass %d", tb_roundNum);
end else begin
$error ("error %d", tb_roundNum);
end
	tb_roundNum = 9;
	tb_keyword =    128'h549932d1f08557681093ed9cbe2c974e;
	tb_input_data = 128'hfde3bad205e5d0d73547964ef1fe37f1;
	#10
tb_expected =128'hbd6e7c3df2b5779e0b61216e8b10b689;
if (tb_result == tb_expected) begin
$info ("pass %d", tb_roundNum);
end else begin
$error ("error %d", tb_roundNum);
end
*/
	
     end
endmodule

