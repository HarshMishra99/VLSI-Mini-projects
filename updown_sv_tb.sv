`timescale 1ns/1ps
module updown_sv_tb;
logic clk, rst, up_down;
logic [3:0] count;
updown_sv uut (.clk(clk),.rst(rst),.up_down(up_down),.count(count));
initial clk = 0;
always #5 clk = ~clk;
task tick(input int n, input string mode);
int i;
for (i=0; i<n; i++) begin
@(posedge clk); #1;
$display("[%s] count = %0d", mode, count);
end
endtask
initial begin
$dumpfile("dump.vcd"); $dumpvars(0, updown_sv_tb);
// Reset
rst=1; up_down=1;
@(posedge clk); #1; rst=0;
// Count UP: 0 -> 10
$display("\n=== Counting UP (0 to 10) ===");
up_down = 1;
tick(10, "UP");
// Switch DOWN: 10 -> 0 (watch 4 appear twice)
$display("\n=== Counting DOWN (10 to 0, 4 appears twice) ===");
up_down = 0;
tick(14, "DOWN");
$finish;
end
endmodule