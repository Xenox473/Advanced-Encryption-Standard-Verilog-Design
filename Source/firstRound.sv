`timescale 1ns / 1ps

module firstRound //of encryption, lastround of decryption
(
input wire encrypt,
input wire [127:0] keyword, input_data,
output wire [127:0] result
);


assign result = input_data ^ keyword;


endmodule
