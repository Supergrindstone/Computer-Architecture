module alucont(aluop1,aluop0,f3,f2,f1,f0,gout);//Figure 4.12 
input aluop1,aluop0,f3,f2,f1,f0;
output [2:0] gout;
reg [2:0] gout;
always @(aluop1 or aluop0 or f3 or f2 or f1 or f0)
begin
if(~(aluop1|aluop0))  gout=3'b010;//   toplama 00 
if(aluop0&~(aluop1))gout=3'b110 ; //    çıkarma         01
if(aluop0 &aluop1)gout=3'b001;  // ori
if(~(aluop0) & aluop1 )    // function code 
begin
	if (~(f3|f2|f1|f0))gout=3'b010; 	//function code=0000,ALU control=010 (add)
	if (f1&f3)gout=3'b111;			//function code=1x1x,ALU control=111 (set on less than)
	if (f1&~(f3))gout=3'b110;		//function code=0x10,ALU control=110 (sub)
	if (f2&f0)gout=3'b001;			//function code=x1x1,ALU control=001 (or)
	if (f2&~(f0))gout=3'b000;		//function code=x1x0,ALU control=000 (and)
	if (f0&f1)gout=3'b011; //srl		//function code=xx11,ALU control=011 (srl)
end
end
endmodule