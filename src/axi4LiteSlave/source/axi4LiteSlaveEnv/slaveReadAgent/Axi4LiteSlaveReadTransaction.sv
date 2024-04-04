`ifndef AXI4LITESLAVEREADTRANSACTION_INCLUDED_
`define AXI4LITESLAVEREADTRANSACTION_INCLUDED_

class Axi4LiteSlaveReadTransaction extends uvm_sequence_item;
  `uvm_object_utils(Axi4LiteSlaveReadTransaction)
  
  rand bit [DELAY_WIDTH-1:0] readDelayForArready;

  constraint uniqueValueForReadDelayForReady_c1 {unique {readDelayForArready};}

  extern function new(string name = "Axi4LiteSlaveReadTransaction");
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare (uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);

endclass : Axi4LiteSlaveReadTransaction

function Axi4LiteSlaveReadTransaction::new(string name = "Axi4LiteSlaveReadTransaction");
  super.new(name);
endfunction : new

function void Axi4LiteSlaveReadTransaction::do_copy (uvm_object rhs);
  Axi4LiteSlaveReadTransaction axi4LiteSlaveReadTxCopyObj;

  if(!$cast(axi4LiteSlaveReadTxCopyObj,rhs )) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
  end

  super.do_copy(rhs);
  readDelayForArready = axi4LiteSlaveReadTxCopyObj.readDelayForArready; 
endfunction : do_copy

function bit Axi4LiteSlaveReadTransaction::do_compare (uvm_object rhs, uvm_comparer comparer);
  Axi4LiteSlaveReadTransaction axi4LiteSlaveReadTxCompareObj;

  if(!$cast(axi4LiteSlaveReadTxCompareObj,rhs)) begin
    `uvm_fatal("FATAL_axi_SLAVE_TX_DO_COMPARE_FAILED","cast of the rhs object failed")
  return 0;
  end

  return super.do_compare(axi4LiteSlaveReadTxCompareObj, comparer) &&
  readDelayForArready == axi4LiteSlaveReadTxCompareObj.readDelayForArready;
endfunction : do_compare

function void Axi4LiteSlaveReadTransaction::do_print(uvm_printer printer);
  printer.print_field($sformatf("readDelayForArready"),this.readDelayForArready,$bits(readDelayForArready),UVM_HEX);
endfunction : do_print

`endif

