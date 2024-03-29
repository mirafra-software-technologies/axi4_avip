`ifndef AXI4LITESLAVEREADTRANSFERRANDOMREADYDELAYGREATERTHANMAXDELAYSEQ_INCLUDED_
`define AXI4LITESLAVEREADTRANSFERRANDOMREADYDELAYGREATERTHANMAXDELAYSEQ_INCLUDED_
 
class Axi4LiteSlaveReadTransferRandomReadyDelayGreaterThanMaxDelaySeq extends Axi4LiteSlaveReadBaseSeq;
  `uvm_object_utils(Axi4LiteSlaveReadTransferRandomReadyDelayGreaterThanMaxDelaySeq)
 
  extern function new(string name = "Axi4LiteSlaveReadTransferRandomReadyDelayGreaterThanMaxDelaySeq");
  extern task body();
endclass : Axi4LiteSlaveReadTransferRandomReadyDelayGreaterThanMaxDelaySeq
 
function Axi4LiteSlaveReadTransferRandomReadyDelayGreaterThanMaxDelaySeq::new(string name = "Axi4LiteSlaveReadTransferRandomReadyDelayGreaterThanMaxDelaySeq");
  super.new(name);
endfunction : new
 
task Axi4LiteSlaveReadTransferRandomReadyDelayGreaterThanMaxDelaySeq::body();
  super.body();

  req = Axi4LiteSlaveReadTransaction::type_id::create("req");
  `uvm_info(get_type_name(), $sformatf("DEBUG_MSHA :: BEFORE start_item Axi4LiteSlaveReadTransferRandomReadyDelayGreaterThanMaxDelaySeq"), UVM_NONE);
 
  start_item(req);
  if(!req.randomize() with {
                  readDelayForReady > {[0:p_sequencer.axi4LiteSlaveReadAgentConfig.maxDelayForReady]};
                }) begin
    `uvm_fatal("Axi4LiteSlaveReadTransferRandomReadyDelayGreaterThanMaxDelaySeq","Rand failed");
  end
 
  `uvm_info(get_type_name(), $sformatf("DEBUG_MSHA :: Axi4LiteSlaveReadTransferRandomReadyDelayGreaterThanMaxDelaySeq \n%s",req.sprint()), UVM_NONE);
 
  finish_item(req);
  `uvm_info(get_type_name(), $sformatf("DEBUG_MSHA :: AFTER finish_item Axi4LiteSlaveReadTransferRandomReadyDelayGreaterThanMaxDelaySeq"), UVM_NONE);
 
endtask : body
 
`endif
