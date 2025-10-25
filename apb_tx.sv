class apb_tx extends uvm_sequence_item;
	 rand bit[WIDTH-1:0]wdata;
  	 randc bit[ADDR_WIDTH-1:0]addr;
  	 rand bit wr_rd;
       	  bit[WIDTH-1:0]rdata;

`uvm_object_utils_begin(apb_tx)
    `uvm_field_int(wdata,UVM_ALL_ON)
    `uvm_field_int(wr_rd,UVM_ALL_ON)
    `uvm_field_int(addr,UVM_ALL_ON)
    `uvm_field_int(rdata,UVM_ALL_ON)
`uvm_object_utils_end
`NEW_OBJ
endclass

