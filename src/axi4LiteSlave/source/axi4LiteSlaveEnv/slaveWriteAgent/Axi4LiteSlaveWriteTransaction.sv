`ifndef AXI4LITESLAVEWRITETRANSACTION_INCLUDED_
`define AXI4LITESLAVEWRITETRANSACTION_INCLUDED_

class Axi4LiteSlaveWriteTransaction extends uvm_sequence_item;
  `uvm_object_utils(Axi4LiteSlaveWriteTransaction)
  
  rand bit [DELAY_WIDTH-1:0] writeDelayForAwready;
  rand bit [DELAY_WIDTH-1:0] writeDelayForWready;

  extern function new(string name = "Axi4LiteSlaveWriteTransaction");
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare (uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);

endclass : Axi4LiteSlaveWriteTransaction

function Axi4LiteSlaveWriteTransaction::new(string name = "Axi4LiteSlaveWriteTransaction");
  super.new(name);
endfunction : new

function void Axi4LiteSlaveWriteTransaction::do_copy (uvm_object rhs);
  Axi4LiteSlaveWriteTransaction axi4LiteSlaveWriteTxCopyObj;

  if(!$cast(axi4LiteSlaveWriteTxCopyObj,rhs )) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
  end
  super.do_copy(rhs);
  writeDelayForAwready = axi4LiteSlaveWriteTxCopyObj.writeDelayForAwready; 
  writeDelayForWready = axi4LiteSlaveWriteTxCopyObj.writeDelayForWready; 
endfunction : do_copy

function bit Axi4LiteSlaveWriteTransaction::do_compare (uvm_object rhs, uvm_comparer comparer);
  Axi4LiteSlaveWriteTransaction axi4LiteSlaveWriteTxCompareObj;

  if(!$cast(axi4LiteSlaveWriteTxCompareObj,rhs)) begin
    `uvm_fatal("FATAL_axi_SLAVE_TX_DO_COMPARE_FAILED","cast of the rhs object failed")
  return 0;
  end

  return super.do_compare(axi4LiteSlaveWriteTxCompareObj, comparer) &&
  writeDelayForAwready == axi4LiteSlaveWriteTxCompareObj.writeDelayForAwready &&
  writeDelayForWready == axi4LiteSlaveWriteTxCompareObj.writeDelayForWready;

endfunction : do_compare

function void Axi4LiteSlaveWriteTransaction::do_print(uvm_printer printer);
  printer.print_field($sformatf("writeDelayForAwready"),this.writeDelayForAwready,$bits(writeDelayForAwready),UVM_HEX);
  printer.print_field($sformatf("writeDelayForWready"),this.writeDelayForWready,$bits(writeDelayForWready),UVM_HEX);
endfunction : do_print

`endif

