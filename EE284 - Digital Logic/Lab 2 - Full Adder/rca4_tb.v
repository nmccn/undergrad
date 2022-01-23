/* testbench for 4-bit RCA */



module rca4_tb;

wire [3:0] t_S;
wire t_carryout;


reg [3:0] t_X, t_Y;
reg t_carryin;




rca4 dut( .X(t_X), .Y(t_Y), .S(t_S), .carryout(t_carryout), .carryin(t_carryin));




//apply inputs and check results

initial

  begin


	$monitor(t_X, t_Y, t_S, t_carryout, t_carryin);


	
	t_X = 4'b0010;
	t_Y = 4'b0011;
	t_carryin = 1'b0;

	#20 

	if (t_S !== 4'b0101 && t_carryout !== 0) $display("test vector 1 failed."); //Tweak if necessary

	t_X = 4'b1001;
	t_Y = 4'b1010;
	t_carryin = 1'b0;

	#20 

	if (t_S !== 4'b0011 && t_carryout !== 1) $display("test vector 2 failed."); //Tweak if necessary

	t_X = 4'b0111;
	t_Y = 4'b1100;
	t_carryin = 1'b0;

	#20 

	if (t_S !== 4'b0011 && t_carryout !== 1) $display("test vector 3 failed."); //Tweak if necessary

	t_X = 4'b1011;
	t_Y = 4'b0101;
	t_carryin = 1'b0;

	#20 

	if (t_S !== 4'b0000 && t_carryout !== 1) $display("test vector 4 failed."); //Tweak if necessary


	
  end	




endmodule