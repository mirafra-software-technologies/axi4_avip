`ifndef AXI4LITESLAVEWRITEDRIVERBFM_INCLUDED_
`define AXI4LITESLAVEWRITEDRIVERBFM_INCLUDED_

import Axi4LiteGlobalsPkg::*;

interface Axi4LiteSlaveWriteDriverBFM(input      aclk, 
                                      input      aresetn,
                                      input      valid,
                                      output reg ready
                                    ); 
   import uvm_pkg::*;
  `include "uvm_macros.svh" 

  import Axi4LiteSlaveWritePkg::Axi4LiteSlaveWriteDriverProxy;

  string name = "Axi4LiteSlaveWriteDriverBFM"; 
  
  Axi4LiteSlaveWriteDriverProxy axi4LiteSlaveWriteDriverProxy;

  initial begin
    `uvm_info("axi4 slave driver bfm",$sformatf("AXI4 SLAVE DRIVER BFM"),UVM_LOW);
  end

  task wait_for_system_reset();
    @(negedge aresetn);
    `uvm_info(name,$sformatf("SYSTEM RESET ACTIVATED"),UVM_HIGH)
    @(posedge aresetn);
    `uvm_info(name,$sformatf("SYSTEM RESET DE-ACTIVATED"),UVM_HIGH)
  endtask 

  task writeChannelTask(input axi4LiteWriteTransferConfigStruct slaveWriteConfigStruct, 
                        inout axi4LiteWriteTransferPacketStruct slaveWritePacketStruct
                       );
    `uvm_info(name,$sformatf("WRITE_CHANNEL_TASK_STARTED"),UVM_HIGH)
    do begin
      @(posedge aclk);
    end while(valid===0);

    repeat(slaveWritePacketStruct.writeDelayForReady) begin 
      @(posedge aclk);
    end
    ready <= 1'b1;
    `uvm_info(name,$sformatf("WRITE_CHANNEL_TASK_ENDED"),UVM_HIGH)
  endtask

endinterface : Axi4LiteSlaveWriteDriverBFM

`endif

