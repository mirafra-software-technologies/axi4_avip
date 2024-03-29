`ifndef AXI4LITEMASTERWRITEMONITORBFM_INCLUDED_
`define AXI4LITEMASTERWRITEMONITORBFM_INCLUDED_

import Axi4LiteGlobalsPkg::*;

interface Axi4LiteMasterWriteMonitorBFM(input bit aclk, 
                                        input bit aresetn,
                                        input  valid,
                                        input  ready
                                      );  

  import uvm_pkg::*;
  `include "uvm_macros.svh" 
  
  import Axi4LiteMasterWritePkg::Axi4LiteMasterWriteMonitorProxy;  
 
  Axi4LiteMasterWriteMonitorProxy axi4LiteMasterWriteMonitorProxy;

  int readyDelayCounter;
  
  task wait_for_aresetn();
    @(negedge aresetn);
    `uvm_info("FROM MASTER MON BFM",$sformatf("SYSTEM RESET DETECTED"),UVM_HIGH) 
    @(posedge aresetn);
    `uvm_info("FROM MASTER MON BFM",$sformatf("SYSTEM RESET DEACTIVATED"),UVM_HIGH)
  endtask : wait_for_aresetn

  task writeChannelTask(input axi4LiteWriteTransferConfigStruct masterWriteConfigStruct,output axi4LiteWriteTransferPacketStruct masterWritePacketStruct);
    `uvm_info("FROM MASTER WRITE MONITOR BFM",$sformatf("from axi4Lite master write"),UVM_HIGH)
    do begin
      @(posedge aclk);
    end while(valid===0);

    do begin
      @(posedge aclk);
    end while(ready===0);

    `uvm_info("FROM MASTER WRITE MONITOR BFM",$sformatf("after while loop from axi4Lite master write masterWritePacketStruct=%p ",masterWritePacketStruct),UVM_HIGH)
  endtask

  task readyTimeTask(input axi4LiteWriteTransferConfigStruct masterWriteConfigStruct);
    `uvm_info("FROM MASTER WRITE MONITOR BFM",$sformatf("from axi4Lite master write readyDelayTask"),UVM_HIGH)
    do begin
      @(posedge aclk);
    end while(valid===0);

    do begin
      @(posedge aclk);
      readyDelayCounter++;
      if(readyDelayCounter > masterWriteConfigStruct.maxDelayForReady) begin
        `uvm_fatal("MASTER WRITE MONITOR", "READY_DELAY_COUNTED_MAXIMUM");
      end
    end while(ready===0);

    `uvm_info("FROM MASTER WRITE MONITOR BFM",$sformatf("after while loop from axi4Lite master write readyTimeTask masterWriteConfigStruct=%p ",masterWriteConfigStruct),UVM_HIGH)
  endtask
endinterface : Axi4LiteMasterWriteMonitorBFM

`endif
