class apb_mon extends uvm_monitor;
`uvm_component_utils(apb_mon)
`NEW_COMP
uvm_analysis_port #(apb_tx) analysis_port;
virtual apb_intrf vif;
apb_tx tx;

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(virtual apb_intrf)::get(this,"","vif",vif))
		`uvm_fatal("NOVIF","intrfc is noset")
	analysis_port=new("analysis_port",this);
endfunction


task run_phase(uvm_phase phase);
	tx=apb_tx::type_id::create("tx");
forever begin
			@(vif.mon_cb);
			if(vif.mon_cb.valid==1 && vif.mon_cb.ready==1) begin
			tx.wr_rd=vif.mon_cb.wr_rd;
			tx.addr=vif.mon_cb.addr;
			if(vif.mon_cb.wr_rd==1) 
			tx.wdata=vif.mon_cb.wdata;
			else
			tx.rdata=vif.mon_cb.rdata;
			analysis_port.write(tx);
			end
end
endtask
endclass
