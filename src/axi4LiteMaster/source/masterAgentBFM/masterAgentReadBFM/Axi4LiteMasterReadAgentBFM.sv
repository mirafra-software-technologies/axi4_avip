`ifndef AXI4LITEMASTERREADAGENTBFM_INCLUDED_
`define AXI4LITEMASTERREADAGENTBFM_INCLUDED_

module Axi4LiteMasterReadAgentBFM #(parameter int ADDR_WIDTH = 32,
                                    parameter int DATA_WIDTH = 32
                                   )
                                   (input  aclk,
                                    input  aresetn,
                                    output arvalid,
                                    input  arready,
                                    input  rvalid,
                                    output rready
                                    );
   
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  Axi4LiteMasterReadInterface axi4LiteMasterReadInterface(.aclk(aclk), 
                                                          .aresetn(aresetn)
                                                         );

  Axi4LiteMasterReadDriverBFM axi4LiteMasterReadDriverBFM (.aclk(axi4LiteMasterReadInterface.aclk), 
                                                           .aresetn(axi4LiteMasterReadInterface.aresetn),
                                                           .arvalid(axi4LiteMasterReadInterface.arvalid),
                                                           .arready(axi4LiteMasterReadInterface.arready),
                                                           .rvalid(axi4LiteMasterReadInterface.rvalid),
                                                           .rready(axi4LiteMasterReadInterface.rready)
                                                          );

  Axi4LiteMasterReadMonitorBFM axi4LiteMasterReadMonitorBFM (.aclk(axi4LiteMasterReadInterface.aclk),
                                                             .aresetn(axi4LiteMasterReadInterface.aresetn),
                                                             .arvalid(axi4LiteMasterReadInterface.arvalid),
                                                             .arready(axi4LiteMasterReadInterface.arready),
                                                             .rvalid(axi4LiteMasterReadInterface.rvalid),
                                                             .rready(axi4LiteMasterReadInterface.rready)
                                                            );

  assign arvalid = axi4LiteMasterReadInterface.arvalid; 
  assign rready  = axi4LiteMasterReadInterface.rready; 

  assign axi4LiteMasterReadInterface.arready = arready;  
  assign axi4LiteMasterReadInterface.rvalid  = rvalid;  

  //-------------------------------------------------------
  // Setting the virtual handle of BMFs into config_db
  //-------------------------------------------------------
  initial begin
    uvm_config_db#(virtual Axi4LiteMasterReadDriverBFM)::set(null,"*", "Axi4LiteMasterReadDriverBFM", axi4LiteMasterReadDriverBFM); 
    uvm_config_db#(virtual Axi4LiteMasterReadMonitorBFM)::set(null,"*", "Axi4LiteMasterReadMonitorBFM",axi4LiteMasterReadMonitorBFM);
  end

  bind axi4LiteMasterReadMonitorBFM Axi4LiteMasterReadAssertions M_A (.aclk(aclk),
                                                           .aresetn(aresetn),
                                                           .valid(valid), 
                                                           .ready(ready)
                                                          );


  initial begin
    `uvm_info("Axi4LiteMasterReadAgentBFM",$sformatf("AXI4LITE MASTERREADAGENTBFM"),UVM_LOW);
  end
   
endmodule : Axi4LiteMasterReadAgentBFM
`endif
