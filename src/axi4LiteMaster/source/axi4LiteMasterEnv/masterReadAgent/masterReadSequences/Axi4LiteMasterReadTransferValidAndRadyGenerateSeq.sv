`ifndef AXI4LITEMASTERREADTRANSFERVALIDANDRADYGENERATESEQ_INCLUDED_
`define AXI4LITEMASTERREADTRANSFERVALIDANDRADYGENERATESEQ_INCLUDED_
 
class Axi4LiteMasterReadTransferValidAndRadyGenerateSeq extends Axi4LiteMasterReadBaseSeq;
  `uvm_object_utils(Axi4LiteMasterReadTransferValidAndRadyGenerateSeq)
 
  extern function new(string name = "Axi4LiteMasterReadTransferValidAndRadyGenerateSeq");
  extern task body();
endclass : Axi4LiteMasterReadTransferValidAndRadyGenerateSeq
 
function Axi4LiteMasterReadTransferValidAndRadyGenerateSeq::new(string name = "Axi4LiteMasterReadTransferValidAndRadyGenerateSeq");
  super.new(name);
endfunction : new
 
task Axi4LiteMasterReadTransferValidAndRadyGenerateSeq::body();
  super.body();
 
  req = Axi4LiteMasterReadTransaction::type_id::create("req");
  `uvm_info(get_type_name(), $sformatf("DEBUG_MSHA :: BEFORE start_item Axi4LiteMasterReadTransferValidAndRadyGenerateSeq"), UVM_NONE);
 
  start_item(req);
  if(!req.randomize() with {
                  readDelayForRready inside {[0:p_sequencer.axi4LiteMasterReadAgentConfig.maxDelayForReady]};
                }) begin
    `uvm_fatal("Axi4LiteMasterReadTransferValidAndRadyGenerateSeq","Rand failed");
  end
 
  `uvm_info(get_type_name(), $sformatf("DEBUG_MSHA :: Axi4LiteMasterReadTransferValidAndRadyGenerateSeq \n%s",req.sprint()), UVM_NONE);
 
  finish_item(req);
  `uvm_info(get_type_name(), $sformatf("DEBUG_MSHA :: AFTER finish_item Axi4LiteMasterReadTransferValidAndRadyGenerateSeq"), UVM_NONE);
 
endtask : body
 
`endif
