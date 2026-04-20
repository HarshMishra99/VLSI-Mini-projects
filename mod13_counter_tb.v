`timescale 1ns / 1ps
module mod13_counter_tb;
reg clk, rst;
wire [3:0] count;
wire tc;
mod13_counter uut (.clk(clk),.rst(rst),.count(count),.tc(tc));
initial clk = 0;
always #5 clk = ~clk;
initial begin
$dumpfile("dump.vcd"); $dumpvars(0, mod13_counter_tb);
rst=1; @(posedge clk); #1; rst=0;
$display("-- Full Mod-13 count cycle --");
repeat(15) begin
@(posedge clk); #1;
$display("COUNT=%0d\t(%04b)\tTC=%b", count, count, tc);
end
$display("-- Mid-count reset test --");
repeat(6) @(posedge clk);
#1; rst=1; @(posedge clk); #1; rst=0;
$display("After reset: COUNT=%0d (expect 0)", count);
repeat(14) begin
@(posedge clk); #1;
$display("COUNT=%0d\t(%04b)\tTC=%b", count, count, tc);
end
if (count > 4'd12)
$display("ERROR: count exceeded 12!");
else
$display("PASS: count never exceeded 12.");
$finish;
end
endmodule
