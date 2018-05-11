module mixColumn(
  input wire encrypt,
  input wire[127:0] state_in,
  output reg[127:0] state_out
);
  genvar i;
  reg[31:0] enc_row[3:0]; 
  reg[31:0] dec_row[3:0];
 
  always_comb
  begin
    if (encrypt == 1) begin
	state_out = {	enc_row[0][31:24], enc_row[1][31:24], enc_row[2][31:24], enc_row[3][31:24],
			enc_row[0][23:16], enc_row[1][23:16], enc_row[2][23:16], enc_row[3][23:16],
			enc_row[0][15:8], enc_row[1][15:8], enc_row[2][15:8], enc_row[3][15:8], 
			enc_row[0][7:0], enc_row[1][7:0], enc_row[2][7:0], enc_row[3][7:0]
		};

    end
    else begin
	state_out = {	dec_row[0][31:24], dec_row[1][31:24], dec_row[2][31:24], dec_row[3][31:24],
			dec_row[0][23:16], dec_row[1][23:16], dec_row[2][23:16], dec_row[3][23:16],
			dec_row[0][15:8], dec_row[1][15:8], dec_row[2][15:8], dec_row[3][15:8], 
			dec_row[0][7:0], dec_row[1][7:0], dec_row[2][7:0], dec_row[3][7:0]
		};
      
    end
  end
 
  function [7:0] xtime;
    input [7:0] x;
    begin
	xtime = (x & 8'h80) ? ((x << 1) ^ 8'h1B) : (x << 1);
    end
  endfunction

  generate for (i = 0; i < 4; i = i + 1) begin
    always @(state_in)
    begin
      reg[7:0] b0, b1, b2, b3, temp;
 	 reg[31:0] r[3:0];

      r[0] = {state_in[127:120], state_in[95:88], state_in[63:56], state_in[31:24]};
      r[1] = {state_in[119:112], state_in[87:80], state_in[55:48], state_in[23:16]};
      r[2] = {state_in[111:104], state_in[79:72], state_in[47:40], state_in[15:8]};
      r[3] = {state_in[103:96], state_in[71:64], state_in[39:32], state_in[7:0]};

      b0 = r[0][((i + 1) * 8) - 1:(i * 8)];
      b1 = r[1][((i + 1) * 8) - 1:(i * 8)];
      b2 = r[2][((i + 1) * 8) - 1:(i * 8)];
      b3 = r[3][((i + 1) * 8) - 1:(i * 8)];

      temp = b0 ^ b1 ^ b2 ^ b3;

      enc_row[0][((i + 1) * 8) - 1:(i * 8)] = b0 ^ temp ^ xtime(b0 ^ b1);
      enc_row[1][((i + 1) * 8) - 1:(i * 8)] = b1 ^ temp ^ xtime(b1 ^ b2);
      enc_row[2][((i + 1) * 8) - 1:(i * 8)] = b2 ^ temp ^ xtime(b2 ^ b3);
      enc_row[3][((i + 1) * 8) - 1:(i * 8)] = b3 ^ temp ^ xtime(b3 ^ b0);
    end
  end
  endgenerate

  generate for (i = 0; i < 4; i = i + 1) begin
    always @(state_in)
    begin
      reg[7:0] b0, b1, b2, b3, temp;
      	    reg[31:0] r[3:0];
      
      	r[0] = {state_in[127:120], state_in[95:88], state_in[63:56], state_in[31:24]};
      	r[1] = {state_in[119:112], state_in[87:80], state_in[55:48], state_in[23:16]};
      	r[2] = {state_in[111:104], state_in[79:72], state_in[47:40], state_in[15:8]};
      	r[3] = {state_in[103:96], state_in[71:64], state_in[39:32], state_in[7:0]};
      	
	b0 = r[0][((i + 1) * 8) - 1:(i * 8)];
      	b1 = r[1][((i + 1) * 8) - 1:(i * 8)];
      	b2 = r[2][((i + 1) * 8) - 1:(i * 8)];
      	b3 = r[3][((i + 1) * 8) - 1:(i * 8)];

      	dec_row[0][((i + 1) * 8) - 1:(i * 8)] = gf_times_num(b0,8'h0E) ^ gf_times_num(b1,8'h0B) ^ gf_times_num(b2,8'h0D) ^ gf_times_num(b3,8'h09);
      	dec_row[1][((i + 1) * 8) - 1:(i * 8)] = gf_times_num(b0,8'h09) ^ gf_times_num(b1,8'h0E) ^ gf_times_num(b2,8'h0B) ^ gf_times_num(b3,8'h0D);
      	dec_row[2][((i + 1) * 8) - 1:(i * 8)] = gf_times_num(b0,8'h0D) ^ gf_times_num(b1,8'h09) ^ gf_times_num(b2,8'h0E) ^ gf_times_num(b3,8'h0B);
      	dec_row[3][((i + 1) * 8) - 1:(i * 8)] = gf_times_num(b0,8'h0B) ^ gf_times_num(b1,8'h0D) ^ gf_times_num(b2,8'h09) ^ gf_times_num(b3,8'h0E);
      end
   end
   endgenerate

   function [7:0] gf_times_num;
    input [7:0] x;
    input [7:0] y;
	if (y == 8'h09) begin
		gf_times_num = xtime(xtime(xtime(x))) ^ x;
	end
	if (y == 8'h0B) begin
		gf_times_num = xtime(xtime(xtime(x)) ^ x) ^ x;
	end
	if (y == 8'h0D) begin
		gf_times_num = xtime(xtime(xtime(x) ^ x)) ^ x;
	end
	if (y ==8'h0E) begin
		gf_times_num = xtime(xtime(xtime(x) ^ x) ^ x);
	end
   endfunction


endmodule
