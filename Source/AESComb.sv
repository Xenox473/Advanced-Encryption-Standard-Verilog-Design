module AESComb
(
input wire HCLK, encrypt, n_rst, keyEna,
input wire [127:0] keyword, input_data,
output wire [127:0] AESresult
);


reg [127:0] subkey0, subkey1, subkey2, subkey3, subkey4, subkey5, subkey6, subkey7, subkey8, subkey9, resultDe, resultEn;
reg ena;


   allKeys ALLKEYS(.HCLK(HCLK), .n_rst(n_rst), .keyword(keyword), .keyEna(keyEna), .ena(ena),
.subkey0(subkey0), .subkey1(subkey1), .subkey2(subkey2), .subkey3(subkey3), .subkey4(subkey4), .subkey5(subkey5), .subkey6(subkey6), .subkey7(subkey7), .subkey8(subkey8), .subkey9(subkey9));

   encrypt ENCRYPT(
.ena(ena), .HCLK(HCLK), .n_rst(n_rst), .encrypt(encrypt), .keyword(keyword),.inData(input_data),
.subkey0(subkey0), .subkey1(subkey1), .subkey2(subkey2), .subkey3(subkey3), .subkey4(subkey4), .subkey5(subkey5), .subkey6(subkey6), .subkey7(subkey7), .subkey8(subkey8), .subkey9(subkey9), .result(resultEn));

   decrypt DECRYPT(
.ena(ena), .HCLK(HCLK), .n_rst(n_rst), .encrypt(encrypt), .keyword(keyword),.inData(input_data),
.subkey0(subkey0), .subkey1(subkey1), .subkey2(subkey2), .subkey3(subkey3), .subkey4(subkey4), .subkey5(subkey5), .subkey6(subkey6), .subkey7(subkey7), .subkey8(subkey8), .subkey9(subkey9), .result(resultDe));

   assign AESresult = encrypt? resultEn : resultDe;

endmodule
