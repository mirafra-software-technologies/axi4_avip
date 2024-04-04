`ifndef AXI4LITEMASTERWRITEDRIVERBFM_INCLUDED_
`define AXI4LITEMASTERWRITEDRIVERBFM_INCLUDED_

import Axi4LiteGlobalsPkg::*;

interface Axi4LiteMasterWriteDriverBFM(input bit  aclk, 
                                       input bit  aresetn,
                                       //Write Address Channel Signals
                                       output reg                     awvalid,
                                       input    	                    awready,
                                       //Write Data Channel Signals
                                       output reg                      wvalid,
                                       input                           wready,
                                       //Write Response Channel Signals
                                       input            bvalid,
                                       output	reg       bready
                                      );  
  
  import uvm_pkg::*;
  `include "uvm_macros.svh" 

import Axi4LiteMasterWritePkg::Axi4LiteMasterWriteDriverProxy; 

  string name = "Axi4LiteMasterWriteDriverBFM"; 

  Axi4LiteMasterWriteDriverProxy axi4LiteMasterWriteDriverProxy;

  initial begin
    `uvm_info(name,$sformatf(name),UVM_LOW)
  end

  task waitForAresetn();
    @(negedge aresetn);
    `uvm_info(name,$sformatf("SYSTEM RESET DETECTED"),UVM_HIGH)
    awvalid <= 1'b0;
    wvalid <= 1'b0;
    @(posedge aresetn);
    `uvm_info(name,$sformatf("SYSTEM RESET DEACTIVATED"),UVM_HIGH)
  endtask : waitForAresetn

  task writeAddressChannelTask(input axi4LiteWriteTransferConfigStruct masterWriteConfigStruct, 
                               inout axi4LiteWriteTransferPacketStruct masterWritePacketStruct
                              );
    `uvm_info(name,$sformatf("WRITE_ADDRESS_CHANNEL_TASK_STARTED"),UVM_HIGH)
    @(posedge aclk);
    awvalid <= 1'b1;

    do begin
      @(posedge aclk);
    end while(awready !== 1);
    `uvm_info(name,$sformatf("WRITE_ADDRESS_CHANNEL_TASK_ENDED"),UVM_HIGH)
  endtask : writeAddressChannelTask

  task writeDataChannelTask(input axi4LiteWriteTransferConfigStruct masterWriteConfigStruct, 
                            inout axi4LiteWriteTransferPacketStruct masterWritePacketStruct
                           );
    `uvm_info(name,$sformatf("WRITE_DATA_CHANNEL_TASK_STARTED"),UVM_HIGH)
    @(posedge aclk);
    wvalid <= 1'b1;

    do begin
      @(posedge aclk);
    end while(wready !== 1);
    `uvm_info(name,$sformatf("WRITE_DATA_CHANNEL_TASK_ENDED"),UVM_HIGH)
  endtask : writeDataChannelTask

  task writeResponseChannelTask(input axi4LiteWriteTransferConfigStruct masterWriteConfigStruct, 
                                inout axi4LiteWriteTransferPacketStruct masterWritePacketStruct
                               );
    `uvm_info(name,$sformatf("WRITE_RESPONSE_CHANNEL_TASK_STARTED"),UVM_HIGH)
    do begin
      @(posedge aclk);
    end while(bvalid === 0);

    `uvm_info(name , $sformatf("After while loop bvalid asserted "),UVM_HIGH)
    //FIXME
    //What if user given the writeDelayForBready as 0 
    repeat(masterWritePacketStruct.writeDelayForBready-1) begin 
      @(posedge aclk);
    end
    bready <= 1'b1;
    `uvm_info(name,$sformatf("WRITE_RESPONSE_CHANNEL_TASK_ENDED"),UVM_HIGH)
  endtask : writeResponseChannelTask

endinterface : Axi4LiteMasterWriteDriverBFM

`endif

