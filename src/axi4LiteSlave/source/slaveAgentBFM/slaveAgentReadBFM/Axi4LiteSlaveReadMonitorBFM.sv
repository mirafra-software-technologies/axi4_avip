`ifndef AXI4LITESLAVEREADMONITORBFM_INCLUDED_
`define AXI4LITESLAVEREADMONITORBFM_INCLUDED_

import Axi4LiteGlobalsPkg::*;

interface Axi4LiteSlaveReadMonitorBFM(input bit aclk, 
                                      input bit aresetn,
                                      input valid,
                                      input ready
                                     );  

  import uvm_pkg::*;
  `include "uvm_macros.svh" 
  
  import Axi4LiteSlaveReadPkg::Axi4LiteSlaveReadMonitorProxy;
 
  Axi4LiteSlaveReadMonitorProxy axi4LiteSlaveReadMonitorProxy;
  
  task wait_for_aresetn();
    @(negedge aresetn);
    `uvm_info("axi4LiteSlaveReadMonitorProxy",$sformatf("SYSTEM RESET DETECTED"),UVM_HIGH) 
    @(posedge aresetn);
    `uvm_info("FROM Slave MON BFM",$sformatf("SYSTEM RESET DEACTIVATED"),UVM_HIGH)
  endtask : wait_for_aresetn

  task readChannelTask(input axi4LiteReadTransferConfigStruct slaveReadConfigStruct,output axi4LiteReadTransferPacketStruct slaveReadPacketStruct);

    @(posedge aclk);
    `uvm_info("FROM SLAVE READ MONITOR BFM",$sformatf("from axi4Lite Slave read"),UVM_HIGH)

    do begin
      @(posedge aclk);
    end while(valid===0);

    do begin
      @(posedge aclk);
      slaveReadPacketStruct.readDelayForReady++; 
    end while(ready===0);

    `uvm_info("FROM SLAVE READ MONITOR BFM",$sformatf("after while loop from axi4Lite Slave read slaveReadPacketStruct=%p ",slaveReadPacketStruct),UVM_HIGH)
  endtask

endinterface : Axi4LiteSlaveReadMonitorBFM

`endif
