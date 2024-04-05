`ifndef AXI4LITESLAVEWRITEAGENTBFM_INCLUDED_
`define AXI4LITESLAVEWRITEAGENTBFM_INCLUDED_

   
module Axi4LiteSlaveWriteAgentBFM #(parameter int ADDR_WIDTH = 32,
                                    parameter int DATA_WIDTH = 32
                                   )
                                   (input  aclk,
                                    input  aresetn,
                                    input  awvalid,
                                    output awready,
                                    input  wvalid,
                                    output wready,
                                    output bvalid,
                                    input  bready
                                   );

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  Axi4LiteSlaveWriteInterface axi4LiteSlaveWriteInterface(.aclk(aclk), 
                                                          .aresetn(aresetn)
                                                         );

  Axi4LiteSlaveWriteDriverBFM axi4LiteSlaveWriteDriverBFM (.aclk(axi4LiteSlaveWriteInterface.aclk),
                                                           .aresetn(axi4LiteSlaveWriteInterface.aresetn),
                                                           .awvalid(axi4LiteSlaveWriteInterface.awvalid),
                                                           .awready(axi4LiteSlaveWriteInterface.awready),
                                                           .wvalid(axi4LiteSlaveWriteInterface.wvalid),
                                                           .wready(axi4LiteSlaveWriteInterface.wready),
                                                           .bvalid(axi4LiteSlaveWriteInterface.bvalid),
                                                           .bready(axi4LiteSlaveWriteInterface.bready)
                                                          );

  Axi4LiteSlaveWriteMonitorBFM axi4LiteSlaveWriteMonitorBFM (.aclk(axi4LiteSlaveWriteInterface.aclk),
                                                             .aresetn(axi4LiteSlaveWriteInterface.aresetn),
                                                             .awvalid(axi4LiteSlaveWriteInterface.awvalid),
                                                             .awready(axi4LiteSlaveWriteInterface.awready),
                                                             .wvalid(axi4LiteSlaveWriteInterface.wvalid),
                                                             .wready(axi4LiteSlaveWriteInterface.wready),
                                                             .bvalid(axi4LiteSlaveWriteInterface.bvalid),
                                                             .bready(axi4LiteSlaveWriteInterface.bready)
                                                            );


  assign axi4LiteSlaveWriteInterface.awvalid = awvalid;
  assign axi4LiteSlaveWriteInterface.wvalid = wvalid;
  assign awready = axi4LiteSlaveWriteInterface.awready;  
  assign wready = axi4LiteSlaveWriteInterface.wready;  
  assign bvalid = axi4LiteSlaveWriteInterface.bvalid;  

  initial begin
    uvm_config_db#(virtual Axi4LiteSlaveWriteDriverBFM)::set(null,"*", "Axi4LiteSlaveWriteDriverBFM", axi4LiteSlaveWriteDriverBFM); 
    uvm_config_db#(virtual Axi4LiteSlaveWriteMonitorBFM)::set(null,"*", "Axi4LiteSlaveWriteMonitorBFM", axi4LiteSlaveWriteMonitorBFM);
  end

  bind axi4LiteSlaveWriteMonitorBFM Axi4LiteSlaveWriteAssertions M_A (.aclk(aclk),
                                                                      .aresetn(aresetn),
                                                                      .awvalid(awvalid),
                                                                      .awready(awready),
                                                                      .wvalid(wvalid),
                                                                      .wready(wready),
                                                                      .bvalid(bvalid),
                                                                      .bready(bready)
                                                                     );
  //-------------------------------------------------------
  // Setting the virtual handle of BMFs into config_db
  //-------------------------------------------------------
  initial begin
    uvm_config_db#(virtual Axi4LiteSlaveWriteDriverBFM)::set(null,"*", "Axi4LiteSlaveWriteDriverBFM", axi4LiteSlaveWriteDriverBFM); 
    uvm_config_db#(virtual Axi4LiteSlaveWriteMonitorBFM)::set(null,"*", "Axi4LiteSlaveWriteMonitorBFM", axi4LiteSlaveWriteMonitorBFM);
  end

  initial begin
    `uvm_info("Axi4LiteSlaveWriteAgentBFM",$sformatf("AXI4LITE SLAVEWRITEAGENTBFM"),UVM_LOW);
  end
   
endmodule : Axi4LiteSlaveWriteAgentBFM
`endif
