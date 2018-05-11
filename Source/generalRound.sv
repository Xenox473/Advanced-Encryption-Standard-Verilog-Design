`timescale 1ns / 1ps

module generalRound
(
input wire encrypt,
input wire [127:0] keyword, input_data,
output wire [127:0] result
);


reg [127:0] outByte, outShift, outMix;
reg [127:0] res;

byteSubstitution BYTESUB
(
.input_data(input_data),
.output_data(outByte)
);

shiftRow SHIFTR
(
.encrypt(encrypt),
.in_diffusion(outByte),
.shifted(outShift)
);

mixColumn MIXCOL
(
.encrypt(encrypt),
.state_in(outShift),
.state_out(outMix)
);


always @ (outMix) begin
  res = outMix ^ keyword;
end

assign result = res;

endmodule
