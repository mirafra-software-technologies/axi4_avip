`ifndef AXI4LITEMASTERREADVALIDGENERATEDREADYNOTYETGENERATEDFATALMONITORPROXY_INCLUDED_
`define AXI4LITEMASTERREADVALIDGENERATEDREADYNOTYETGENERATEDFATALMONITORPROXY_INCLUDED_

class Axi4LiteMasterReadValidGeneratedReadyNotYetGeneratedFatalMonitorProxy extends Axi4LiteMasterReadMonitorProxy;
  `uvm_component_utils(Axi4LiteMasterReadValidGeneratedReadyNotYetGeneratedFatalMonitorProxy)

  extern function new(string name = "Axi4LiteMasterReadValidGeneratedReadyNotYetGeneratedFatalMonitorProxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern task sampleTask();
endclass : Axi4LiteMasterReadValidGeneratedReadyNotYetGeneratedFatalMonitorProxy

function Axi4LiteMasterReadValidGeneratedReadyNotYetGeneratedFatalMonitorProxy::new(string name = "Axi4LiteMasterReadValidGeneratedReadyNotYetGeneratedFatalMonitorProxy",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void Axi4LiteMasterReadValidGeneratedReadyNotYetGeneratedFatalMonitorProxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

function void Axi4LiteMasterReadValidGeneratedReadyNotYetGeneratedFatalMonitorProxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

function void Axi4LiteMasterReadValidGeneratedReadyNotYetGeneratedFatalMonitorProxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction : end_of_elaboration_phase

task Axi4LiteMasterReadValidGeneratedReadyNotYetGeneratedFatalMonitorProxy::run_phase(uvm_phase phase);
  axi4LiteMasterReadMonitorBFM.waitForAresetn();
  sampleTask(); 
endtask : run_phase

task Axi4LiteMasterReadValidGeneratedReadyNotYetGeneratedFatalMonitorProxy::sampleTask();
  forever begin
   Axi4LiteMasterReadTransaction masterReadTx;
   axi4LiteReadTransferConfigStruct masterReadConfigStruct;
   axi4LiteReadTransferPacketStruct masterReadPacketStruct;

   Axi4LiteMasterReadConfigConverter::fromClass(axi4LiteMasterReadAgentConfig, masterReadConfigStruct);
   fork
     axi4LiteMasterReadMonitorBFM.readAddressChannelSampleTask(masterReadConfigStruct, masterReadPacketStruct);
     axi4LiteMasterReadMonitorBFM.readyTimeTask(masterReadConfigStruct);
   join_any
  end
endtask

`endif

