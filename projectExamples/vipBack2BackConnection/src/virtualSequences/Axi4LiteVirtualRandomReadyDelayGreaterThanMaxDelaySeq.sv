`ifndef AXI4LITEVIRTUALRANDOMREADYDELAYGREATERTHANMAXDELAYSEQ_INCLUDED_
`define AXI4LITEVIRTUALRANDOMREADYDELAYGREATERTHANMAXDELAYSEQ_INCLUDED_
 
class Axi4LiteVirtualRandomReadyDelayGreaterThanMaxDelaySeq extends Axi4LiteVirtualBaseSeq;
  `uvm_object_utils(Axi4LiteVirtualRandomReadyDelayGreaterThanMaxDelaySeq)
 
   Axi4LiteMasterWriteTransferValidGenerateSeq axi4LiteMasterWriteTransferValidGenerateSeq;
   Axi4LiteMasterReadTransferValidGenerateSeq axi4LiteMasterReadTransferValidGenerateSeq;
   Axi4LiteSlaveWriteTransferRandomReadyDelayGreaterThanMaxDelaySeq axi4LiteSlaveWriteTransferRandomReadyDelayGreaterThanMaxDelaySeq;
   Axi4LiteSlaveReadTransferRandomReadyDelayGreaterThanMaxDelaySeq axi4LiteSlaveReadTransferRandomReadyDelayGreaterThanMaxDelaySeq;
 
  extern function new(string name = "Axi4LiteVirtualRandomReadyDelayGreaterThanMaxDelaySeq");
  extern task body();
endclass : Axi4LiteVirtualRandomReadyDelayGreaterThanMaxDelaySeq
 
function Axi4LiteVirtualRandomReadyDelayGreaterThanMaxDelaySeq::new(string name = "Axi4LiteVirtualRandomReadyDelayGreaterThanMaxDelaySeq");
  super.new(name);
endfunction : new
 
task Axi4LiteVirtualRandomReadyDelayGreaterThanMaxDelaySeq::body();
  axi4LiteMasterWriteTransferValidGenerateSeq = Axi4LiteMasterWriteTransferValidGenerateSeq::type_id::create("axi4LiteMasterWriteTransferValidGenerateSeq");
  axi4LiteMasterReadTransferValidGenerateSeq = Axi4LiteMasterReadTransferValidGenerateSeq::type_id::create("axi4LiteMasterReadTransferValidGenerateSeq");
  axi4LiteSlaveWriteTransferRandomReadyDelayGreaterThanMaxDelaySeq = Axi4LiteSlaveWriteTransferRandomReadyDelayGreaterThanMaxDelaySeq::type_id::create("axi4LiteSlaveWriteTransferRandomReadyDelayGreaterThanMaxDelaySeq");
  axi4LiteSlaveReadTransferRandomReadyDelayGreaterThanMaxDelaySeq = Axi4LiteSlaveReadTransferRandomReadyDelayGreaterThanMaxDelaySeq::type_id::create("axi4LiteSlaveReadTransferRandomReadyDelayGreaterThanMaxDelaySeq");
 
  `uvm_info(get_type_name(), $sformatf("DEBUG_MSHA :: Inside Axi4LiteVirtualRandomReadyDelayGreaterThanMaxDelaySeq"), UVM_NONE);

  fork
    begin : SLAVE_WRITE
      forever begin
        axi4LiteSlaveWriteTransferRandomReadyDelayGreaterThanMaxDelaySeq.start(p_sequencer.axi4LiteSlaveVirtualSequencer.axi4LiteSlaveWriteSequencer);
      end
    end
    begin : SLAVE_READ
      forever begin
       axi4LiteSlaveReadTransferRandomReadyDelayGreaterThanMaxDelaySeq.start(p_sequencer.axi4LiteSlaveVirtualSequencer.axi4LiteSlaveReadSequencer);
      end
    end
  join_none
 
  fork
    begin: MASTER_WRITE
      repeat(1) begin
        axi4LiteMasterWriteTransferValidGenerateSeq.start(p_sequencer.axi4LiteMasterVirtualSequencer.axi4LiteMasterWriteSequencer);
      end
    end

    begin: MASTER_READ
      repeat(1) begin
        axi4LiteMasterReadTransferValidGenerateSeq.start(p_sequencer.axi4LiteMasterVirtualSequencer.axi4LiteMasterReadSequencer);
      end
    end
  join_none
endtask : body
 
`endif
