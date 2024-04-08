`ifndef AXI4LITEMASTERREADASSERTIONS_INCLUDED_
`define AXI4LITEMASTERREADASSERTIONS_INCLUDED_

import Axi4LiteGlobalsPkg::*;

interface Axi4LiteMasterReadAssertions (input aclk,
                                        input aresetn,
                                        input arvalid,
                                        input	arready,
                                        input rvalid,
                                        input rready
                                       );  

  import uvm_pkg::*;
  `include "uvm_macros.svh";

  Axi4LiteAssertions axi4LiteAssertions(.aclk(aclk),
                                        .aresetn(aresetn)
                                       );

  initial begin
    `uvm_info("Axi4LiteMasterReadAssertions","Axi4LiteMasterReadAssertions",UVM_LOW);
  end

//  AXI4LITE_MASTERREAD_SIGNALS_CHECK_RESETASSERTED_VALIDISLOW: assert property (axi4LiteAssertions.ifResetAssertedThenValidLow(arvalid))
//     $info("AXI4LITE_MASTERREAD_SIGNALS_CHECK_RESETASSERTED_VALIDISLOW : ASSERTION PASS");
//    else  
//     $error("AXI4LITE_MASTERREAD_SIGNALS_CHECK_RESETASSERTED_VALIDISLOW : ASSERTION FAIL");

//FIXME
//Added @(posedge aclk) Need to Remove and change to other logic

    AXI4LITE_MASTERREAD_ADDRESS_SIGNALS_CHECK_ARVALIDASSERTED_ARREADYNEEDSTOBEASSERTED_WITHIN16CLK: assert property (@(posedge aclk) axi4LiteAssertions.validAssertedThenReadyNeedsToBeAssertedWithin16Clk(arvalid,arready))
    $info("AXI4LITE_MASTERREAD_ADDRESS_SIGNALS_CHECK_ARVALIDASSERTED_ARREADYNEEDSTOBEASSERTED_WITHIN16CLK : ASSERTION PASS");
    else  
    $error("AXI4LITE_MASTERREAD_ADDRESS_SIGNALS_CHECK_ARVALIDASSERTED_ARREADYNEEDSTOBEASSERTED_WITHIN16CLK : ASSERTION FAIL");

    AXI4LITE_MASTERREAD_ADDRESS_SIGNALS_CHECK_ARVALIDHIGH_UNITILL_ARREADYASSERTED: assert property (@(posedge aclk) axi4LiteAssertions.validAssertedThenRemainsHighUntillReadyAsserted(arvalid,arready))
    $info("AXI4LITE_MASTERREAD_ADDRESS_SIGNALS_CHECK_ARVALIDHIGH_UNITILL_ARREADYASSERTED : ASSERTION PASS");
    else  
    $error("AXI4LITE_MASTERREAD_ADDRESS_SIGNALS_CHECK_ARVALIDHIGH_UNITILL_ARREADYASSERTED : ASSERTION FAIL");


    AXI4LITE_MASTERREAD_DATA_SIGNALS_CHECK_RVALIDASSERTED_RREADYNEEDSTOBEASSERTED_WITHIN16CLK: assert property (@(posedge aclk) axi4LiteAssertions.validAssertedThenReadyNeedsToBeAssertedWithin16Clk(rvalid,rready))
    $info("AXI4LITE_MASTERREAD_DATA_SIGNALS_CHECK_RVALIDASSERTED_RREADYNEEDSTOBEASSERTED_WITHIN16CLK : ASSERTION PASS");
    else  
    $error("AXI4LITE_MASTERREAD_DATA_SIGNALS_CHECK_RVALIDASSERTED_RREADYNEEDSTOBEASSERTED_WITHIN16CLK : ASSERTION FAIL");

    AXI4LITE_MASTERREAD_DATA_SIGNALS_CHECK_RVALIDHIGH_UNITILL_RREADYASSERTED: assert property (@(posedge aclk) axi4LiteAssertions.validAssertedThenRemainsHighUntillReadyAsserted(rvalid,rready))
    $info("AXI4LITE_MASTERREAD_DATA_SIGNALS_CHECK_RVALIDHIGH_UNITILL_RREADYASSERTED : ASSERTION PASS");
    else  
    $error("AXI4LITE_MASTERREAD_DATA_SIGNALS_CHECK_RVALIDHIGH_UNITILL_RREADYASSERTED : ASSERTION FAIL");

endinterface : Axi4LiteMasterReadAssertions

`endif

