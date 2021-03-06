module ahb_receiver
  (
   input wire 	      HCLK,
   input wire 	      HRESETn,
   input wire [31:0]  HADDR,
   input wire [2:0]   HBURST,
   input wire [2:0]   HSIZE,
   input wire [31:0]  HWDATA,
   input wire [127:0] result,
   input wire 	      HWRITE,
   output reg [31:0]  HRDATA,
   output reg [127:0] inputData,
   output reg [127:0] keyWord,
   output reg 	      HREADYOUT,
   output reg 	      enable,
   output reg 	      encrypt
   );

   reg [127:0] 	      tempData, tempKeyWord, ntempData, ntempKeyWord;
   typedef enum       bit [1:0] {IDLE, WAIT} stateType;
   reg 		      tempHREADY;
   reg [31:0] 	      ptempHADDR, tempHADDR, tempHRDATA;
   stateType currentState, nextState;
   reg 		      tempEnable, tempEncrypt, tempDone;


   always_ff @(posedge HCLK, negedge HRESETn)
     begin
	if (HRESETn == 0) begin
	   currentState <= IDLE;
	   inputData <= 0;
	   keyWord <= 0;
	   HREADYOUT <= 1;
	   HRDATA <= 0;
	   ntempData <= 0;
	   ntempKeyWord <= 0;
	   HRDATA <= 0;
	   enable <= 0;
	   encrypt <= 0;
	   //tempHADDR <= 0;
	end
	else begin
	   currentState <= nextState;
	   if (tempDone)
	     inputData <= tempData;
	   if (tempDone)
	     keyWord <= tempKeyWord;
	   HRDATA <= tempHRDATA;
	   HREADYOUT <= tempHREADY;
	   ntempData <= tempData;
	   ntempKeyWord <= tempKeyWord;
	   encrypt <= tempEncrypt;
	   enable <= tempEnable;
	   //tempHADDR <= HADDR;
	end
     end
   
   always_comb
     begin	
	nextState = currentState;
	tempDone = 0;
	tempHREADY = 1;
	case(currentState)
	  IDLE: begin
	     if ((HADDR == 100) || (HADDR == 200)) begin
		nextState = WAIT;
		tempHREADY = 0;
	     end
	  end
	  WAIT: begin
	     if ((HADDR == 401) || (HADDR == 402) || (HADDR == 403)) begin
		nextState = IDLE;
		tempDone = 1;
	     end
	     tempHREADY = 0;
	  end
	endcase
     end

   always_comb begin
      tempEnable = enable;
      tempEncrypt = encrypt;
      tempKeyWord = ntempKeyWord; 
      tempData = ntempData;
      tempHRDATA = 0;
      if (HWRITE) begin
	 if (HADDR == 101)begin
	    tempData[127:96] = HWDATA;
	 end
	 else if (HADDR == 102) begin
	    tempData[95:64] = HWDATA;
	 end
	 else if (HADDR == 103) begin
	    tempData[63:32] = HWDATA;
	 end
	 else if (HADDR == 401) begin
	    tempData[31:0] = HWDATA;
	 end  
	 else if (HADDR == 201) begin
	    tempKeyWord[127:96] = HWDATA;
	 end
	 else if (HADDR == 202) begin
	    tempKeyWord[95:64] = HWDATA;
	 end
	 else if (HADDR == 203) begin
	    tempKeyWord[63:32] = HWDATA;
	 end
	 else if (HADDR == 402) begin
	    tempKeyWord[31:0] = HWDATA;
	 end
	 else if (HADDR == 302) begin
	    tempEnable = HWDATA;
	 end
	 else if (HADDR == 403) begin
	    tempEncrypt = HWDATA;
	 end
      end
      else begin
	 if (HADDR == 100)begin
	    tempHRDATA = result[127:96];
	 end
	 else if (HADDR == 101) begin
	    tempHRDATA = result[95:64];
	 end
	 else if (HADDR == 102) begin
	    tempHRDATA = result[63:32];
	 end
	 else if (HADDR == 103) begin
	    tempHRDATA = result[31:0];
	 end  
      end
   end	
endmodule	

