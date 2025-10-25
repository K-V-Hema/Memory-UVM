parameter WIDTH=16;
parameter DEPTH=32;
parameter ADDR_WIDTH=$clog2(DEPTH);	
`define COUNT 32
`define NEW_OBJ\
function new(string name="");\
	super.new(name);\
	endfunction

`define NEW_COMP\
function new(string name="",uvm_component parent);\
	super.new(name,parent);\
endfunction
class apb_common;
static int matchings,mismatchings;
endclass
