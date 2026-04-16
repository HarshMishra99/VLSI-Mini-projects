`timescale 1ns / 1ps
module jkff_tb;
reg clk, rst, j, k;
wire q, q_bar;
jkff uut (.clk(clk),.rst(rst),.j(j),.k(k),.q(q),.q_bar(q_bar));
initial clk = 0;
always #5 clk = ~clk;
initial begin
$dumpfile("dump.vcd"); $dumpvars(0, jkff_tb);
rst=1; j=0; k=0; @(posedge clk); #1; rst=0;
$display("J K | Q Q_bar | Operation");
$display("----+----------+-----------");
// HOLD
j=0; k=0; @(posedge clk); #1;
$display("%b %b | %b %b | Hold", j,k,q,q_bar);
// RESET
j=0; k=1; @(posedge clk); #1;
$display("%b %b | %b %b | Reset", j,k,q,q_bar);
// SET
j=1; k=0; @(posedge clk); #1;
$display("%b %b | %b %b | Set", j,k,q,q_bar);
// TOGGLE (Q was 1 -> 0)
j=1; k=1; @(posedge clk); #1;
$display("%b %b | %b %b | Toggle", j,k,q,q_bar);
// TOGGLE again (Q was 0 -> 1)
j=1; k=1; @(posedge clk); #1;
$display("%b %b | %b %b | Toggle", j,k,q,q_bar);
$finish;
end
endmodule