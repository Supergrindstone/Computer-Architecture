module processor;
reg [31:0] pc; //32-bit prograom counter
reg clk; //clock
reg [7:0] datmem[0:31],mem[0:31]; //32-size data and instruction memory (8 bit(1 byte) for each location)
reg [1:0] flag;
wire [31:0] 
dataa,	//Read data 1 output of Register File
datab,	//Read data 2 output of Register File
out2,	//Output of mux with ALUSrc control-mult2
out3,	//Output of mux with MemToReg control-mult3
out6,
out7,
out8,
sum,	//ALU result
extad,	//Output of sign-extend unit
zextad,
adder1out,	//Output of adder which adds PC and 4-add1
adder2out,	//Output of adder which adds PC+4 and 2 shifted sign-extend result-add2
sextad,	//Output of shift left 2 unit
pseudoInstruction ;
wire [1:0] aluflag;


wire [5:0] inst31_26;	//31-26 bits of instruction
wire [4:0] 
inst25_21,	//25-21 bits of instruction
inst20_16,	//20-16 bits of instruction
inst15_11,	//15-11 bits of instruction
out1,		//Write data input of Register File
out5;

wire [4:0] inst10_6;	//10-6 bits of instruction for shift amount

wire [15:0] inst15_0;	//15-0 bits of instruction

wire [31:0] instruc,	//current instruction
dpack;	//Read data output of memory (data read from memory)

wire [2:0] gout;	//Output of ALU control unit

wire
//Control signals
regdest,alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop1,aluop0,Pcsource1,Pcsource2,JumpNotZero,Flageski,Bgtz,Link,ori,jump,Link2;

//32-size register file (32 bit(1 word) for each register)
reg [31:0] registerfile[0:31];

integer i;

// datamemory connections

always @(posedge clk)
//write data to memory
if (memwrite)
begin 
//sum stores address,datab stores the value to be written
datmem[sum[4:0]+3]=datab[7:0];   // write each byte to the memory address as a byte.
datmem[sum[4:0]+2]=datab[15:8];   //write each byte to the memory address as a byte.
datmem[sum[4:0]+1]=datab[23:16];	 //write each byte to the memory address as a byte.
datmem[sum[4:0]]=datab[31:24];	 //write each byte to the memory address as a byte.
end

//instruction memory
//4-byte instruction
 assign instruc={mem[pc[4:0]],mem[pc[4:0]+1],mem[pc[4:0]+2],mem[pc[4:0]+3]}; // fetch instruction
 assign inst31_26=instruc[31:26];					
 assign inst25_21=instruc[25:21];
 assign inst20_16=instruc[20:16];
 assign inst15_11=instruc[15:11];
 assign inst15_0=instruc[15:0];
 assign inst10_6=instruc[10:6];
 assign pseudoInstruction={pc[31:28],instruc[25:0],2'b0};

 // registers

assign dataa=registerfile[inst25_21];//Read register 1 -->	read data 1
assign datab=registerfile[inst20_16];//Read register 2 -->	read data 2
always @(posedge clk)
if(regwrite)
begin
registerfile[out5] = out6;//Write data to register
end

//read data from memory, sum stores address
assign dpack={datmem[sum[4:0]],datmem[sum[4:0]+1],datmem[sum[4:0]+2],datmem[sum[4:0]+3]};

//multiplexers
//mux with RegDst control
mult2_to_1_5  mult1(out1, instruc[20:16],instruc[15:11],regdest);

//mux with ALUSrc control
mult2_to_1_32 mult2(out2,datab ,out7,alusrc);

//mux with MemToReg control
mult2_to_1_32 mult3(out3, sum,dpack,memtoreg);

//mux with has $ra31 & RegDst control
mult2_to_1_5 mult5(out5, out1,5'b11111,Link);
//mux with datalink control
 mult2_to_1_32 mult8(out6, out3,adder1out,Link2);
//mux with MemToReg control
 mult2_to_1_32 mult7(out7, extad,zextad,ori);
 
 mult4_to_1_32 mult6(out8, adder1out,pseudoInstruction,out3,adder2out,pcsourceout1,pcsourceout2);
  

// load pc
always @(posedge clk)
pc=out8;

// alu, adder and control logic connections

//ALU unit
alu32 alu1(sum,dataa,out2,inst10_6,aluflag,gout);

//adder which adds PC and 4
adder add1(pc,32'h4,adder1out);

//adder which adds PC+4 and 2 shifted sign-extend result
adder add2(adder1out,sextad,adder2out);

//Control unit
control cont(instruc[31:26],regdest,alusrc,memtoreg,regwrite,memread,memwrite,branch,
aluop1,aluop0,Pcsource1,Pcsource2,JumpNotZero,Flageski,Bgtz,Link,ori,jump,Link2);

//Sign extend unit
signext sext(instruc[15:0],extad);

// zero extend unit
zeroext zext(instruc[15:0],zextad);

jumpbranchunit jumpbranchunit1 (aluflag,flag, Flageski,JumpNotZero,Bgtz,jump,branch,Pcsource1,Pcsource2 ,pcsourceout1,pcsourceout2 );


//ALU control unit
alucont acont(aluop1,aluop0,instruc[3],instruc[2], instruc[1], instruc[0] ,gout);

//Shift-left 2 unit
shift shift2(sextad,extad);



//initialize datamemory,instruction memory and registers
//read initial data from files given in hex
always @(posedge clk)
begin
	for(i=0; i<32; i=i+1)
	$display("Instruction Memory[%0d]= %h  ",i,mem[i],"Data Memory[%0d]= %h   ",i,datmem[i],"Register[%0d]= %h",i,registerfile[i]);
end

initial
begin
$display("Starting simulation");
$readmemh("initdata.dat",datmem); //save byte by byte
$readmemh("init.dat",mem);//save byte by byte
$readmemh("initreg.dat",registerfile);//save word by word
end

initial
begin
pc=0;
flag = 0;
#400 $finish;
end

initial
begin
clk=0;
//40 time unit for each cycle
forever #20  clk=~clk;
end

initial 
begin
  $monitor($time,"PC %h",pc,"  SUM %h",sum,"   INST %h",instruc[31:0],
"   REGISTER %h %h %h %h ",registerfile[4],registerfile[5], registerfile[6],registerfile[1] );
end

endmodule

