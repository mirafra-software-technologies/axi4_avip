`ifndef AXI4LITEMASTERVALIDGENERATETEST_INCLUDED_
`define AXI4LITEMASTERVALIDGENERATETEST_INCLUDED_
 
class Axi4LiteMasterValidGenerateTest extends Axi4LiteBaseTest;
  `uvm_component_utils(Axi4LiteMasterValidGenerateTest)
 
  Axi4LiteVirtualMasterValidGenerateSeq axi4LiteVirtualMasterValidGenerateSeq;
 
  extern function new(string name = "Axi4LiteMasterValidGenerateTest", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
 
endclass : Axi4LiteMasterValidGenerateTest
 
function Axi4LiteMasterValidGenerateTest::new(string name = "Axi4LiteMasterValidGenerateTest",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new
 
function void Axi4LiteMasterValidGenerateTest::build_phase(uvm_phase phase);
  super.build_phase(phase);

  foreach(axi4LiteEnvConfig.axi4LiteMasterEnvConfig.axi4LiteMasterWriteAgentConfig[i])begin
    set_inst_override_by_type("axi4LiteEnv.*", Axi4LiteMasterWriteMonitorProxy::get_type(), Axi4LiteMasterWriteValidGeneratedReadyNotYetGeneratedFatalMonitorProxy::get_type());
  end 

  foreach(axi4LiteEnvConfig.axi4LiteMasterEnvConfig.axi4LiteMasterReadAgentConfig[i])begin
    set_inst_override_by_type("axi4LiteEnv.*", Axi4LiteMasterReadMonitorProxy::get_type(), Axi4LiteMasterReadValidGeneratedReadyNotYetGeneratedFatalMonitorProxy::get_type());
  end 
endfunction : build_phase
 
task Axi4LiteMasterValidGenerateTest::run_phase(uvm_phase phase);
 
  axi4LiteVirtualMasterValidGenerateSeq = Axi4LiteVirtualMasterValidGenerateSeq::type_id::create("axi4LiteVirtualMasterValidGenerateSeq");
 
  `uvm_info(get_type_name(),$sformatf("Inside run_phase Axi4LiteMasterValidGenerateTest"),UVM_LOW);
 
  phase.raise_objection(this);
    axi4LiteVirtualMasterValidGenerateSeq.start(axi4LiteEnv.axi4LiteVirtualSequencer);
    #20;
  phase.drop_objection(this);
 
endtask : run_phase
 
`endif
