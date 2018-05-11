module byteSubstitution
(
	input wire [127:0] input_data,
	output wire [127:0] output_data
);

	reg [127:0] temp_data;

	genvar index;

	generate

		for (index = 0; index <= 120; index = index + 8)
		begin
			sbox SBOX (.inputByte(input_data[index + 7: index]), .outputByte(temp_data[index + 7: index]));
		end

	endgenerate

	assign output_data = temp_data;

endmodule 
