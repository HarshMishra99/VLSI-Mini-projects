`timescale 1ns / 1ps
module updown_counter_tb;
reg clk, rst, up_down;
wire [3:0] count;
updown_counter uut (
.clk(clk),.rst(rst),.up_down(up_down),.count(count));
initial clk = 0;
always #5 clk = ~clk;
task tick(input integer n);
integer i;
begin
for (i=0; i<n; i=i+1) begin
@(posedge clk); #1;
$display("[%s] count = %0d (%04b)",
up_down ? "UP " : "DOWN", count, count);
end
end
endtask
initial begin
$dumpfile("dump.vcd"); $dumpvars(0, updown_counter_tb);
// Reset
rst=1; up_down=1; @(posedge clk); #1; rst=0;
// Count up: 0 -> 15 (16 clocks, observe wrap)
$display("\n--- Counting UP ---");
up_down = 1;
tick(18);
// Switch to down: 15 -> 0 (16 clocks, observe wrap)
$display("\n--- Counting DOWN ---");
up_down = 0;
tick(18);
// Mid-count reset test
$display("\n--- Reset mid-count ---");
up_down = 1; tick(5);
rst = 1; @(posedge clk); #1; rst = 0;
$display("After reset: count = %0d (expect 0)", count);
tick(4);
$finish;
end
endmodule