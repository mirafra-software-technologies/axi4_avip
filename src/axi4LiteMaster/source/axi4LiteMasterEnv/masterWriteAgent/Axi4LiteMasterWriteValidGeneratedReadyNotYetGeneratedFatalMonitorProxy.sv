`ifndef AXI4LITEMASTERWRITEVALIDGENERATEDREADYNOTYETGENERATEDFATALMONITORPROXY_INCLUDED_
`define AXI4LITEMASTERWRITEVALIDGENERATEDREADYNOTYETGENERATEDFATALMONITORPROXY_INCLUDED_

class Axi4LiteMasterWriteValidGeneratedReadyNotYetGeneratedFatalMonitorProxy extends Axi4LiteMasterWriteMonitorProxy;
  `uvm_component_utils(Axi4LiteMasterWriteValidGeneratedReadyNotYetGeneratedFatalMonitorProxy)

  extern function new(string name = "Axi4LiteMasterWriteValidGeneratedReadyNotYetGeneratedFatalMonitorProxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern task sampleTask();
endclass : Axi4LiteMasterWriteValidGeneratedReadyNotYetGeneratedFatalMonitorProxy

function Axi4LiteMasterWriteValidGeneratedReadyNotYetGeneratedFatalMonitorProxy::new(string name = "Axi4LiteMasterWriteValidGeneratedReadyNotYetGeneratedFatalMonitorProxy",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void Axi4LiteMasterWriteValidGeneratedReadyNotYetGeneratedFatalMonitorProxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

function void Axi4LiteMasterWriteValidGeneratedReadyNotYetGeneratedFatalMonitorProxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

function void Axi4LiteMasterWriteValidGeneratedReadyNotYetGeneratedFatalMonitorProxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction : end_of_elaboration_phase

task Axi4LiteMasterWriteValidGeneratedReadyNotYetGeneratedFatalMonitorProxy::run_phase(uvm_phase phase);
  axi4LiteMasterWriteMonitorBFM.wait_for_aresetn();
  sampleTask(); 
endtask : run_phase

task Axi4LiteMasterWriteValidGeneratedReadyNotYetGeneratedFatalMonitorProxy::sampleTask();
  forever begin
   Axi4LiteMasterWriteTransaction masterWriteTx;
   axi4LiteWriteTransferConfigStruct masterWriteConfigStruct;
   axi4LiteWriteTransferPacketStruct masterWritePacketStruct;

   Axi4LiteMasterWriteConfigConverter::fromClass(axi4LiteMasterWriteAgentConfig, masterWriteConfigStruct);
   fork
     axi4LiteMasterWriteMonitorBFM.writeChannelTask(masterWriteConfigStruct, masterWritePacketStruct);
     axi4LiteMasterWriteMonitorBFM.readyTimeTask(masterWriteConfigStruct);
   join_any
  end
endtask

`endif

