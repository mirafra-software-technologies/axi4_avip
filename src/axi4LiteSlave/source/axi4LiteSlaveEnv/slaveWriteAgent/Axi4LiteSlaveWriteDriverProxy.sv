`ifndef AXI4LITESLAVEWRITEDRIVERPROXY_INCLUDED_
`define AXI4LITESLAVEWRITEDRIVERPROXY_INCLUDED_

class Axi4LiteSlaveWriteDriverProxy extends uvm_driver#(Axi4LiteSlaveWriteTransaction);
  `uvm_component_utils(Axi4LiteSlaveWriteDriverProxy)

  uvm_seq_item_pull_port #(REQ, RSP) axi4LiteSlaveWriteSeqItemPort;
  uvm_analysis_port #(RSP) axi4LiteSlaveWriteRspPort;
  
  REQ reqWrite;
  RSP rspWrite;

  Axi4LiteSlaveWriteAgentConfig axi4LiteSlaveWriteAgentConfig;

  virtual Axi4LiteSlaveWriteDriverBFM axi4LiteSlaveWriteDriverBFM;

  //Declaring handle for uvm_tlm_analysis_fifo's for all the five channels
  uvm_tlm_fifo #(Axi4LiteSlaveWriteTransaction) axi4LiteSlaveWriteAddressFIFO;
  uvm_tlm_fifo #(Axi4LiteSlaveWriteTransaction) axi4LiteSlaveWriteDataInFIFO;
  uvm_tlm_fifo #(Axi4LiteSlaveWriteTransaction) axi4LiteSlaveWriteResponseFIFO;
  uvm_tlm_fifo #(Axi4LiteSlaveWriteTransaction) axi4LiteSlaveWriteDataOutFIFO;

  extern function new(string name = "Axi4LiteSlaveWriteDriverProxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task axi4LiteSlaveWriteTask();
 // extern virtual task axi4LiteSlaveMemoryWrite(input Axi4LiteSlaveWriteTransaction struct_write_packet);

 endclass : Axi4LiteSlaveWriteDriverProxy

function Axi4LiteSlaveWriteDriverProxy::new(string name = "Axi4LiteSlaveWriteDriverProxy",
                                      uvm_component parent = null);
  super.new(name, parent);
  axi4LiteSlaveWriteSeqItemPort        = new("axi4LiteSlaveWriteSeqItemPort", this);
  axi4LiteSlaveWriteRspPort            = new("axi4LiteSlaveWriteRspPort", this);
  axi4LiteSlaveWriteAddressFIFO        = new("axi4LiteSlaveWriteAddressFIFO",this,16);
  axi4LiteSlaveWriteDataInFIFO         = new("axi4LiteSlaveWriteDataInFIFO",this,16);
  axi4LiteSlaveWriteResponseFIFO       = new("axi4LiteSlaveWriteResponseFIFO",this,16);
  axi4LiteSlaveWriteDataOutFIFO        = new("axi4LiteSlaveWriteDataOutFIFO",this,16);
endfunction : new

function void Axi4LiteSlaveWriteDriverProxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
/*  if(!uvm_config_db #(virtual Axi4LiteSlaveWriteDriverBFM)::get(this,"","Axi4LiteSlaveWriteDriverBFM",axi4LiteSlaveWriteDriverBFM)) begin
    `uvm_fatal("FATAL_MDP_CANNOT_GET_tx_DRIVER_BFM","cannot get() axi4LiteSlaveWriteDriverBFM");
  end
*/endfunction : build_phase

function void Axi4LiteSlaveWriteDriverProxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  // GopalS: axi4LiteSlaveWriteDriverBFM.axi4LiteSlaveWriteDriverProxy= this;
endfunction  : end_of_elaboration_phase

task Axi4LiteSlaveWriteDriverProxy::run_phase(uvm_phase phase);

  `uvm_info(get_type_name(),"SLAVE_DRIVER_PROXY",UVM_MEDIUM)
/*
  //wait for system reset
  axi4LiteSlaveWriteDriverBFM.wait_for_system_reset();
  fork 
    axi4LiteSlaveWriteTask();
  join
*/

endtask : run_phase 

task Axi4LiteSlaveWriteDriverProxy::axi4LiteSlaveWriteTask();
 
 
endtask : axi4LiteSlaveWriteTask

`endif
