`ifndef AXI4LITEMASTERWRITEDRIVERBFM_INCLUDED_
`define AXI4LITEMASTERWRITEDRIVERBFM_INCLUDED_

import Axi4LiteGlobalsPkg::*;

interface Axi4LiteMasterWriteDriverBFM(input bit  aclk, 
                                       input bit  aresetn,
                                       output reg valid,
                                       input    	ready
                                      );  
  
  import uvm_pkg::*;
  `include "uvm_macros.svh" 

import Axi4LiteMasterWritePkg::Axi4LiteMasterWriteDriverProxy; 

  string name = "Axi4LiteMasterWriteDriverBFM"; 

  Axi4LiteMasterWriteDriverProxy axi4LiteMasterWriteDriverProxy;

  initial begin
    `uvm_info(name,$sformatf(name),UVM_LOW)
  end

  task wait_for_aresetn();
    @(negedge aresetn);
    `uvm_info(name,$sformatf("SYSTEM RESET DETECTED"),UVM_HIGH)
    valid <= 1'b0;
    @(posedge aresetn);
    `uvm_info(name,$sformatf("SYSTEM RESET DEACTIVATED"),UVM_HIGH)
  endtask : wait_for_aresetn

  task writeChannelTask(input axi4LiteWriteTransferConfigStruct masterWriteConfigStruct, 
                        inout axi4LiteWriteTransferPacketStruct masterWritePacketStruct
                       );
    `uvm_info(name,$sformatf("WRITE_CHANNEL_TASK_STARTED"),UVM_HIGH)
    @(posedge aclk);
    valid <= 1'b1;

    do begin
      @(posedge aclk);
    end
    while(ready !== 1);
    `uvm_info(name,$sformatf("WRITE_CHANNEL_TASK_ENDED"),UVM_HIGH)
  endtask

endinterface : Axi4LiteMasterWriteDriverBFM

`endif

