`ifndef AXI4LITEMASTERWRITEASSERTIONS_INCLUDED_
`define AXI4LITEMASTERWRITEASSERTIONS_INCLUDED_

import Axi4LiteGlobalsPkg::*;

interface Axi4LiteMasterWriteAssertions (input  aclk,
                                         input  aresetn,
                                         //Write Address Channel Signals
                                         input  awvalid,
                                         input  awready,
                                         //Write Data Channel Signals
                                         input  wvalid,
                                         input  wready,
                                         //Write Response Channel
                                         input  bvalid,
                                         input  bready
                                        );  

  import uvm_pkg::*;
  `include "uvm_macros.svh";

  Axi4LiteAssertions axi4LiteAssertions(.aclk(aclk),
                                        .aresetn(aresetn)
                                       );

  initial begin
    `uvm_info("Axi4LiteMasterWriteAssertions","Axi4LiteMasterWriteAssertions",UVM_LOW);
  end

//  AXI4LITE_MASTERWRITE_SIGNALS_CHECK_RESETASSERTED_VALIDISLOW: assert property (axi4LiteAssertions.ifResetAssertedThenValidLow(awvalid))
//     $info("AXI4LITE_MASTERWRITE_SIGNALS_CHECK_RESETASSERTED_VALIDISLOW : ASSERTION PASS");
//    else  
//     $error("AXI4LITE_MASTERWRITE_SIGNALS_CHECK_RESETASSERTED_VALIDISLOW : ASSERTION FAIL");

//FIXME
//Added @(posedge aclk) Need to Remove and change to other logic
     AXI4LITE_MASTERWRITE_ADDRESS_SIGNALS_CHECK_AWVALIDASSERTED_AWREADYNEEDSTOBEASSERTED_WITHIN16CLK: assert property (@(posedge aclk) axi4LiteAssertions.validAssertedThenReadyNeedsToBeAssertedWithin16Clk(awvalid,awready))
     $info("AXI4LITE_MASTERWRITE_ADDRESS_SIGNALS_CHECK_AWVALIDASSERTED_AWREADYNEEDSTOBEASSERTED_WITHIN16CLK : ASSERTION PASS");
    else  
     $error("AXI4LITE_MASTERWRITE_ADDRESS_SIGNALS_CHECK_AWVALIDASSERTED_AWREADYNEEDSTOBEASSERTED_WITHIN16CLK : ASSERTION FAIL");
  
     AXI4LITE_MASTERWRITE_ADDRESS_SIGNALS_CHECK_AWVALIDHIGH_UNTILL_AWREADYASSERTED : assert property (@(posedge aclk) axi4LiteAssertions.validAssertedThenRemainsHighUntillReadyAsserted(awvalid,awready))
     $info("AXI4LITE_MASTERWRITE_ADDRESS_SIGNALS_CHECK_AWVALIDHIGH_UNTILL_AWREADYASSERTED : ASSERTION PASS");
    else  
     $error("AXI4LITE_MASTERWRITE_ADDRESS_SIGNALS_CHECK_AWVALIDHIGH_UNTILL_AWREADYASSERTED : ASSERTION FAIL");
     

     AXI4LITE_MASTERWRITE_DATA_SIGNALS_CHECK_WVALIDASSERTED_WREADYNEEDSTOBEASSERTED_WITHIN16CLK: assert property (@(posedge aclk) axi4LiteAssertions.validAssertedThenReadyNeedsToBeAssertedWithin16Clk(wvalid,wready))
     $info("AXI4LITE_MASTERWRITE_DATA_SIGNALS_CHECK_WVALIDASSERTED_WREADYNEEDSTOBEASSERTED_WITHIN16CLK : ASSERTION PASS");
    else  
     $error("AXI4LITE_MASTERWRITE_DATA_SIGNALS_CHECK_WVALIDASSERTED_WREADYNEEDSTOBEASSERTED_WITHIN16CLK : ASSERTION FAIL");
 
     AXI4LITE_MASTERWRITE_DATA_SIGNALS_CHECK_WVALIDHIGH_UNTILL_WREADYASSERTED : assert property (@(posedge aclk) axi4LiteAssertions.validAssertedThenRemainsHighUntillReadyAsserted(wvalid,wready))
     $info("AXI4LITE_MASTERWRITE_DATA_SIGNALS_CHECK_WVALIDHIGH_UNTILL_WREADYASSERTED : ASSERTION PASS");
    else  
     $error("AXI4LITE_MASTERWRITE_DATA_SIGNALS_CHECK_WVALIDHIGH_UNTILL_WREADYASSERTED : ASSERTION FAIL");


/*     AXI4LITE_MASTERWRITE_RESPONSE_SIGNALS_CHECK_BVALIDASSERTED_BREADYNEEDSTOBEASSERTED_WITHIN16CLK: assert property (@(posedge aclk) axi4LiteAssertions.validAssertedThenReadyNeedsToBeAssertedWithin16Clk(bvalid,bready))
     $info("AXI4LITE_MASTERWRITE_RESPONSE_SIGNALS_CHECK_BVALIDASSERTED_BREADYNEEDSTOBEASSERTED_WITHIN16CLK : ASSERTION PASS");
    else  
     $error("AXI4LITE_MASTERWRITE_RESPONSE_SIGNALS_CHECK_BVALIDASSERTED_BREADYNEEDSTOBEASSERTED_WITHIN16CLK : ASSERTION FAIL");
*/
     AXI4LITE_MASTERWRITE_RESPONSE_SIGNALS_CHECK_BVALIDHIGH_UNTILL_BREADYASSERTED : assert property (@(posedge aclk) axi4LiteAssertions.validAssertedThenRemainsHighUntillReadyAsserted(bvalid,bready))
     $info("AXI4LITE_MASTERWRITE_RESPONSE_SIGNALS_CHECK_BVALIDHIGH_UNTILL_BREADYASSERTED : ASSERTION PASS");
    else  
     $error("AXI4LITE_MASTERWRITE_RESPONSE_SIGNALS_CHECK_BVALIDHIGH_UNTILL_BREADYASSERTED : ASSERTION FAIL");

endinterface : Axi4LiteMasterWriteAssertions

`endif

