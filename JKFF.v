// JK Flip-Flop realized using a D Flip-Flop
// D = J.Q_bar + K_bar.Q (JKFF characteristic equation)
module jkff (
input wire clk,
input wire rst, // synchronous active-high reset
input wire j,
input wire k,
output reg q,
output wire q_bar
);
assign q_bar = ~q;
always @(posedge clk) begin
if (rst)
q <= 1'b0;
else
q <= (j & ~q) | (~k & q); // D = J.Q' + K'.Q
end
endmodule
