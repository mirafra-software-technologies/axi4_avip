`ifndef AXI4LITEMASTERWRITEASSERTIONS_INCLUDED_
`define AXI4LITEMASTERWRITEASSERTIONS_INCLUDED_

import Axi4LiteGlobalsPkg::*;

interface Axi4LiteMasterWriteAssertions (input  aclk,
                                         input  aresetn,
                                         input  valid,
                                         input  ready
                                        );  

  import uvm_pkg::*;
  `include "uvm_macros.svh";

  Axi4LiteAssertions axi4LiteAssertions(.aclk(aclk),
                                        .aresetn(aresetn)
                                       );

  initial begin
    `uvm_info("Axi4LiteMasterWriteAssertions","Axi4LiteMasterWriteAssertions",UVM_LOW);
  end

//  AXI4LITE_MASTERWRITE_SIGNALS_CHECK_RESETASSERTED_VALIDISLOW: assert property (axi4LiteAssertions.ifResetAssertedThenValidLow(valid))
//     $info("AXI4LITE_MASTERWRITE_SIGNALS_CHECK_RESETASSERTED_VALIDISLOW : ASSERTION PASS");
//    else  
//     $error("AXI4LITE_MASTERWRITE_SIGNALS_CHECK_RESETASSERTED_VALIDISLOW : ASSERTION FAIL");

//FIXME
//Added @(posedge aclk) Need to Remove and change to other logic
  AXI4LITE_MASTERWRITE_SIGNALS_CHECK_VALIDASSERTED_READYNEEDSTOBEASSERTED_WITHIN16CLK: assert property (@(posedge aclk) axi4LiteAssertions.validAssertedThenReadyNeedsToBeAssertedWithin16Clk(valid,ready))
     $info("AXI4LITE_MASTERWRITE_SIGNALS_CHECK_VALIDASSERTED_READYNEEDSTOBEASSERTED_WITHIN16CLK : ASSERTION PASS");
    else  
     $error("AXI4LITE_MASTERWRITE_SIGNALS_CHECK_VALIDASSERTED_READYNEEDSTOBEASSERTED_WITHIN16CLK : ASSERTION FAIL");

  AXI4LITE_MASTERWRITE_SIGNALS_CHECK_VALIDHIGH_UNITILL_READYASSERTED: assert property (@(posedge aclk) axi4LiteAssertions.validAssertedThenRemainsHighUntillReadyAsserted(valid,ready))
     $info("AXI4LITE_MASTERWRITE_SIGNALS_CHECK_VALIDHIGH_UNITILL_READYASSERTED : ASSERTION PASS");
    else  
     $error("AXI4LITE_MASTERWRITE_SIGNALS_CHECK_VALIDHIGH_UNITILL_READYASSERTED : ASSERTION FAIL");

endinterface : Axi4LiteMasterWriteAssertions

`endif

