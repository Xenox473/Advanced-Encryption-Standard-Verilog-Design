module AES
(
	input wire HCLK,
	input wire HRESETn,
	input wire [31:0] HADDR,
	input wire [2:0] HBURST,
	input wire [2:0] HSIZE,
	input wire [31:0] HWDATA,
	input wire HWRITE,
	output reg [31:0] HRDATA,
	output reg HREADYOUT
);

reg [127:0] tempResult;
reg [127:0] inputData, keyWord, result;
reg encrypt, enable;

always_ff @(posedge HCLK, negedge HRESETn) begin
	if (HRESETn == 0) 
		result <= 0;
	else
		result <= tempResult;
end

ahb_receiver AHB (.HCLK(HCLK), .HRESETn(HRESETn), .HADDR(HADDR), .HBURST(HBURST), .HSIZE(HSIZE), .HWDATA(HWDATA), .HWRITE(HWRITE), .HRDATA(HRDATA), .inputData(inputData), .keyWord(keyWord), .HREADYOUT(HREADYOUT), .result(result), .encrypt(encrypt), .enable(enable));

AESComb AESCombinedLogic (.HCLK(HCLK), .encrypt(encrypt), .keyEna(enable), .n_rst(HRESETn), .keyword(keyWord), .input_data(inputData), .AESresult(tempResult));

endmodule
