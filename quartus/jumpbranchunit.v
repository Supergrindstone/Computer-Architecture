module jumpbranchunit(flagyeni,flageski, flageskikullanma,JumpNotZero,Bgtz,jump,branch,pcsource1,pcsource2 ,pcsourceout1,pcsourceout2);
input [1:0] flagyeni;

input [1:0] flageski;

input flageskikullanma,JumpNotZero,Bgtz,jump,branch,pcsource1,pcsource2;
output pcsourceout1,pcsourceout2 ;

wire [1:0]flag ;
wire exor ,noor ,andout,orout,whichone;

assign flag = flageskikullanma ? flageski: flagyeni;

assign exor = JumpNotZero ^^ flag[0];
assign noor = ~(flag[0] | flag[1]);

assign whichone = Bgtz ? noor : exor;

assign andout= branch && whichone;

assign orout= andout | jump;


assign pcsourceout1=pcsource1 &&orout;
assign pcsourceout2=pcsource2&& orout;

endmodule


