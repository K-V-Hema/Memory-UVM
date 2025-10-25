class apb_drv extends uvm_driver#(apb_tx);
`uvm_component_utils(apb_drv)
`NEW_COMP
virtual apb_intrf vif;
apb_tx tx;
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(virtual apb_intrf)::get(this,"","vif",vif))
		`uvm_fatal("NOVIF","intrfc is noset")
		tx=apb_tx::type_id::create("tx");
endfunction
task run_phase(uvm_phase phase);
forever begin
	seq_item_port.get_next_item(req);
	drive_tx(req);
	req.print();
	seq_item_port.item_done;
end

endtask
task drive_tx(apb_tx tx);
		@(vif.drv_cb);
			vif.drv_cb.wr_rd<=tx.wr_rd;
			vif.drv_cb.addr<=tx.addr;
			if(tx.wr_rd==1) vif.drv_cb.wdata<=tx.wdata;
			else vif.drv_cb.wdata<=0;
			vif.drv_cb.valid<=1;
			wait(vif.drv_cb.ready==1);
			if(tx.wr_rd==0) begin
		//	@(posedge vif.clk);
		//	#20;
				tx.rdata=vif.drv_cb.rdata;
			end
			@(vif.drv_cb);
			vif.drv_cb.wr_rd<=0;
			vif.drv_cb.addr<=0;
			vif.drv_cb.wdata<=0;
			vif.drv_cb.valid<=0;
endtask
endclass
