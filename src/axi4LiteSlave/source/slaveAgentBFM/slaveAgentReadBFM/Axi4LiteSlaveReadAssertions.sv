`ifndef AXI4LITESLAVEREADASSERTIONS_INCLUDED_
`define AXI4LITESLAVEREADASSERTIONS_INCLUDED_

import Axi4LiteGlobalsPkg::*;

interface Axi4LiteSlaveReadAssertions (input aclk,
                                       input aresetn,
                                       input valid,
                                       input ready
                                      );  

  import uvm_pkg::*;
  `include "uvm_macros.svh";

  Axi4LiteAssertions axi4LiteAssertions(.aclk(aclk),
                                        .aresetn(aresetn)
                                       );

  initial begin
    `uvm_info("Axi4LiteSlaveReadAssertions","Axi4LiteSlaveReadAssertions",UVM_LOW);
  end

//  AXI4LITE_SLAVEREAD_SIGNALS_CHECK_RESETASSERTED_VALIDISLOW: assert property (axi4LiteAssertions.ifResetAssertedThenValidLow(valid))
//     $info("AXI4LITE_SLAVEREAD_SIGNALS_CHECK_RESETASSERTED_VALIDISLOW : ASSERTION PASS");
//    else  
//     $error("AXI4LITE_SLAVEREAD_SIGNALS_CHECK_RESETASSERTED_VALIDISLOW : ASSERTION FAIL");

  AXI4LITE_SLAVEREAD_SIGNALS_CHECK_VALIDHIGH_UNITILL_READYASSERTED: assert property (axi4LiteAssertions.validAssertedThenRemainsHighUntillReadyAsserted(valid,ready))
     $info("AXI4LITE_SLAVEREAD_SIGNALS_CHECK_VALIDHIGH_UNITILL_READYASSERTED : ASSERTION PASS");
    else  
     $error("AXI4LITE_SLAVEREAD_SIGNALS_CHECK_VALIDHIGH_UNITILL_READYASSERTED : ASSERTION FAIL");

  AXI4LITE_SLAVEREAD_SIGNALS_CHECK_VALIDASSERTED_READYNEEDSTOBEASSERTED_WITHIN16CLK: assert property (axi4LiteAssertions.validAssertedThenReadyNeedsToBeAssertedWithin16Clk(valid,ready))
     $info("AXI4LITE_SLAVEREAD_SIGNALS_CHECK_VALIDASSERTED_READYNEEDSTOBEASSERTED_WITHIN16CLK : ASSERTION PASS");
    else  
     $error("AXI4LITE_SLAVEREAD_SIGNALS_CHECK_VALIDASSERTED_READYNEEDSTOBEASSERTED_WITHIN16CLK : ASSERTION FAIL");

endinterface : Axi4LiteSlaveReadAssertions

`endif

