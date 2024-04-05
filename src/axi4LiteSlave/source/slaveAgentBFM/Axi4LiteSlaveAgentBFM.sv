`ifndef AXI4LITESLAVEAGENTBFM_INCLUDED_
`define AXI4LITESLAVEAGENTBFM_INCLUDED_

module Axi4LiteSlaveAgentBFM #(parameter int ADDR_WIDTH = 32,
                               parameter int DATA_WIDTH = 32
                                )
                                (input  aclk,
                                 input  aresetn,
                                 input  awvalid,
                                 output awready,
                                 input  wvalid,
                                 output wready,
                                 output bvalid,
                                 input  bready,

                                 input  arvalid,
                                 output arready,
                                 output rvalid,
                                 input  rready
                                 );
   
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  Axi4LiteSlaveInterface axi4LiteSlaveInterface(.aclk(aclk), 
                                                .aresetn(aresetn)
                                               );

  Axi4LiteSlaveWriteAgentBFM axi4LiteSlaveWriteAgentBFM (.aclk(axi4LiteSlaveInterface.aclk), 
                                                         .aresetn(axi4LiteSlaveInterface.aresetn),
                                                         .awvalid(axi4LiteSlaveInterface.awvalid),
                                                         .awready(axi4LiteSlaveInterface.awready),
                                                         .wvalid(axi4LiteSlaveInterface.wvalid),
                                                         .wready(axi4LiteSlaveInterface.wready),
                                                         .bvalid(axi4LiteSlaveInterface.bvalid),
                                                         .bready(axi4LiteSlaveInterface.bready)
                                                        );

  Axi4LiteSlaveReadAgentBFM axi4LiteSlaveReadAgentBFM (.aclk(axi4LiteSlaveInterface.aclk), 
                                                       .aresetn(axi4LiteSlaveInterface.aresetn),
                                                       .arvalid(axi4LiteSlaveInterface.arvalid),
                                                       .arready(axi4LiteSlaveInterface.arready),
                                                       .rvalid(axi4LiteSlaveInterface.rvalid),
                                                       .rready(axi4LiteSlaveInterface.rready)
                                                      );
                                 
  assign axi4LiteSlaveInterface.awvalid = awvalid;
  assign axi4LiteSlaveInterface.wvalid  = wvalid; 
  assign axi4LiteSlaveInterface.bready  = bready; 

  assign axi4LiteSlaveInterface.arvalid = arvalid; 
  assign axi4LiteSlaveInterface.rready  = rready;  

  assign awready = axi4LiteSlaveInterface.awready;  
  assign wready  = axi4LiteSlaveInterface.wready;
  assign bvalid  = axi4LiteSlaveInterface.bvalid;

  assign arready = axi4LiteSlaveInterface.arready; 
  assign rvalid  = axi4LiteSlaveInterface.rvalid; 

  initial begin
    `uvm_info("Axi4LiteMasterAgent",$sformatf("AXI4LITESLAVEAGENTBFM"),UVM_LOW);
  end
   
endmodule : Axi4LiteSlaveAgentBFM
`endif
