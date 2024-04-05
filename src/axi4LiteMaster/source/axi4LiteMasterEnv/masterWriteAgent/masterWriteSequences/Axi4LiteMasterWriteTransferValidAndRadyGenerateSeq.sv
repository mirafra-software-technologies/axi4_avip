`ifndef AXI4LITEMASTERWRITETRANSFERVALIDANDRADYGENERATESEQ_INCLUDED_
`define AXI4LITEMASTERWRITETRANSFERVALIDANDRADYGENERATESEQ_INCLUDED_
 
class Axi4LiteMasterWriteTransferValidAndRadyGenerateSeq extends Axi4LiteMasterWriteBaseSeq;
  `uvm_object_utils(Axi4LiteMasterWriteTransferValidAndRadyGenerateSeq)
 
  extern function new(string name = "Axi4LiteMasterWriteTransferValidAndRadyGenerateSeq");
  extern task body();
endclass : Axi4LiteMasterWriteTransferValidAndRadyGenerateSeq
 
function Axi4LiteMasterWriteTransferValidAndRadyGenerateSeq::new(string name = "Axi4LiteMasterWriteTransferValidAndRadyGenerateSeq");
  super.new(name);
endfunction : new
 
task Axi4LiteMasterWriteTransferValidAndRadyGenerateSeq::body();
  super.body();
 
  req = Axi4LiteMasterWriteTransaction::type_id::create("req");
  `uvm_info(get_type_name(), $sformatf("DEBUG_MSHA :: BEFORE start_item Axi4LiteMasterWriteTransferValidAndRadyGenerateSeq"), UVM_NONE);
 
  start_item(req);
  if(!req.randomize() with {
                  writeDelayForBready inside {[0:p_sequencer.axi4LiteMasterWriteAgentConfig.maxDelayForReady]};
                }) begin
    `uvm_fatal("Axi4LiteMasterWriteTransferValidAndRadyGenerateSeq","Rand failed");
  end
 
  `uvm_info(get_type_name(), $sformatf("DEBUG_MSHA :: Axi4LiteMasterWriteTransferValidAndRadyGenerateSeq \n%s",req.sprint()), UVM_NONE);
 
  finish_item(req);
  `uvm_info(get_type_name(), $sformatf("DEBUG_MSHA :: AFTER finish_item Axi4LiteMasterWriteTransferValidAndRadyGenerateSeq"), UVM_NONE);
 
endtask : body
 
`endif
