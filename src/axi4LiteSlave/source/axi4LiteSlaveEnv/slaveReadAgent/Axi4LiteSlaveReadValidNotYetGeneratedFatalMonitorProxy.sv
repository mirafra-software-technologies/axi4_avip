`ifndef AXI4LITESLAVEREADVALIDNOTYETGENERATEDFATALMONITORPROXY_INCLUDED_
`define AXI4LITESLAVEREADVALIDNOTYETGENERATEDFATALMONITORPROXY_INCLUDED_

class Axi4LiteSlaveReadValidNotYetGeneratedFatalMonitorProxy extends Axi4LiteSlaveReadMonitorProxy;
  `uvm_component_utils(Axi4LiteSlaveReadValidNotYetGeneratedFatalMonitorProxy)

  extern function new(string name = "Axi4LiteSlaveReadValidNotYetGeneratedFatalMonitorProxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern task sampleTask();
endclass : Axi4LiteSlaveReadValidNotYetGeneratedFatalMonitorProxy

function Axi4LiteSlaveReadValidNotYetGeneratedFatalMonitorProxy::new(string name = "Axi4LiteSlaveReadValidNotYetGeneratedFatalMonitorProxy",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void Axi4LiteSlaveReadValidNotYetGeneratedFatalMonitorProxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

function void Axi4LiteSlaveReadValidNotYetGeneratedFatalMonitorProxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

function void Axi4LiteSlaveReadValidNotYetGeneratedFatalMonitorProxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction : end_of_elaboration_phase

task Axi4LiteSlaveReadValidNotYetGeneratedFatalMonitorProxy::run_phase(uvm_phase phase);
  axi4LiteSlaveReadMonitorBFM.wait_for_aresetn();
  sampleTask(); 
endtask : run_phase

task Axi4LiteSlaveReadValidNotYetGeneratedFatalMonitorProxy::sampleTask();
  forever begin
   Axi4LiteSlaveReadTransaction slaveReadTx;
   axi4LiteReadTransferConfigStruct slaveReadConfigStruct;
   axi4LiteReadTransferPacketStruct slaveReadPacketStruct;

   Axi4LiteSlaveReadConfigConverter::fromClass(axi4LiteSlaveReadAgentConfig, slaveReadConfigStruct);
   fork
     axi4LiteSlaveReadMonitorBFM.readChannelTask(slaveReadConfigStruct, slaveReadPacketStruct);
     axi4LiteSlaveReadMonitorBFM.validDelayTask(slaveReadConfigStruct);
   join_any
  end
endtask

`endif

