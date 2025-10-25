class apb_cov extends uvm_subscriber#(apb_tx);
`uvm_component_utils(apb_cov)
//`NEW_COMP
apb_tx tx;
covergroup apb_cg;
	coverpoint tx.wr_rd{
		bins WRITE={1'b1};
		bins READS={1'b0};
		}
	coverpoint tx.addr{
		option.auto_bin_max=4;
		}
endgroup

function void build_phase (uvm_phase phase);
	super.build_phase(phase);
endfunction

function new(string name,uvm_component parent);
	super.new(name,parent);
	apb_cg=new();
endfunction

virtual function void write(apb_tx t);
	$cast(tx,t);
	apb_cg.sample();
endfunction
endclass
