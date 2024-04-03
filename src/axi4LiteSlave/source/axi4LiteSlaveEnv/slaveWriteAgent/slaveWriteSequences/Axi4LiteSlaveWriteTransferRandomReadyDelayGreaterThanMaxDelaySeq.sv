`ifndef AXI4LITESLAVEWRITETRANSFERRANDOMREADYDELAYGREATERTHANMAXDELAYSEQ_INCLUDED_
`define AXI4LITESLAVEWRITETRANSFERRANDOMREADYDELAYGREATERTHANMAXDELAYSEQ_INCLUDED_
 
class Axi4LiteSlaveWriteTransferRandomReadyDelayGreaterThanMaxDelaySeq extends Axi4LiteSlaveWriteBaseSeq;
  `uvm_object_utils(Axi4LiteSlaveWriteTransferRandomReadyDelayGreaterThanMaxDelaySeq)
 
  extern function new(string name = "Axi4LiteSlaveWriteTransferRandomReadyDelayGreaterThanMaxDelaySeq");
  extern task body();
endclass : Axi4LiteSlaveWriteTransferRandomReadyDelayGreaterThanMaxDelaySeq
 
function Axi4LiteSlaveWriteTransferRandomReadyDelayGreaterThanMaxDelaySeq::new(string name = "Axi4LiteSlaveWriteTransferRandomReadyDelayGreaterThanMaxDelaySeq");
  super.new(name);
endfunction : new
 
task Axi4LiteSlaveWriteTransferRandomReadyDelayGreaterThanMaxDelaySeq::body();
  super.body();
 
  req = Axi4LiteSlaveWriteTransaction::type_id::create("req");
  `uvm_info(get_type_name(), $sformatf("DEBUG_MSHA :: BEFORE start_item Axi4LiteSlaveWriteTransferRandomReadyDelayGreaterThanMaxDelaySeq"), UVM_NONE);
 
  start_item(req);
  if(!req.randomize() with {
                  writeDelayForReady > p_sequencer.axi4LiteSlaveWriteAgentConfig.maxDelayForReady;
                }) begin
    `uvm_fatal("Axi4LiteSlaveWriteTransferRandomReadyDelayGreaterThanMaxDelaySeq","Rand failed");
  end
 
  `uvm_info(get_type_name(), $sformatf("DEBUG_MSHA :: Axi4LiteSlaveWriteTransferRandomReadyDelayGreaterThanMaxDelaySeq \n%s",req.sprint()), UVM_NONE);
 
  finish_item(req);
  `uvm_info(get_type_name(), $sformatf("DEBUG_MSHA :: AFTER finish_item Axi4LiteSlaveWriteTransferRandomReadyDelayGreaterThanMaxDelaySeq"), UVM_NONE);
 
endtask : body
 
`endif
