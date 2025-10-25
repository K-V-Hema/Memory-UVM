interface apb_intrf(input clk,res);
	bit wr_rd;
	bit [ADDR_WIDTH-1:0]addr;
	bit[WIDTH-1:0]wdata;
	bit[WIDTH-1:0]rdata;
	bit valid;
	bit ready;

	clocking drv_cb @(posedge clk);
	default input #0 output #1;
	input rdata,ready;
	output valid,wr_rd,wdata,addr;
	endclocking

	clocking mon_cb @(posedge clk);
	default input #5;
	input rdata;
	input ready;
	input valid;
	input wr_rd;
	input wdata;
	input addr;
	endclocking

endinterface
