module top;
reg clk,res;
apb_intrf pif(clk,res);
mem dut(.clk(pif.clk),
	   .res(pif.res),
	   .wr_rd(pif.wr_rd),
	   .addr(pif.addr),
	   .wdata(pif.wdata),
	  .rdata(pif.rdata),
	   .valid(pif.valid),
	   .ready(pif.ready));
always #5 clk=~clk;
initial begin
	clk=0;
	res=1;
	repeat(2) @(posedge clk);
	res=0;
end
initial begin
	uvm_config_db#(virtual apb_intrf)::set(null,"*","vif",pif);
	run_test("apb_wr_rd_tx");
end
initial begin
	#2000;
	$finish;
end
endmodule
