`ifndef AXI4LITESLAVEWRITEMONITORBFM_INCLUDED_
`define AXI4LITESLAVEWRITEMONITORBFM_INCLUDED_

import Axi4LiteGlobalsPkg::*;

interface Axi4LiteSlaveWriteMonitorBFM(input bit aclk, 
                                       input bit aresetn,
                                       //Write Address Channel Signals
                                       input  awvalid,
                                       input  awready,

                                       //Write Data Channel Signals
                                       input  wvalid,
                                       input  wready,

                                       //Write Response Channel Signals
                                       input  bvalid,
                                       input  bready
                                      );

  import uvm_pkg::*;
  `include "uvm_macros.svh" 
  
  import Axi4LiteSlaveWritePkg::Axi4LiteSlaveWriteMonitorProxy; 
 
  Axi4LiteSlaveWriteMonitorProxy axi4LiteSlaveWriteMonitorProxy;
  
  int validDelayCounter;

  task waitForAresetn();
    @(negedge aresetn);
    `uvm_info("FROM SLAVE MON BFM",$sformatf("SYSTEM RESET DETECTED"),UVM_HIGH)
    @(posedge aresetn);
    `uvm_info("FROM SLAVE MON BFM",$sformatf("SYSTEM RESET DEACTIVATED"),UVM_HIGH)
  endtask : waitForAresetn

  task writeAddressChannelSampleTask(input axi4LiteWriteTransferConfigStruct slaveWriteConfigStruct,
                               output axi4LiteWriteTransferPacketStruct slaveWritePacketStruct);
    `uvm_info("FROM SLAVE WRITE MONITOR BFM",$sformatf("from axi4Lite Slave writeAddressChannelTask"),UVM_HIGH)
    do begin
     @(posedge aclk);
    end while(awvalid===0);

    do begin
      @(posedge aclk);
      slaveWritePacketStruct.writeDelayForAwready++; 
    end while(awready===0);

    `uvm_info("FROM SLAVE WRITE MONITOR BFM",$sformatf("after while loop from axi4Lite Slave writeAddressChannel slaveWritePacketStruct=%p ",slaveWritePacketStruct),UVM_HIGH)
  endtask : writeAddressChannelSampleTask 

     task writeDataChannelSampleTask(input axi4LiteWriteTransferConfigStruct slaveWriteConfigStruct,
                              output axi4LiteWriteTransferPacketStruct slaveWritePacketStruct);
    `uvm_info("FROM SLAVE WRITE MONITOR BFM",$sformatf("from axi4Lite Slave writeDataChannelTask"),UVM_HIGH)
    do begin
      @(posedge aclk);
    end while(wvalid===0);

    do begin
      @(posedge aclk);
      slaveWritePacketStruct.writeDelayForWready++; 
    end while(wready===0);

    `uvm_info("FROM SLAVE WRITE MONITOR BFM",$sformatf("after while loop from axi4Lite Slave writeDataChannel slaveWritePacketStruct=%p ",slaveWritePacketStruct),UVM_HIGH)
  endtask : writeDataChannelSampleTask 

  
  task writeResponseChannelSampleTask(input axi4LiteWriteTransferConfigStruct slaveWriteConfigStruct,
                                output axi4LiteWriteTransferPacketStruct slaveWritePacketStruct);
    `uvm_info("FROM SLAVE WRITE MONITOR BFM",$sformatf("from axi4Lite Slave writeResponseChannelTask"),UVM_HIGH)
    do begin
      @(posedge aclk);
    end while(bvalid===0);

    do begin
      @(posedge aclk);
      slaveWritePacketStruct.writeDelayForAwready++; 
    end while(bready===0);

    `uvm_info("FROM SLAVE WRITE MONITOR BFM",$sformatf("after while loop from axi4Lite Slave writeResponseChannel slaveWritePacketStruct=%p ",slaveWritePacketStruct),UVM_HIGH)
  endtask : writeResponseChannelSampleTask 

  task validDelayTask(input axi4LiteWriteTransferConfigStruct slaveWriteConfigStruct);
    `uvm_info("FROM SLAVE WRITE MONITOR BFM",$sformatf("from axi4Lite Slave write validDelayTask"),UVM_HIGH)
    do begin
      @(posedge aclk);
      validDelayCounter++;
      if(validDelayCounter > slaveWriteConfigStruct.maxDelayForValid) begin
        `uvm_fatal("SLAVE WRITE MONITOR", "AWVALID_DELAY_COUNTED_MAXIMUM");
      end
    end while(awvalid===0);

    do begin
      @(posedge aclk);
    end while(awready===0);

    `uvm_info("FROM SLAVE WRITE MONITOR BFM",$sformatf("after while loop from axi4Lite Slave write validDelayTask slaveWriteConfigStruct=%p ",slaveWriteConfigStruct),UVM_HIGH)
  endtask : validDelayTask

endinterface : Axi4LiteSlaveWriteMonitorBFM

`endif
