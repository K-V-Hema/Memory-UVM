class apb_seq extends uvm_sequence #(apb_tx);
apb_tx txQ[$],temp;
`uvm_object_utils(apb_seq)
`NEW_OBJ
//uvm_phase starting_phase;
//	task pre_body();
//		starting_phase=get_starting_phase();
//		if(starting_phase!=null) begin
//			starting_phase.raise_objection(this);
//		//	strating_phase.phase_done.set_drain_time(this,100);
//		end
//	endtask
//	task post_body();
//		starting_phase.drop_objection(this);
//	endtask
endclass

class apb_wr_rd_seq extends apb_seq;
	`uvm_object_utils(apb_wr_rd_seq)
	`NEW_OBJ
	task body();
		repeat(`COUNT) begin
		`uvm_do_with(req, {req.wr_rd==1;})
		temp=new req;
		txQ.push_back(temp);
		end
		repeat(`COUNT) begin
		temp=txQ.pop_front();
		`uvm_do_with(req, {req.wr_rd==0;req.addr==temp.addr;req.wdata==0;})
		end
	endtask          
endclass


