/* testbench for Car Ignition Circuit */



module fulladder_tb;

wire t_S,t_C;


reg t_x, t_y, t_z;




fulladder dut(.x(t_x),.y(t_y),.z(t_z),.S(t_S),.C(t_C));




//apply inputs and check results

initial

  begin


	$monitor(t_x, t_y, t_z, t_S, t_C);


	
	t_x = 1'b0;	
	t_y = 1'b0;
	t_z = 1'b0;

	#20 

	if (t_S !== 1'b0) $display("000 failed."); //Tweak if necessary
	if (t_C !== 1'b0) $display("000 failed.");

	t_x = 1'b0;
	t_y = 1'b0;
	t_z = 1'b1;

	#20 

	if (t_S !== 1'b1) $display("001 failed."); //Tweak if necessary
	if (t_C !== 1'b0) $display("001 failed.");


	t_x = 1'b0;
	t_y = 1'b1;
	t_z = 1'b0;

	#20 

	if (t_S !== 1'b1) $display("010 failed."); //Tweak if necessary
	if (t_C !== 1'b0) $display("010 failed.");
	
	
	t_x = 1'b0;
	t_y = 1'b1;
	t_z = 1'b1;

	#20 

	if (t_S !== 1'b0) $display("011 failed."); //Tweak if necessary
	if (t_C !== 1'b1) $display("011 failed.");
	
	t_x = 1'b1;
	t_y = 1'b0;
	t_z = 1'b0;

	#20 

	if (t_S !== 1'b1) $display("100 failed."); //Tweak if necessary
	if (t_C !== 1'b0) $display("100 failed.");
	
	t_x = 1'b1;
	t_y = 1'b0;
	t_z = 1'b1;

	#20 

	if (t_S !== 1'b0) $display("101 failed."); //Tweak if necessary
	if (t_C !== 1'b1) $display("101 failed.");
	
	t_x = 1'b1;
	t_y = 1'b1;
	t_z = 1'b0;

	#20 

	if (t_S !== 1'b0) $display("110 failed."); //Tweak if necessary
	if (t_C !== 1'b1) $display("110 failed.");
	
	t_x = 1'b1;
	t_y = 1'b1;
	t_z = 1'b1;

	#20 

	if (t_S !== 1'b1) $display("111 failed."); //Tweak if necessary
	if (t_C !== 1'b1) $display("111 failed.");


	
  end	




endmodule