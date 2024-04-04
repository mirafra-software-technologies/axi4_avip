`ifndef AXI4LITESLAVEWRITEDRIVERBFM_INCLUDED_
`define AXI4LITESLAVEWRITEDRIVERBFM_INCLUDED_

import Axi4LiteGlobalsPkg::*;

interface Axi4LiteSlaveWriteDriverBFM(input      aclk, 
                                      input      aresetn,
                                      //WriteAddressChannel
                                      input                     awvalid ,
                                      output reg                awready ,

                                      //WriteDataChannel
                                      input                       wvalid ,
                                      output reg	                wready ,
      
                                      //Write Response Channel
                                      output reg                  bvalid ,
                                      input		                    bready
                                    ); 
   import uvm_pkg::*;
  `include "uvm_macros.svh" 

  import Axi4LiteSlaveWritePkg::Axi4LiteSlaveWriteDriverProxy;

  string name = "Axi4LiteSlaveWriteDriverBFM"; 
  
  Axi4LiteSlaveWriteDriverProxy axi4LiteSlaveWriteDriverProxy;

  initial begin
    `uvm_info("axi4 slave driver bfm",$sformatf("AXI4 SLAVE DRIVER BFM"),UVM_LOW);
  end

  task waitForAresetn();
    @(negedge aresetn);
    `uvm_info(name,$sformatf("SYSTEM RESET ACTIVATED"),UVM_HIGH)
      bvalid <= 1'b0;
     @(posedge aresetn);
    `uvm_info(name,$sformatf("SYSTEM RESET DE-ACTIVATED"),UVM_HIGH)
  endtask : waitForAresetn 

task writeAddressChannelTask(input axi4LiteWriteTransferConfigStruct slaveWriteConfigStruct, 
                             inout axi4LiteWriteTransferPacketStruct slaveWritePacketStruct
                             );
  `uvm_info(name,$sformatf("WRITE_ADDRESS_CHANNEL_TASK_STARTED"),UVM_HIGH)
  do begin
    @(posedge aclk);
  end while(awvalid===0);

  `uvm_info(name , $sformatf("After while loop awvalid asserted "),UVM_HIGH)
//FIXME
//What if user given the writeDelayForAwready as 0 
  repeat(slaveWritePacketStruct.writeDelayForAwready-1) begin 
    @(posedge aclk);
  end
  awready <= 1'b1;
  `uvm_info(name,$sformatf("WRITE_ADDRESS_CHANNEL_TASK_ENDED"),UVM_HIGH)
endtask :writeAddressChannelTask


task writeDataChannelTask(input axi4LiteWriteTransferConfigStruct slaveWriteConfigStruct, 
                          inout axi4LiteWriteTransferPacketStruct slaveWritePacketStruct
                         );
  
  `uvm_info(name,$sformatf("WRITE_DATA_CHANNEL_TASK_STARTED"),UVM_HIGH)
    do begin
      @(posedge aclk);
    end while(wvalid===0);

    `uvm_info(name , $sformatf("After while loop wvalid asserted "),UVM_HIGH)
//FIXME
//What if user given the writeDelayForWready as 0 
    repeat(slaveWritePacketStruct.writeDelayForWready-1) begin 
      @(posedge aclk);
    end
    wready <= 1'b1;
   `uvm_info(name,$sformatf("WRITE_DATA_CHANNEL_TASK_ENDED"),UVM_HIGH)
endtask :writeDataChannelTask


task writeResponseChannelTask(input axi4LiteWriteTransferConfigStruct slaveWriteConfigStruct, 
                              inout axi4LiteWriteTransferPacketStruct slaveWritePacketStruct
                             );
  `uvm_info(name,$sformatf("WRITE_RESPONSE_CHANNEL_TASK_STARTED"),UVM_HIGH)
   @(posedge aclk);
   bvalid <= 1'b1;
   do begin
    @(posedge aclk);
   end while(bready === 0);
   `uvm_info(name ,$sformatf("After while loop bready asserted "),UVM_HIGH)
   `uvm_info(name,$sformatf("WRITE_RESPONSE_CHANNEL_TASK_ENDED"),UVM_HIGH)
endtask


endinterface : Axi4LiteSlaveWriteDriverBFM

`endif

