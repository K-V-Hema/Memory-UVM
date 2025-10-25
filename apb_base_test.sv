class apb_base_test extends uvm_test;
apb_env env;
`uvm_component_utils(apb_base_test)
`NEW_COMP
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	env=apb_env::type_id::create("env",this);
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology();
endfunction

function void report_phase(uvm_phase phase);
if(apb_common::matchings!=0 && apb_common::mismatchings==0) begin
	`uvm_info("TEST PASS",$psprintf("match=%0d ||mismatch=%0d",apb_common::matchings,apb_common::mismatchings),UVM_NONE)
	end
else 
	`uvm_info("TEST FAIL",$psprintf("match=%0d ||mismatch=%0d",apb_common::matchings,apb_common::mismatchings),UVM_NONE)
endfunction
endclass


class apb_wr_rd_tx extends apb_base_test;
	`uvm_component_utils(apb_wr_rd_tx)
`NEW_COMP
task run_phase(uvm_phase phase);
	apb_wr_rd_seq wr_rd;
	wr_rd=apb_wr_rd_seq::type_id::create("wr_rd");
	phase.raise_objection(this);
	wr_rd.start(env.agent.sqr);
	phase.phase_done.set_drain_time(this,100);
	phase.drop_objection(this);
endtask
endclass
