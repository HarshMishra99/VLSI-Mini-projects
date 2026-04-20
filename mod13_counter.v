// 4-bit synchronous Mod-13 counter (counts 0 to 12, then resets)
module mod13_counter (
input wire clk,
input wire rst, // synchronous active-high reset
output reg [3:0] count,
output wire tc // terminal count: HIGH at count==12
);
assign tc = (count == 4'd12);
always @(posedge clk) begin
if (rst || count == 4'd12)
count <= 4'd0;
else
count <= count + 4'd1;
end
endmodule
