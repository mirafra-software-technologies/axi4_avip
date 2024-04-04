`ifndef AXI4LITEMASTERREADMONITORBFM_INCLUDED_
`define AXI4LITEMASTERREADMONITORBFM_INCLUDED_

import Axi4LiteGlobalsPkg::*;
interface Axi4LiteMasterReadMonitorBFM(input bit aclk, 
                                       input bit aresetn,
                                       //Read Address Channel Signals
                                       input  arvalid,
                                       input  arready,
                                       //Read Data Channel Signals
                                       input  rvalid,
                                       input  rready
                                      );  

  import uvm_pkg::*;
  `include "uvm_macros.svh" 
  
  import Axi4LiteMasterReadPkg::Axi4LiteMasterReadMonitorProxy; 
 
  Axi4LiteMasterReadMonitorProxy axi4LiteMasterReadMonitorProxy;
  
  int readyDelayCounter;

  task waitForAresetn();
    @(negedge aresetn);
    `uvm_info("axi4LiteMasterReadMonitorProxy",$sformatf("SYSTEM RESET DETECTED"),UVM_HIGH) 
    @(posedge aresetn);
    `uvm_info("FROM MASTER MON BFM",$sformatf("SYSTEM RESET DEACTIVATED"),UVM_HIGH)
  endtask : waitForAresetn

  task readAddressChannelSampleTask(input axi4LiteReadTransferConfigStruct masterReadConfigStruct,
                                    output axi4LiteReadTransferPacketStruct masterReadPacketStruct
                                   );
    `uvm_info("FROM MASTER READ MONITOR BFM",$sformatf("from axi4Lite master read address channel task"),UVM_HIGH)
    do begin
      @(posedge aclk);
    end while(arvalid===0);

    do begin
      @(posedge aclk);
    end while(arready===0);

    `uvm_info("FROM MASTER READ MONITOR BFM",$sformatf("after arvalid & arready asserted from master read address channel masterReadPacketStruct=%p ",masterReadPacketStruct),UVM_HIGH)
  endtask : readAddressChannelSampleTask

  task readDataChannelSampleTask(input axi4LiteReadTransferConfigStruct masterReadConfigStruct,
                                 output axi4LiteReadTransferPacketStruct masterReadPacketStruct
                                );
    `uvm_info("FROM MASTER READ MONITOR BFM",$sformatf("from axi4Lite master read data channel task"),UVM_HIGH)
    do begin
      @(posedge aclk);
    end while(rvalid===0);

    do begin
      @(posedge aclk);
    end while(rready===0);

    `uvm_info("FROM MASTER READ MONITOR BFM",$sformatf("after rvalid & rready asserted from master read data channel masterReadPacketStruct=%p ",masterReadPacketStruct),UVM_HIGH)
  endtask : readDataChannelSampleTask


  task readyTimeTask(input axi4LiteReadTransferConfigStruct masterReadConfigStruct);
    `uvm_info("FROM MASTER READ MONITOR BFM",$sformatf("from axi4Lite master read readyDelayTask"),UVM_HIGH)
    do begin
      @(posedge aclk);
    end while(arvalid===0);

    do begin
      @(posedge aclk);
      readyDelayCounter++;
      if(readyDelayCounter > masterReadConfigStruct.maxDelayForReady) begin
        `uvm_fatal("MASTER READ MONITOR", "READY_DELAY_COUNTED_MAXIMUM");
      end
    end while(arready===0);

    `uvm_info("FROM MASTER READ MONITOR BFM",$sformatf("after while loop from axi4Lite master read readyTimeTask masterReadConfigStruct=%p ",masterReadConfigStruct),UVM_HIGH)
  endtask
endinterface : Axi4LiteMasterReadMonitorBFM

`endif
