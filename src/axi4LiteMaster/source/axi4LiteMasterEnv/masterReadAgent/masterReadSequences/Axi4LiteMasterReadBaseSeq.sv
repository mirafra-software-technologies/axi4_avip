`ifndef AXI4LITEMASTERREADBASESEQ_INCLUDED_
`define AXI4LITEMASTERREADBASESEQ_INCLUDED_

class Axi4LiteMasterReadBaseSeq extends uvm_sequence #(Axi4LiteMasterReadTransaction);
  `uvm_object_utils(Axi4LiteMasterReadBaseSeq)
  
  `uvm_declare_p_sequencer(Axi4LiteMasterReadSequencer)

  extern function new(string name = "Axi4LiteMasterReadBaseSeq");
  extern task body();

endclass : Axi4LiteMasterReadBaseSeq

function Axi4LiteMasterReadBaseSeq::new(string name = "Axi4LiteMasterReadBaseSeq");
  super.new(name);
endfunction : new

task Axi4LiteMasterReadBaseSeq::body();
  //dynamic casting of p_sequencer and m_sequencer
  if(!$cast(p_sequencer,m_sequencer))begin
    `uvm_error(get_full_name(),"Virtual sequencer pointer cast failed")
  end
endtask : body

`endif
