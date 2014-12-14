module mult4_to_1_32(out,i0,i1,i2,i3,s1,s0);
output [31:0] out;
input [31:0]i0,i1,i2,i3 ;
input s0 ,s1;
wire [31:0]w1,w2;
assign w1 = s0 ? i1:i0;
assign w2=s0 ? i3:i2;
assign out=s1 ? w2:w1;


endmodule
