//Add comments to describe what this code does

module car_ignition_s2(B,D,P,s1);
  output s1;
  input 	B, D, P;
 
   
  assign s1 = (~((~B && ~D && P)||(B && D && ~P)));

 endmodule





  

