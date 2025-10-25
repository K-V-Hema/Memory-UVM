class apb_sbd extends uvm_scoreboard;
	apb_tx tx,txQ[$];
	int ass[*];
	uvm_analysis_imp #(apb_tx,apb_sbd) analysis_imp;
	`uvm_component_utils(apb_sbd)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		analysis_imp=new("analysis_imp",this);
	endfunction

	task run_phase(uvm_phase phase);
		forever begin
			wait(txQ.size()>0)
			tx=txQ.pop_front();
		if(tx.wr_rd==1) begin
			ass[tx.addr]=tx.wdata;
		end
		else begin
			if(ass[tx.addr]==tx.rdata)begin
				apb_common::matchings++;
			end
			else
				apb_common::mismatchings++;
		end
		end
	endtask

	function void write(apb_tx t);
		$cast(tx,t);
		txQ.push_back(tx);
	endfunction
endclass
