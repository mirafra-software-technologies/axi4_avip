`ifndef AXI4LITEMASTERWRITEBASESEQ_INCLUDED_
`define AXI4LITEMASTERWRITEBASESEQ_INCLUDED_

class Axi4LiteMasterWriteBaseSeq extends uvm_sequence #(Axi4LiteMasterWriteTransaction);
  `uvm_object_utils(Axi4LiteMasterWriteBaseSeq)

  `uvm_declare_p_sequencer(Axi4LiteMasterWriteSequencer)
  
  extern function new(string name = "Axi4LiteMasterWriteBaseSeq");
  extern task body();

endclass : Axi4LiteMasterWriteBaseSeq

function Axi4LiteMasterWriteBaseSeq::new(string name = "Axi4LiteMasterWriteBaseSeq");
  super.new(name);
endfunction : new

task Axi4LiteMasterWriteBaseSeq::body();
  //dynamic casting of p_sequencer and m_sequencer
  if(!$cast(p_sequencer,m_sequencer))begin
    `uvm_error(get_full_name(),"Virtual sequencer pointer cast failed")
  end
endtask : body

`endif
