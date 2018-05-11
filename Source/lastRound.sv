`timescale 1ns / 1ps

module lastRound
(
input wire encrypt,
input wire [127:0] keyword, input_data,
output reg [127:0] result

);


reg [127:0] outByte, outShift;
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

always @ (outShift) begin
  res = outShift ^ keyword;
end

assign result = res;




endmodule
