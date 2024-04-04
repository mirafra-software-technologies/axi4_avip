`ifndef AXI4LITESLAVEWRITEMONITORPROXY_INCLUDED_
`define AXI4LITESLAVEWRITEMONITORPROXY_INCLUDED_

class Axi4LiteSlaveWriteMonitorProxy extends uvm_monitor;
  `uvm_component_utils(Axi4LiteSlaveWriteMonitorProxy)

  Axi4LiteSlaveWriteAgentConfig axi4LiteSlaveWriteAgentConfig;
  virtual Axi4LiteSlaveWriteMonitorBFM axi4LiteSlaveWriteMonitorBFM;

  Axi4LiteSlaveWriteTransaction reqWrite;

  uvm_analysis_port#(Axi4LiteSlaveWriteTransaction) axi4LiteSlaveWriteAddressAnalysisPort;
  uvm_analysis_port#(Axi4LiteSlaveWriteTransaction) axi4LiteSlaveWriteDataAnalysisPort;
  uvm_analysis_port#(Axi4LiteSlaveWriteTransaction) axi4LiteSlaveWriteResponseAnalysisPort;

  uvm_tlm_analysis_fifo #(Axi4LiteSlaveWriteTransaction) axi4LiteSlaveWriteAddressFIFO;
  uvm_tlm_analysis_fifo #(Axi4LiteSlaveWriteTransaction) axi4LiteSlaveWriteDataFIFO;
  
  extern function new(string name = "Axi4LiteSlaveWriteMonitorProxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task writeAddressSampleTask();
  extern virtual task writeDataSampleTask();
  extern virtual task writeResponseSampleTask();

endclass : Axi4LiteSlaveWriteMonitorProxy

function Axi4LiteSlaveWriteMonitorProxy::new(string name = "Axi4LiteSlaveWriteMonitorProxy",
                                 uvm_component parent = null);
  super.new(name, parent);
  axi4LiteSlaveWriteAddressAnalysisPort  = new("axi4LiteSlaveWriteAddressAnalysisPort",this);
  axi4LiteSlaveWriteDataAnalysisPort     = new("axi4LiteSlaveWriteDataAnalysisPort",this);
  axi4LiteSlaveWriteResponseAnalysisPort = new("axi4LiteSlaveWriteResponseAnalysisPort",this);
  axi4LiteSlaveWriteAddressFIFO          = new("axi4LiteSlaveWriteAddressFIFO",this);
  axi4LiteSlaveWriteDataFIFO             = new("axi4LiteSlaveWriteDataFIFO",this);
endfunction : new

function void Axi4LiteSlaveWriteMonitorProxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
   if(!uvm_config_db#(virtual Axi4LiteSlaveWriteMonitorBFM)::get(this,"","Axi4LiteSlaveWriteMonitorBFM",axi4LiteSlaveWriteMonitorBFM)) begin
     `uvm_fatal("FATAL_SMP_MON_BFM",$sformatf("Couldn't get S_MON_BFM in Axi4LiteSlaveWriteMonitorProxy"));  
  end 
endfunction : build_phase

function void Axi4LiteSlaveWriteMonitorProxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  axi4LiteSlaveWriteMonitorBFM.axi4LiteSlaveWriteMonitorProxy = this;
endfunction : end_of_elaboration_phase


task Axi4LiteSlaveWriteMonitorProxy::run_phase(uvm_phase phase);
  axi4LiteSlaveWriteMonitorBFM.waitForAresetn();
 fork
   writeAddressSampleTask(); 
   writeDataSampleTask(); 
   writeResponseSampleTask();
 join
endtask : run_phase 

task Axi4LiteSlaveWriteMonitorProxy::writeAddressSampleTask();
  forever begin
   Axi4LiteSlaveWriteTransaction slaveWriteAddressTx;
   axi4LiteWriteTransferConfigStruct slaveWriteConfigStruct;
   axi4LiteWriteTransferPacketStruct slaveWritePacketStruct;

   Axi4LiteSlaveWriteConfigConverter::fromClass(axi4LiteSlaveWriteAgentConfig, slaveWriteConfigStruct);
   axi4LiteSlaveWriteMonitorBFM.writeAddressChannelTask(slaveWriteConfigStruct, slaveWritePacketStruct);
   Axi4LiteSlaveWriteSeqItemConverter::toWriteClass(slaveWritePacketStruct,reqWrite);
    // Clone and publish the cloned item to the subscribers
   $cast(slaveWriteAddressTx,reqWrite.clone());

  `uvm_info(get_type_name(),$sformatf("Packet received from slave write monitor BFM clone packet is \n %s",slaveWriteAddressTx.sprint()),UVM_HIGH)
    axi4LiteSlaveWriteAddressAnalysisPort.write(slaveWriteAddressTx);
  end
endtask

task Axi4LiteSlaveWriteMonitorProxy::writeDataSampleTask();
  forever begin
   Axi4LiteSlaveWriteTransaction slaveWriteDataTx;
   axi4LiteWriteTransferConfigStruct slaveWriteConfigStruct;
   axi4LiteWriteTransferPacketStruct slaveWritePacketStruct;

   Axi4LiteSlaveWriteConfigConverter::fromClass(axi4LiteSlaveWriteAgentConfig, slaveWriteConfigStruct);
   axi4LiteSlaveWriteMonitorBFM.writeDataChannelTask(slaveWriteConfigStruct, slaveWritePacketStruct);
   Axi4LiteSlaveWriteSeqItemConverter::toWriteClass(slaveWritePacketStruct,reqWrite);
    // Clone and publish the cloned item to the subscribers
   $cast(slaveWriteDataTx,reqWrite.clone());

  `uvm_info(get_type_name(),$sformatf("Packet received from slave write monitor BFM clone packet is \n %s",slaveWriteDataTx.sprint()),UVM_HIGH)
    axi4LiteSlaveWriteDataAnalysisPort.write(slaveWriteDataTx);
  end
endtask

task Axi4LiteSlaveWriteMonitorProxy::writeResponseSampleTask();
  forever begin
   Axi4LiteSlaveWriteTransaction slaveWriteResponseTx;
   axi4LiteWriteTransferConfigStruct slaveWriteConfigStruct;
   axi4LiteWriteTransferPacketStruct slaveWritePacketStruct;

   Axi4LiteSlaveWriteConfigConverter::fromClass(axi4LiteSlaveWriteAgentConfig, slaveWriteConfigStruct);
   axi4LiteSlaveWriteMonitorBFM.writeResponseChannelTask(slaveWriteConfigStruct, slaveWritePacketStruct);
   Axi4LiteSlaveWriteSeqItemConverter::toWriteClass(slaveWritePacketStruct,reqWrite);
    // Clone and publish the cloned item to the subscribers
   $cast(slaveWriteResponseTx,reqWrite.clone());

  `uvm_info(get_type_name(),$sformatf("Packet received from slave write monitor BFM clone packet is \n %s",slaveWriteResponseTx.sprint()),UVM_HIGH)
    axi4LiteSlaveWriteResponseAnalysisPort.write(slaveWriteResponseTx);
  end
endtask


`endif
