`ifndef AXI4LITERANDOMREADYDELAYGREATERTHANMAXDELAYTEST_INCLUDED_
`define AXI4LITERANDOMREADYDELAYGREATERTHANMAXDELAYTEST_INCLUDED_
 
class Axi4LiteRandomReadyDelayGreaterThanMaxDelayTest extends Axi4LiteBaseTest;
  `uvm_component_utils(Axi4LiteRandomReadyDelayGreaterThanMaxDelayTest)
 
  Axi4LiteVirtualRandomReadyDelayGreaterThanMaxDelaySeq axi4LiteVirtualRandomReadyDelayGreaterThanMaxDelaySeq;
 
  extern function new(string name = "Axi4LiteRandomReadyDelayGreaterThanMaxDelayTest", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
 
endclass : Axi4LiteRandomReadyDelayGreaterThanMaxDelayTest
 
function Axi4LiteRandomReadyDelayGreaterThanMaxDelayTest::new(string name = "Axi4LiteRandomReadyDelayGreaterThanMaxDelayTest",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new
 
function void Axi4LiteRandomReadyDelayGreaterThanMaxDelayTest::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase
 
task Axi4LiteRandomReadyDelayGreaterThanMaxDelayTest::run_phase(uvm_phase phase);
 
  axi4LiteVirtualRandomReadyDelayGreaterThanMaxDelaySeq = Axi4LiteVirtualRandomReadyDelayGreaterThanMaxDelaySeq::type_id::create("axi4LiteVirtualRandomReadyDelayGreaterThanMaxDelaySeq");
 
  `uvm_info(get_type_name(),$sformatf("Inside run_phase Axi4LiteRandomReadyDelayGreaterThanMaxDelayTest"),UVM_LOW);
 
  phase.raise_objection(this);
    axi4LiteVirtualRandomReadyDelayGreaterThanMaxDelaySeq.start(axi4LiteEnv.axi4LiteVirtualSequencer);
    #20;
  phase.drop_objection(this);
 
endtask : run_phase
 
`endif
