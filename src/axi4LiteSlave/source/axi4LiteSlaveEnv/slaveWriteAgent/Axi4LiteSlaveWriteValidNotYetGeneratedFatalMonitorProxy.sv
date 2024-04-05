`ifndef AXI4LITESLAVEWRITEVALIDNOTYETGENERATEDFATALMONITORPROXY_INCLUDED_
`define AXI4LITESLAVEWRITEVALIDNOTYETGENERATEDFATALMONITORPROXY_INCLUDED_

class Axi4LiteSlaveWriteValidNotYetGeneratedFatalMonitorProxy extends Axi4LiteSlaveWriteMonitorProxy;
  `uvm_component_utils(Axi4LiteSlaveWriteValidNotYetGeneratedFatalMonitorProxy)

  extern function new(string name = "Axi4LiteSlaveWriteValidNotYetGeneratedFatalMonitorProxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern task sampleTask();
endclass : Axi4LiteSlaveWriteValidNotYetGeneratedFatalMonitorProxy

function Axi4LiteSlaveWriteValidNotYetGeneratedFatalMonitorProxy::new(string name = "Axi4LiteSlaveWriteValidNotYetGeneratedFatalMonitorProxy",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void Axi4LiteSlaveWriteValidNotYetGeneratedFatalMonitorProxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

function void Axi4LiteSlaveWriteValidNotYetGeneratedFatalMonitorProxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

function void Axi4LiteSlaveWriteValidNotYetGeneratedFatalMonitorProxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction : end_of_elaboration_phase

task Axi4LiteSlaveWriteValidNotYetGeneratedFatalMonitorProxy::run_phase(uvm_phase phase);
  axi4LiteSlaveWriteMonitorBFM.waitForAresetn();
  sampleTask(); 
endtask : run_phase

task Axi4LiteSlaveWriteValidNotYetGeneratedFatalMonitorProxy::sampleTask();
  forever begin
   Axi4LiteSlaveWriteTransaction slaveWriteTx;
   axi4LiteWriteTransferConfigStruct slaveWriteConfigStruct;
   axi4LiteWriteTransferPacketStruct slaveWritePacketStruct;

   Axi4LiteSlaveWriteConfigConverter::fromClass(axi4LiteSlaveWriteAgentConfig, slaveWriteConfigStruct);
   fork
     axi4LiteSlaveWriteMonitorBFM.writeAddressChannelSampleTask(slaveWriteConfigStruct, slaveWritePacketStruct);
     axi4LiteSlaveWriteMonitorBFM.validDelayTask(slaveWriteConfigStruct);
   join_any
  end
endtask

`endif

