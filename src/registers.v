/* registers.v
 *
 * Copyright (c) 2022 Brown Deer Technology, LLC. (www.browndeertechnology.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *    https://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* DAR */

module registers(
	input clk,
	input run,
	input we,
	input [RBITS-1:0] rd,
	input [RBITS-1:0] rs1,
	input [RBITS-1:0] rs2,
	input [BITS-1:0] rd_din,
	output reg [BITS-1:0] rs1_dout,
	output reg [BITS-1:0] rs2_dout

//	input [RBITS-1:0] debug_reg_sel,
//	output reg [BITS-1:0] debug_reg_dout
);

	parameter BITS = 8;
	parameter RBITS = 3;
	parameter NREG = 8;

	reg [BITS-1:0] r[1:NREG-1];	

	always @ (posedge clk)
	begin

		if (run & we & (rd==3'b001)) 
    	  r[1] <= rd_din;
		else 
			r[1] <= r[1];

		if (run & we & (rd==3'b010)) 
    	  r[2] <= rd_din;
		else 
			r[2] <= r[2];

		if (run & we & (rd==3'b011)) 
    	  r[3] <= rd_din;
		else 
			r[3] <= r[3];

//		if (run & we & (rd==3'b100)) 
//    	  r[4] <= rd_din;
//		else 
//			r[4] <= r[4];
//
//		if (run & we & (rd==3'b101)) 
//    	  r[5] <= rd_din;
//		else 
//			r[5] <= r[5];
//
//		if (run & we & (rd==3'b110)) 
//    	  r[6] <= rd_din;
//		else 
//			r[6] <= r[6];
//
//		if (run & we & (rd==3'b111)) 
//    	  r[7] <= rd_din;
//		else 
//			r[7] <= r[7];

	end


	/// read register

	always @ (*)
	begin

		case (rs2[1:0])
			2'b00: rs2_dout = 'd0;
			2'b01: rs2_dout = r[1];
			2'b10: rs2_dout = r[2];
			2'b11: rs2_dout = r[3];
		endcase


		case (rs1)
			3'b000: rs1_dout = 'd0;
			3'b001: rs1_dout = r[1];
			3'b010: rs1_dout = r[2];
			3'b011: rs1_dout = r[3];
			3'b100: rs1_dout = r[4];
			3'b101: rs1_dout = r[5];
			3'b110: rs1_dout = r[6];
			3'b111: rs1_dout = r[7];
		endcase

/*
		case (rs1[1:0])
			2'b00: rs1_dout = 'd0;
			2'b01: rs1_dout = r[1];
			2'b10: rs1_dout = r[2];
			2'b11: rs1_dout = r[3];
		endcase
*/

	end

//	always @ (*)
//	begin
//		debug_reg_dout = r[debug_reg_sel];
//	end

endmodule
