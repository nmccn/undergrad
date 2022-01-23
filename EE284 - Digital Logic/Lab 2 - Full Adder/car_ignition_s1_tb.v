/* testbench for Car Ignition Circuit */



module car_ignition_s1_tb;

wire t_s1;


reg t_B, t_D, t_P;




car_ignition_s1 dut(.B(t_B),.D(t_D),.P(t_P),.s1(t_s1));




//apply inputs and check results

initial

  begin


	$monitor(t_s1, t_B, t_D, t_P);


	
	t_B = 1'b0;	
	t_D = 1'b0;
	t_P = 1'b0;

	#20 

	if (t_s1 !== 1'b0) $display("000 failed."); //Tweak if necessary

	t_B = 1'b0;
	t_D = 1'b0;
	t_P = 1'b1;

	#20 

	if (t_s1 !== 1'b1) $display("001 failed."); //Tweak if necessary

	t_B = 1'b0;
	t_D = 1'b1;
	t_P = 1'b0;

	#20 

	if (t_s1 !== 1'b0) $display("010 failed."); //Tweak if necessary

	t_B = 1'b0;
	t_D = 1'b1;
	t_P = 1'b1;

	#20 

	if (t_s1 !== 1'b0) $display("011 failed."); //Tweak if necessary
	
	t_B = 1'b1;
	t_D = 1'b0;
	t_P = 1'b0;

	#20 

	if (t_s1 !== 1'b0) $display("100 failed."); //Tweak if necessary
	
	t_B = 1'b1;
	t_D = 1'b0;
	t_P = 1'b1;

	#20 

	if (t_s1 !== 1'b0) $display("101 failed."); //Tweak if necessary
	
	t_B = 1'b1;
	t_D = 1'b1;
	t_P = 1'b0;

	#20 

	if (t_s1 !== 1'b1) $display("110 failed."); //Tweak if necessary
	
	t_B = 1'b1;
	t_D = 1'b1;
	t_P = 1'b1;

	#20 

	if (t_s1 !== 1'b0) $display("111 failed."); //Tweak if necessary
	


	
  end	




endmodule