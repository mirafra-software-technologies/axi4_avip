`ifndef AXI4LITEMASTERREADMONITORBFM_INCLUDED_
`define AXI4LITEMASTERREADMONITORBFM_INCLUDED_

import Axi4LiteGlobalsPkg::*;
interface Axi4LiteMasterReadMonitorBFM(input bit aclk, 
                                       input bit aresetn,
                                       input  valid,
                                       input  ready 
                                      );  

  import uvm_pkg::*;
  `include "uvm_macros.svh" 
  
  import Axi4LiteMasterReadPkg::Axi4LiteMasterReadMonitorProxy; 
 
  Axi4LiteMasterReadMonitorProxy axi4LiteMasterReadMonitorProxy;
  
  int readyDelayCounter;

  task wait_for_aresetn();
    @(negedge aresetn);
    `uvm_info("axi4LiteMasterReadMonitorProxy",$sformatf("SYSTEM RESET DETECTED"),UVM_HIGH) 
    @(posedge aresetn);
    `uvm_info("FROM MASTER MON BFM",$sformatf("SYSTEM RESET DEACTIVATED"),UVM_HIGH)
  endtask : wait_for_aresetn

  task readChannelTask(input axi4LiteReadTransferConfigStruct masterReadConfigStruct,output axi4LiteReadTransferPacketStruct masterReadPacketStruct);
    `uvm_info("FROM MASTER READ MONITOR BFM",$sformatf("from axi4Lite master read"),UVM_HIGH)
    do begin
      @(posedge aclk);
    end while(valid===0);

    do begin
      @(posedge aclk);
    end while(ready===0);

    `uvm_info("FROM MASTER READ MONITOR BFM",$sformatf("after while loop from axi4Lite master read masterReadPacketStruct=%p ",masterReadPacketStruct),UVM_HIGH)
  endtask

  task readyTimeTask(input axi4LiteReadTransferConfigStruct masterReadConfigStruct);
    `uvm_info("FROM MASTER READ MONITOR BFM",$sformatf("from axi4Lite master read readyDelayTask"),UVM_HIGH)
    do begin
      @(posedge aclk);
    end while(valid===0);

    do begin
      @(posedge aclk);
      readyDelayCounter++;
      if(readyDelayCounter > masterReadConfigStruct.maxDelayForReady) begin
        `uvm_fatal("MASTER READ MONITOR", "READY_DELAY_COUNTED_MAXIMUM");
      end
    end while(ready===0);

    `uvm_info("FROM MASTER READ MONITOR BFM",$sformatf("after while loop from axi4Lite master read readyTimeTask masterReadConfigStruct=%p ",masterReadConfigStruct),UVM_HIGH)
  endtask
endinterface : Axi4LiteMasterReadMonitorBFM

`endif
