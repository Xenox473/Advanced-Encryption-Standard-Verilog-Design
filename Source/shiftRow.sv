module shiftRow
(
input wire encrypt,
input wire [127:0] in_diffusion,
output reg [127:0] shifted
);

assign	shifted[127:96] = encrypt? {in_diffusion[127:120], in_diffusion[87:80], in_diffusion[47:40], in_diffusion[7:0]} :
	{in_diffusion[127:120], in_diffusion[23:16], in_diffusion[47:40], in_diffusion[71:64]};


assign	shifted[95:64] = encrypt? {in_diffusion[95:88], in_diffusion[55:48], in_diffusion[15:8], in_diffusion[103:96]} :
	{in_diffusion[95:88], in_diffusion[119:112], in_diffusion[15:8], in_diffusion[39:32]};

assign	shifted[63:32] = encrypt? {in_diffusion[63:56], in_diffusion[23:16], in_diffusion[111:104], in_diffusion[71:64]} :
	{in_diffusion[63:56], in_diffusion[87:80], in_diffusion[111:104], in_diffusion[7:0]};


	assign shifted[31:0] = encrypt? {in_diffusion[31:24], in_diffusion[119:112], in_diffusion[79:72], in_diffusion[39:32]} :
	{in_diffusion[31:24], in_diffusion[55:48], in_diffusion[79:72], in_diffusion[103:96]};



endmodule 
