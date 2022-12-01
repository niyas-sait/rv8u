/* des.v
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

module des(
	input in_clk,
	input rst,

   input [5:0] des_sin,
   output reg [7:0] des_sout,

   input [31:0] des_din,
   output reg [23:0] des_dout,

	output reg des_clk_out
);

   reg [2:0] des_counter;

   always @ (posedge in_clk, posedge rst)
   begin
      if (rst) 
         des_counter <= 3'b111;
      else if (des_counter == 3'b111) 
         des_counter <= 3'b000;
      else 
         des_counter <= des_counter + 1;
   end

   always @ (posedge(in_clk), posedge(rst))
   begin
      if (rst == 1'b1)
         des_clk_out <= 0;
      else if (des_counter[1:0] == 2'b11)
         des_clk_out <= ~ des_clk_out;
      else
         des_clk_out <= des_clk_out;
   end

   always @ (posedge in_clk)
   begin
      case (des_counter)
         3'b000: des_dout[5:0] <= des_sin;
         3'b001: des_dout[11:6] <= des_sin;
         3'b010: des_dout[17:12] <= des_sin;
         3'b011: des_dout[23:18] <= des_sin;
         3'b100: begin end
         3'b101: begin end
         3'b110: begin end
         3'b111: begin end
      endcase
   end

   always @ (*)
   begin
      case (des_counter[1:0])
         2'b00: des_sout = des_din[7:0];
         2'b01: des_sout = des_din[15:8];
         2'b10: des_sout = des_din[23:16];
         2'b11: des_sout = des_din[31:24];
      endcase
   end

endmodule
