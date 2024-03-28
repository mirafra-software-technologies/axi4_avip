`ifndef AXI4LITESLAVEWRITEMONITORBFM_INCLUDED_
`define AXI4LITESLAVEWRITEMONITORBFM_INCLUDED_

import Axi4LiteGlobalsPkg::*;

interface Axi4LiteSlaveWriteMonitorBFM(input bit aclk, 
                                       input bit aresetn,
                                       input  valid,
                                       input  ready
                                     );  

  import uvm_pkg::*;
  `include "uvm_macros.svh" 
  
  import Axi4LiteSlaveWritePkg::Axi4LiteSlaveWriteMonitorProxy; 
 
  Axi4LiteSlaveWriteMonitorProxy axi4LiteSlaveWriteMonitorProxy;
  
  task wait_for_aresetn();
    @(negedge aresetn);
    `uvm_info("FROM SLAVE MON BFM",$sformatf("SYSTEM RESET DETECTED"),UVM_HIGH)
    @(posedge aresetn);
    `uvm_info("FROM SLAVE MON BFM",$sformatf("SYSTEM RESET DEACTIVATED"),UVM_HIGH)
  endtask : wait_for_aresetn

  task writeChannelTask(input axi4LiteWriteTransferConfigStruct slaveWriteConfigStruct,output axi4LiteWriteTransferPacketStruct slaveWritePacketStruct);
    `uvm_info("FROM SLAVE WRITE MONITOR BFM",$sformatf("from axi4Lite Slave write"),UVM_HIGH)
    do begin
      @(posedge aclk);
    end while(valid===0);

    do begin
      @(posedge aclk);
      slaveWritePacketStruct.writeDelayForReady++; 
    end while(ready===0);

    `uvm_info("FROM SLAVE WRITE MONITOR BFM",$sformatf("after while loop from axi4Lite Slave write slaveWritePacketStruct=%p ",slaveWritePacketStruct),UVM_HIGH)
  endtask

endinterface : Axi4LiteSlaveWriteMonitorBFM

`endif
