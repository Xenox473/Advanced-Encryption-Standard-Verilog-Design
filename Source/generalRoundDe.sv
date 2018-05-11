`timescale 1ns / 1ps

module generalRoundDe
(
input wire encrypt,
input wire [127:0] keyword, input_data,
output wire [127:0] result
);

reg [127:0] o_key_add, outShift, outMix;

assign o_key_add = input_data ^ keyword;

mixColumn MIXCOL
(
.encrypt(encrypt),
.state_in(o_key_add),
.state_out(outMix)
);

shiftRow SHIFTR
(
.encrypt(encrypt),
.in_diffusion(outMix),
.shifted(outShift)
);

byteSubstitutionDe BYTESUB
(
.input_data(outShift),
.output_data(result)
);

endmodule
