`ifndef AXI4LITEMASTERREADDRIVERBFM_INCLUDED_
`define AXI4LITEMASTERREADDRIVERBFM_INCLUDED_

import Axi4LiteGlobalsPkg::*;

interface Axi4LiteMasterReadDriverBFM(input bit  aclk, 
                                      input bit  aresetn,
                                      //Read Address Channel Signals
                                      output reg arvalid,
                                      input      arready,
                                      //Read Data Channel Signals
                                      input      rvalid,
                                      output reg rready
                                     );  
  
  import uvm_pkg::*;
  `include "uvm_macros.svh" 

  import Axi4LiteMasterReadPkg::Axi4LiteMasterReadDriverProxy;
  string name = "Axi4LiteMasterReadDriverBFM"; 

  Axi4LiteMasterReadDriverProxy axi4LiteMasterReadDriverProxy;

  initial begin
    `uvm_info(name,$sformatf(name),UVM_LOW)
  end

  task waitForAresetn();
    @(negedge aresetn);
    `uvm_info(name,$sformatf("SYSTEM RESET DETECTED"),UVM_HIGH)
    arvalid <= 1'b0;
    @(posedge aresetn);
    `uvm_info(name,$sformatf("SYSTEM RESET DEACTIVATED"),UVM_HIGH)
  endtask : waitForAresetn

  task readAddressChannelTask(input axi4LiteReadTransferConfigStruct masterReadConfigStruct, 
                              inout axi4LiteReadTransferPacketStruct masterReadPacketStruct
                             );
    `uvm_info(name,$sformatf("READ_ADDRESS_CHANNEL_TASK_STARTED"),UVM_HIGH)
    @(posedge aclk);
    arvalid <= 1'b1;

    do begin
      @(posedge aclk);
    end
    while(arready !== 1);
    
    `uvm_info(name,$sformatf("READ_ADDRESS_CHANNEL_TASK_ENDED"),UVM_HIGH)
  endtask : readAddressChannelTask

  task readDataChannelTask(input axi4LiteReadTransferConfigStruct masterReadConfigStruct, 
                           inout axi4LiteReadTransferPacketStruct masterReadPacketStruct
                          );
    `uvm_info(name,$sformatf("READ_DATA_CHANNEL_TASK_STARTED"),UVM_HIGH)
    do begin
      @(posedge aclk);
    end
    while(rvalid === 0);
    
    `uvm_info(name , $sformatf("After while loop rvalid asserted "),UVM_HIGH)
    //FIXME
    //What if user given the writeDelayForReady as 0 
    repeat(masterReadPacketStruct.readDelayForRready-1) begin 
      @(posedge aclk);
    end
    rready <= 1'b1;
    `uvm_info(name,$sformatf("READ_DATA_CHANNEL_TASK_ENDED"),UVM_HIGH)
  endtask : readDataChannelTask

endinterface : Axi4LiteMasterReadDriverBFM

`endif

