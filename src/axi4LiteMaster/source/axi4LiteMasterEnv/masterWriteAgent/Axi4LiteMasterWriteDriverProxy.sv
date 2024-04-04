`ifndef AXI4LITEMASTERWRITEDRIVERPROXY_INCLUDED_
`define AXI4LITEMASTERWRITEDRIVERPROXY_INCLUDED_

class Axi4LiteMasterWriteDriverProxy extends uvm_driver #(Axi4LiteMasterWriteTransaction);
  `uvm_component_utils(Axi4LiteMasterWriteDriverProxy)

  uvm_seq_item_pull_port #(REQ, RSP) axi4LiteMasterWriteSeqItemPort;
  uvm_analysis_port #(RSP) axi4LiteMasterWriteRspPort;
  uvm_tlm_analysis_fifo #(Axi4LiteMasterWriteTransaction) axi4LiteMasterWriteFIFO;

  REQ reqWrite;
  RSP rspWrite;

  Axi4LiteMasterWriteAgentConfig axi4LiteMasterWriteAgentConfig;

  virtual Axi4LiteMasterWriteDriverBFM axi4LiteMasterWriteDriverBFM;

  extern function new(string name = "Axi4LiteMasterWriteDriverProxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task writeTransferTask();

endclass : Axi4LiteMasterWriteDriverProxy

function Axi4LiteMasterWriteDriverProxy::new(string name = "Axi4LiteMasterWriteDriverProxy",
                                             uvm_component parent = null);
  super.new(name, parent);
  axi4LiteMasterWriteSeqItemPort = new("axi4LiteMasterWriteSeqItemPort", this);
  axi4LiteMasterWriteRspPort     = new("axi4LiteMasterWriteRspPort", this);
  axi4LiteMasterWriteFIFO        = new("axi4LiteMasterWriteFIFO", this);
endfunction : new

function void Axi4LiteMasterWriteDriverProxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if (!uvm_config_db#(virtual Axi4LiteMasterWriteDriverBFM)::get(
          this, "", "Axi4LiteMasterWriteDriverBFM", axi4LiteMasterWriteDriverBFM
      )) begin
    `uvm_fatal("FATAL_MDP_CANNOT_GET_Axi4LiteMasterWriteDriverBFM",
               "cannot get() axi4LiteMasterWriteDriverBFM");
  end
endfunction : build_phase

function void Axi4LiteMasterWriteDriverProxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  axi4LiteMasterWriteDriverBFM.axi4LiteMasterWriteDriverProxy = this;
endfunction : end_of_elaboration_phase

task Axi4LiteMasterWriteDriverProxy::run_phase(uvm_phase phase);
  axi4LiteMasterWriteDriverBFM.waitForAresetn();
  writeTransferTask();
endtask : run_phase


task Axi4LiteMasterWriteDriverProxy::writeTransferTask();
  
  forever begin
    Axi4LiteMasterWriteTransaction  masterWriteTx;
    axi4LiteWriteTransferConfigStruct  masterWriteConfigStruct;
    axi4LiteWriteTransferPacketStruct masterWritePacketStruct;

    axi4LiteMasterWriteSeqItemPort.get_next_item(reqWrite);
    `uvm_info(get_type_name(), $sformatf(
              "MASTER_WRITE_TASK::Before Sending_Req_Write_Packet = \n%s", reqWrite.sprint()),
              UVM_HIGH);

    Axi4LiteMasterWriteConfigConverter::fromClass(axi4LiteMasterWriteAgentConfig, masterWriteConfigStruct);

    fork
      begin : MASTER_WRITE_ADDRESS_CHANNEL
        Axi4LiteMasterWriteTransaction  masterWriteAddressTx;
        axi4LiteWriteTransferPacketStruct masterWritePacketStruct;

        `uvm_info(get_type_name(),$sformatf("MASTER_WRITE_ADDRESS_THREAD::Checking write address struct packet = %p",
                                               masterWritePacketStruct),UVM_MEDIUM); 
        Axi4LiteMasterWriteSeqItemConverter::fromWriteClass(reqWrite, masterWritePacketStruct);
        axi4LiteMasterWriteDriverBFM.writeAddressChannelTask(masterWriteConfigStruct, masterWritePacketStruct);
        Axi4LiteMasterWriteSeqItemConverter::toWriteClass(masterWritePacketStruct,masterWriteAddressTx);
        `uvm_info(get_type_name(),$sformatf("MASTER_WRITE_ADDRESS_THREAD::Received write address packet From driverBFM = %p",
                                               masterWritePacketStruct),UVM_MEDIUM); 
      end

      begin : MASTER_WRITE_DATA_CHANNEL
        Axi4LiteMasterWriteTransaction  masterWriteDataTx;
        axi4LiteWriteTransferPacketStruct masterWritePacketStruct;

        `uvm_info(get_type_name(),$sformatf("MASTER_WRITE_DATA_THREAD::Checking write data struct packet = %p",
                                               masterWritePacketStruct),UVM_MEDIUM); 
        Axi4LiteMasterWriteSeqItemConverter::fromWriteClass(reqWrite, masterWritePacketStruct);
        axi4LiteMasterWriteDriverBFM.writeDataChannelTask(masterWriteConfigStruct, masterWritePacketStruct);
        Axi4LiteMasterWriteSeqItemConverter::toWriteClass(masterWritePacketStruct,masterWriteDataTx);
        `uvm_info(get_type_name(),$sformatf("MASTER_WRITE_DATA_THREAD::Received write data packet From driverBFM = %p",
                                               masterWritePacketStruct),UVM_MEDIUM); 
      end

      begin : MASTER_WRITE_RESPONSE_CHANNEL
        Axi4LiteMasterWriteTransaction  masterWriteResponseTx;
        axi4LiteWriteTransferPacketStruct masterWritePacketStruct;

        `uvm_info(get_type_name(),$sformatf("MASTER_WRITE_RESPONSE_THREAD::Checking write response struct packet = %p",
                                               masterWritePacketStruct),UVM_MEDIUM); 
        Axi4LiteMasterWriteSeqItemConverter::fromWriteClass(reqWrite, masterWritePacketStruct);
        axi4LiteMasterWriteDriverBFM.writeResponseChannelTask(masterWriteConfigStruct, masterWritePacketStruct);
        Axi4LiteMasterWriteSeqItemConverter::toWriteClass(masterWritePacketStruct,masterWriteResponseTx);
        `uvm_info(get_type_name(),$sformatf("MASTER_WRITE_RESPONSE_THREAD::Received write response packet From driverBFM = %p",
                                               masterWritePacketStruct),UVM_MEDIUM); 
      end

    join

    axi4LiteMasterWriteSeqItemPort.item_done();
  end
endtask : writeTransferTask

`endif

