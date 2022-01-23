//Add comments to describe what this code does

module fulladder(S, C, x, y, z);
  output	S,C;
  input 	x,y,z;


xor u1(S,x,y,z); 
and u2(n1,x,y); 
and u3(n2,y,z); 
and u4(n3,x,z); 
or u5(C,n1,n2,n3);

 

endmodule





  

