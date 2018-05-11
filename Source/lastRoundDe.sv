`timescale 1ns / 1ps

module lastRoundDe
(
input wire encrypt,
input wire [127:0] keyword, input_data,
output reg [127:0] result

);


reg [127:0] o_key_add, outShift;

assign o_key_add = input_data ^ keyword;

shiftRow SHIFTR
(
.encrypt(encrypt),
.in_diffusion(o_key_add),
.shifted(outShift)
);

byteSubstitutionDe BYTESUB
(
.input_data(outShift),
.output_data(result)
);





endmodule
