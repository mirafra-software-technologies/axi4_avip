`ifndef AXI4LITEMASTERREADTRANSACTION_INCLUDED_
`define AXI4LITEMASTERREADTRANSACTION_INCLUDED_

class Axi4LiteMasterReadTransaction extends uvm_sequence_item;
  `uvm_object_utils(Axi4LiteMasterReadTransaction)

  Axi4LiteMasterReadAgentConfig axi4LiteMasterReadAgentConfig; 

  rand bit [DELAY_WIDTH-1:0] readDelayForRready;
 
  extern function new (string name = "Axi4LiteMasterReadTransaction");
  extern function void do_copy(uvm_object rhs);
  extern function void post_randomize();
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);
endclass : Axi4LiteMasterReadTransaction

function Axi4LiteMasterReadTransaction::new(string name = "Axi4LiteMasterReadTransaction");
  super.new(name);
endfunction : new

function void Axi4LiteMasterReadTransaction::post_randomize();

endfunction : post_randomize

function void Axi4LiteMasterReadTransaction::do_copy(uvm_object rhs);
  Axi4LiteMasterReadTransaction axi4LiteMasterReadTxCopyObj;

  if(!$cast(axi4LiteMasterReadTxCopyObj,rhs)) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
  end
  super.do_copy(rhs);
  readDelayForRready = axi4LiteMasterReadTxCopyObj.readDelayForRready; 

endfunction : do_copy

function bit Axi4LiteMasterReadTransaction::do_compare (uvm_object rhs, uvm_comparer comparer);
  Axi4LiteMasterReadTransaction axi4LiteMasterReadTxCompareObj;

  if(!$cast(axi4LiteMasterReadTxCompareObj,rhs)) begin
    `uvm_fatal("FATAL_axi_MASTER_TX_DO_COMPARE_FAILED","cast of the rhs object failed")
    return 0;
  end
  
  return super.do_compare(axi4LiteMasterReadTxCompareObj, comparer) &&
  readDelayForRready == axi4LiteMasterReadTxCompareObj.readDelayForRready;

endfunction : do_compare

function void Axi4LiteMasterReadTransaction::do_print(uvm_printer printer);
  printer.print_field($sformatf("readDelayForRready"),this.readDelayForRready,$bits(readDelayForRready),UVM_HEX);

endfunction : do_print

`endif

