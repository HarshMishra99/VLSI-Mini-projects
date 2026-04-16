// Up-Down counter: counts 4 TWICE while going down
// Uses SystemVerilog enum to track the special state at 4
`timescale 1ns/1ps
module updown_sv (
input logic clk,
input logic rst,
input logic up_down, // 1=up, 0=down
output logic [3:0] count
);
// Enum tracks the special "hold at 4" states
typedef enum logic [1:0] {
NORMAL = 2'b00, // regular counting
FOUR_FIRST = 2'b01, // first time we see 4 going down
FOUR_SECOND = 2'b10 // second time we see 4 going down
} state_t;
state_t state, next_state;
// Sequential: update count and state
always_ff @(posedge clk) begin
if (rst) begin
count <= 4'd0;
state <= NORMAL;
end else begin
state <= next_state;
if (up_down) begin
// Up mode: normal increment, reset special state
count <= count + 4'd1;
end else begin
// Down mode
case (state)
NORMAL: begin
if (count == 4'd4)
count <= 4'd4; // hold: first visit
else
count <= count - 4'd1;
end
FOUR_FIRST:
count <= 4'd4; // hold: second visit
FOUR_SECOND:
count <= count - 4'd1; // now decrement past 4
default:
count <= count - 4'd1;
endcase
end
end
end
// Combinational: next state logic
always_comb begin
next_state = state;
if (rst || up_down) begin
next_state = NORMAL;
end else begin
case (state)
NORMAL:
next_state = (count == 4'd4) ? FOUR_FIRST : NORMAL;
FOUR_FIRST:
next_state = FOUR_SECOND;
FOUR_SECOND:
next_state = NORMAL;
default:
next_state = NORMAL;
endcase
end
end
endmodule
