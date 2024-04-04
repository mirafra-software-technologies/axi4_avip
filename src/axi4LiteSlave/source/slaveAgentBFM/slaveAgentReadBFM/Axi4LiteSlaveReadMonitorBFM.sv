`ifndef AXI4LITESLAVEREADMONITORBFM_INCLUDED_
`define AXI4LITESLAVEREADMONITORBFM_INCLUDED_

import Axi4LiteGlobalsPkg::*;

interface Axi4LiteSlaveReadMonitorBFM(input bit aclk, 
                                      input bit aresetn,
                                      //ReadddressChannelSignals
                                      input  arvalid,
                                      input  arready,
                                      //ReadDataChannelSignals
                                      input  rvalid,
                                      input  rready
                                     ); 

  import uvm_pkg::*;
  `include "uvm_macros.svh" 
  
  import Axi4LiteSlaveReadPkg::Axi4LiteSlaveReadMonitorProxy;
 
  Axi4LiteSlaveReadMonitorProxy axi4LiteSlaveReadMonitorProxy;

  int validDelayCounter;
  
  task waitForAresetn();
    @(negedge aresetn);
    `uvm_info("axi4LiteSlaveReadMonitorProxy",$sformatf("SYSTEM RESET DETECTED"),UVM_HIGH) 
    @(posedge aresetn);
    `uvm_info("FROM Slave MON BFM",$sformatf("SYSTEM RESET DEACTIVATED"),UVM_HIGH)
  endtask : waitForAresetn

  task readAddressChannelTask(input axi4LiteReadTransferConfigStruct slaveReadConfigStruct,output axi4LiteReadTransferPacketStruct slaveReadPacketStruct);
    @(posedge aclk);
    `uvm_info("FROM SLAVE READ MONITOR BFM",$sformatf("from axi4Lite Slave readAddressChannelTask"),UVM_HIGH)

    do begin
      @(posedge aclk);
    end while(arvalid===0);

    do begin
      @(posedge aclk);
      slaveReadPacketStruct.readDelayForArready++; 
    end while(arready===0);

    `uvm_info("FROM SLAVE READ MONITOR BFM",$sformatf("after while loop from axi4Lite Slave readAddressChannel slaveReadPacketStruct=%p ",slaveReadPacketStruct),UVM_HIGH)
  endtask : readAddressChannelTask

  task readDataChannelTask(input axi4LiteReadTransferConfigStruct slaveReadConfigStruct,output axi4LiteReadTransferPacketStruct slaveReadPacketStruct);
    @(posedge aclk);
    `uvm_info("FROM SLAVE READ MONITOR BFM",$sformatf("from axi4Lite Slave readDataChannelTask"),UVM_HIGH)

    do begin
      @(posedge aclk);
    end while(rvalid === 0);

    do begin
      @(posedge aclk);
      slaveReadPacketStruct.readDelayForRready++; 
    end while(rready === 0);

    `uvm_info("FROM SLAVE READ MONITOR BFM",$sformatf("after while loop from axi4Lite Slave readDataChannel slaveReadPacketStruct=%p ",slaveReadPacketStruct),UVM_HIGH)
  endtask : readDataChannelTask

  task validDelayTask(input axi4LiteReadTransferConfigStruct slaveReadConfigStruct);
    `uvm_info("FROM SLAVE READ MONITOR BFM",$sformatf("from axi4Lite Slave read validDelayTask"),UVM_HIGH)
    do begin
      @(posedge aclk);
      validDelayCounter++;
      if(validDelayCounter > slaveReadConfigStruct.maxDelayForValid) begin
        `uvm_fatal("SLAVE READ MONITOR", "VALID_DELAY_COUNTED_MAXIMUM");
      end
    end while(arvalid === 0);

    do begin
      @(posedge aclk);
    end while(arready===0);

    `uvm_info("FROM SLAVE READ MONITOR BFM",$sformatf("after while loop from axi4Lite Slave read validDelayTask slaveReadConfigStruct=%p ",slaveReadConfigStruct),UVM_HIGH)
  endtask : validDelayTask


endinterface : Axi4LiteSlaveReadMonitorBFM

`endif
