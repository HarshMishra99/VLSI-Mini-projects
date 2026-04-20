`timescale 1ns/1ps
module mux4x1_func_tb;
reg a, b, c;
wire f;
integer i;
func_mux uut (.a(a),.b(b),.c(c),.f(f));
initial begin
$dumpfile("dump.vcd"); $dumpvars(0, mux4x1_func_tb);
$display("a b c | f | expected");
$display("------+---+---------");
for (i = 0; i < 8; i = i+1) begin
{a,b,c} = i[2:0];
#10;
$display("%b %b %b | %b | %b", a, b, c, f, (~b | (a&c)));
end
$finish;
end
endmodule
Expected Console Outp