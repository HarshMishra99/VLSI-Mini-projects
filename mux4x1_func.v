// 4x1 MUX module
module mux4x1 (
input wire [1:0] sel,
input wire [3:0] d,
output wire y
);
assign y = d[sel];
endmodule
// Top-level: f(a,b,c) = b' + ac realized via 4x1 MUX
// Select: S1=a, S0=b
// I0=1, I1=0, I2=1, I3=c
module func_mux (
input wire a, b, c,
output wire f
);
wire [3:0] data;
assign data = {c, 1'b1, 1'b0, 1'b1}; // I3=c, I2=1, I1=0, I0=1
mux4x1 m0 (.sel({a,b}), .d(data), .y(f));
endmodule
