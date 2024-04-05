`ifndef AXI4LITEMASTERAGENTBFM_INCLUDED_
`define AXI4LITEMASTERAGENTBFM_INCLUDED_

  
module Axi4LiteMasterAgentBFM #(parameter int ADDR_WIDTH = 32,
                                parameter int DATA_WIDTH = 32
                                )
                                (input   aclk,
                                 input   aresetn,
                                 output  awvalid,
                                 input   awready,
                                 output  wvalid,
                                 input   wready,
                                 input   bvalid,
                                 output  bready,

                                 output  arvalid,
                                 input   arready,
                                 input   rvalid,
                                 output  rready
                                 );
   
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  Axi4LiteMasterInterface axi4LiteMasterInterface(.aclk(aclk), 
                                                  .aresetn(aresetn)
                                                 );

  Axi4LiteMasterWriteAgentBFM axi4LiteMasterWriteAgentBFM (.aclk(axi4LiteMasterInterface.aclk), 
                                                           .aresetn(axi4LiteMasterInterface.aresetn),
                                                           .awvalid(axi4LiteMasterInterface.awvalid),
                                                           .awready(axi4LiteMasterInterface.awready),
                                                           .wvalid(axi4LiteMasterInterface.wvalid),
                                                           .wready(axi4LiteMasterInterface.wready),
                                                           .bvalid(axi4LiteMasterInterface.bvalid),
                                                           .bready(axi4LiteMasterInterface.bready)
                                                          );

  Axi4LiteMasterReadAgentBFM axi4LiteMasterReadAgentBFM (.aclk(axi4LiteMasterInterface.aclk), 
                                                         .aresetn(axi4LiteMasterInterface.aresetn),
                                                         .arvalid(axi4LiteMasterInterface.arvalid),
                                                         .arready(axi4LiteMasterInterface.arready),
                                                         .rvalid(axi4LiteMasterInterface.rvalid),
                                                         .rready(axi4LiteMasterInterface.rready)
                                                        );

  assign awvalid = axi4LiteMasterInterface.awvalid;
  assign wvalid  = axi4LiteMasterInterface.wvalid;
  assign bready  = axi4LiteMasterInterface.bready;

  assign arvalid = axi4LiteMasterInterface.arvalid; 
  assign rready  = axi4LiteMasterInterface.rready; 

  assign axi4LiteMasterInterface.awready = awready;   
  assign axi4LiteMasterInterface.wready  = wready;  
  assign axi4LiteMasterInterface.bvalid  = bvalid;  
  assign axi4LiteMasterInterface.arready = arready;  
  assign axi4LiteMasterInterface.rvalid  = rvalid;  

  initial begin
    `uvm_info("Axi4LiteMasterAgent",$sformatf("AXI4LITEMASTERAGENTBFM"),UVM_LOW);
  end
   
endmodule : Axi4LiteMasterAgentBFM
`endif
