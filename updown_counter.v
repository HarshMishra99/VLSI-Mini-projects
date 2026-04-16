// 4-bit synchronous up-down counter
module updown_counter (
input wire clk,
input wire rst, // synchronous active-high reset
input wire up_down, // 1=up, 0=down
output reg [3:0] count
);
always @(posedge clk) begin
if (rst)
count <= 4'd0;
else if (up_down)
count <= count + 4'd1; // up: wraps 15->0
else
count <= count - 4'd1; // down: wraps 0->15
end
endmodule