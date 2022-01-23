//Add comments to describe what this code does


module rca4(carryin, X, Y, S, carryout);
  input 	carryin;
  input 	[3:0] X, Y;
  output	[3:0] S;
  output 	carryout;
	
  wire		[3:1] C;


fulladder stage0 (S[0], C[1], X[0], Y[0], carryin);
fulladder stage1(S[1], C[2], X[1], Y[1], C[1]);
fulladder stage2 (S[2], C[3], X[2], Y[2], C[2]);
fulladder stage3 (S[3], carryout, X[3], Y[3], C[3]);

endmodule





  

