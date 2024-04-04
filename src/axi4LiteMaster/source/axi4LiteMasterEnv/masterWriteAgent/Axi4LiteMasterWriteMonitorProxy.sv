`ifndef AXI4LITEMASTERWRITEMONITORPROXY_INCLUDED_
`define AXI4LITEMASTERWRITEMONITORPROXY_INCLUDED_

class Axi4LiteMasterWriteMonitorProxy extends uvm_component;
  `uvm_component_utils(Axi4LiteMasterWriteMonitorProxy)

  Axi4LiteMasterWriteAgentConfig axi4LiteMasterWriteAgentConfig;

  Axi4LiteMasterWriteTransaction reqWrite;

  virtual Axi4LiteMasterWriteMonitorBFM axi4LiteMasterWriteMonitorBFM;
  
  // Declaring analysis port for the monitor port
  uvm_analysis_port#(Axi4LiteMasterWriteTransaction) axi4LiteMasterWriteAddressAnalysisPort;
  uvm_analysis_port#(Axi4LiteMasterWriteTransaction) axi4LiteMasterWriteDataAnalysisPort;
  uvm_analysis_port#(Axi4LiteMasterWriteTransaction) axi4LiteMasterWriteResponseAnalysisPort;

  //Variable: axi4LiteMasterWriteAddressFIFO
  //Declaring handle for uvm_tlm_analysis_fifo for write task
  uvm_tlm_analysis_fifo #(Axi4LiteMasterWriteTransaction) axi4LiteMasterWriteAddressFIFO;
  
  //Variable: axi4LiteMasterWriteDataFIFO
  //Declaring handle for uvm_tlm_analysis_fifo for write task
  uvm_tlm_analysis_fifo #(Axi4LiteMasterWriteTransaction) axi4LiteMasterWriteDataFIFO;

  extern function new(string name = "Axi4LiteMasterWriteMonitorProxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task writeAddressSampleTask();
  extern virtual task writeDataSampleTask();
  extern virtual task writeResponseSampleTask();

endclass : Axi4LiteMasterWriteMonitorProxy


function Axi4LiteMasterWriteMonitorProxy::new(string name = "Axi4LiteMasterWriteMonitorProxy",
                                 uvm_component parent = null);
  super.new(name, parent);
  axi4LiteMasterWriteAddressAnalysisPort  = new("axi4LiteMasterWriteAddressAnalysisPort",this);
  axi4LiteMasterWriteDataAnalysisPort     = new("axi4LiteMasterWriteDataAnalysisPort",this);
  axi4LiteMasterWriteResponseAnalysisPort = new("axi4LiteMasterWriteResponseAnalysisPort",this);
  axi4LiteMasterWriteAddressFIFO= new("axi4LiteMasterWriteAddressFIFO",this);
  axi4LiteMasterWriteDataFIFO= new("axi4LiteMasterWriteDataFIFO",this);
endfunction : new

function void Axi4LiteMasterWriteMonitorProxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(virtual Axi4LiteMasterWriteMonitorBFM)::get(this,"","Axi4LiteMasterWriteMonitorBFM",axi4LiteMasterWriteMonitorBFM)) begin
    `uvm_fatal("FATAL_MDP_CANNOT_GET_Axi4LiteMasterWriteMonitorBFM","cannot get() axi4LiteMasterWriteMonitorBFM");
  end 
endfunction : build_phase

function void Axi4LiteMasterWriteMonitorProxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

function void Axi4LiteMasterWriteMonitorProxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  axi4LiteMasterWriteMonitorBFM.axi4LiteMasterWriteMonitorProxy = this;
endfunction : end_of_elaboration_phase


task Axi4LiteMasterWriteMonitorProxy::run_phase(uvm_phase phase);
  axi4LiteMasterWriteMonitorBFM.waitForAresetn();
  fork
    writeAddressSampleTask();
    writeDataSampleTask();
    writeResponseSampleTask();
  join
endtask : run_phase

task Axi4LiteMasterWriteMonitorProxy::writeAddressSampleTask();
  forever begin
   Axi4LiteMasterWriteTransaction masterWriteTx;
   axi4LiteWriteTransferConfigStruct masterWriteConfigStruct;
   axi4LiteWriteTransferPacketStruct masterWritePacketStruct;

   Axi4LiteMasterWriteConfigConverter::fromClass(axi4LiteMasterWriteAgentConfig, masterWriteConfigStruct);

   axi4LiteMasterWriteMonitorBFM.writeAddressChannelSampleTask(masterWriteConfigStruct, masterWritePacketStruct);

   Axi4LiteMasterWriteSeqItemConverter::toWriteClass(masterWritePacketStruct,reqWrite);

   // // Clone and publish the cloned item to the subscribers
   // $cast(masterWriteTx,reqWrite.clone());

   // `uvm_info(get_type_name(),$sformatf("Packet received from master write monitor BFM clone packet is \n %s",masterWriteTx.sprint()),UVM_HIGH)
   // axi4LiteMasterWriteAddressAnalysisPort.write(masterWriteTx);
  end
endtask : writeAddressSampleTask

task Axi4LiteMasterWriteMonitorProxy::writeDataSampleTask();
  forever begin
   Axi4LiteMasterWriteTransaction masterWriteTx;
   axi4LiteWriteTransferConfigStruct masterWriteConfigStruct;
   axi4LiteWriteTransferPacketStruct masterWritePacketStruct;

   Axi4LiteMasterWriteConfigConverter::fromClass(axi4LiteMasterWriteAgentConfig, masterWriteConfigStruct);

   axi4LiteMasterWriteMonitorBFM.writeDataChannelSampleTask(masterWriteConfigStruct, masterWritePacketStruct);

   Axi4LiteMasterWriteSeqItemConverter::toWriteClass(masterWritePacketStruct,reqWrite);

   // // Clone and publish the cloned item to the subscribers
   // $cast(masterWriteTx,reqWrite.clone());

   // `uvm_info(get_type_name(),$sformatf("Packet received from master write monitor BFM clone packet is \n %s",masterWriteTx.sprint()),UVM_HIGH)
   // axi4LiteMasterWriteAddressAnalysisPort.write(masterWriteTx);
  end
endtask : writeDataSampleTask

task Axi4LiteMasterWriteMonitorProxy::writeResponseSampleTask();
  forever begin
   Axi4LiteMasterWriteTransaction masterWriteTx;
   axi4LiteWriteTransferConfigStruct masterWriteConfigStruct;
   axi4LiteWriteTransferPacketStruct masterWritePacketStruct;

   Axi4LiteMasterWriteConfigConverter::fromClass(axi4LiteMasterWriteAgentConfig, masterWriteConfigStruct);

   axi4LiteMasterWriteMonitorBFM.writeResponseChannelSampleTask(masterWriteConfigStruct, masterWritePacketStruct);

   Axi4LiteMasterWriteSeqItemConverter::toWriteClass(masterWritePacketStruct,reqWrite);

   // // Clone and publish the cloned item to the subscribers
   // $cast(masterWriteTx,reqWrite.clone());

   // `uvm_info(get_type_name(),$sformatf("Packet received from master write monitor BFM clone packet is \n %s",masterWriteTx.sprint()),UVM_HIGH)
   // axi4LiteMasterWriteAddressAnalysisPort.write(masterWriteTx);

  end
endtask : writeResponseSampleTask
`endif

