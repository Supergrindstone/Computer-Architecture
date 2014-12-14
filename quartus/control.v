module control(in,regdest,alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop0,aluop1,Pcsource1,Pcsource2,JumpNotZero,Flageski,bgtz,Link,ori,jump,Link2);
input [5:0] in;
output regdest,alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop1,aluop0,Pcsource1,Pcsource2,JumpNotZero,Flageski,bgtz,Link,ori ,jump ,Link2;
wire rformat,lw,sw,beq,bmn,balmn,bn,bneal,jal,ori ;
assign rformat=~|in;
assign lw=in[5]& (~in[4])&(~in[3])&(~in[2])&in[1]&in[0];
assign sw=in[5]& (~in[4])&in[3]&(~in[2])&in[1]&in[0];
assign beq=~in[5]& (~in[4])&(~in[3])&in[2]&(~in[1])&(~in[0]);

		///////////////////// ******************************** new additional instruction  ***********************************/////////////////
assign bmn=(~in[5])&(in[4])&~in[3]&(in[2])&(~in[1])&in[0]; // bmn 21 010101   I-type
assign balmn=(~in[5])&(in[4])&~in[3]&(in[2])&(in[1])&in[0]; // balmn 23 010111
assign bn=(~in[5])&(in[4])&in[3]&(~in[2])&(~in[1])&in[0]; // bn 25 011001
assign bneal=(in[5])&(~in[4])&in[3]&(in[2])&(~in[1])&in[0]; // bneal 45 101101  I-type
assign bgtz=(~in[5])&(~in[4])&~in[3]&(in[2])&(in[1])&in[0]; // bgtz 7 000111
assign jal=(~in[5])&(~in[4])&~in[3]&(~in[2])&(in[1])&in[0]; // jal 3 000011
assign ori=(~in[5])&(~in[4])&in[3]&(in[2])&(~in[1])&in[0]; // ori 13 001101

		///////////////////// ******************************** control unit signals ***********************************/////////////////

assign regdest=rformat;// When I see rformat opcode , please let me pass   
assign alusrc=lw|sw|ori | bmn | balmn; //  When I  see these opcode send signals 
assign memtoreg=lw |balmn|bmn;// read from memeory When I  see these opcode send signals 
assign regwrite=rformat|lw|Link|ori|balmn |Link2;//  write on register file When I  see these opcode send signals 
assign memread=lw|bmn|balmn ; // hen I  see these opcode send signals read from the memory necessary data 
assign memwrite=sw; // hen I  see these opcode send signals , write something to the memory
assign branch=beq|balmn|bmn|bn|bneal|bgtz; // When I  see these opcode send signals to make the branch
assign aluop1=rformat|ori;// using opcode to make the necessary operation 
assign aluop0=beq|ori|bneal; // When I  see these opcode send signals to make subtraction when its true

		///////////////////// ******************************** additional control unit signals ***********************************/////////////////

assign jump=jal; // when I  see these opcode send jump signal
assign Pcsource1 = bmn|balmn|bneal|beq|bgtz;
assign Pcsource2 =bgtz|beq|bneal|bn|jal;
assign JumpNotZero=bmn|balmn|bneal|bn; // not oldugunda flag yanacak örnek bne
assign Flageski=balmn|bmn|bn; //lable olmadıgında kullanırım çünkü yeni bi registerim yok
assign Link=jal|bneal;
assign Link2=jal|bneal|balmn;


endmodule
