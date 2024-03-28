`ifndef AXI4LITEASSERTIONS_INCLUDED_
`define AXI4LITEASSERTIONS_INCLUDED_

interface Axi4LiteAssertions (input aclk,
                              input aresetn
                             );  

  import uvm_pkg::*;
  `include "uvm_macros.svh";

  initial begin
    `uvm_info("Axi4LiteAssertions","Axi4LiteAssertions",UVM_LOW);
  end

  property ifResetAssertedThenValidLow(logic valid);
    @(negedge aresetn) disable iff (aresetn === 1)
         (valid===0);
  endproperty : ifResetAssertedThenValidLow

  property validAssertedThenRemainsHighUntillReadyAsserted(logic valid, logic ready);
    @(posedge aclk) disable iff (!aresetn)  
    $rose(valid) |-> valid until_with ready;
  endproperty : validAssertedThenRemainsHighUntillReadyAsserted

  property validAssertedThenReadyNeedsToBeAssertedWithin16Clk(logic valid, logic ready);
    @(posedge aclk) disable iff (!aresetn)  
    $rose(valid) |-> ##[0:15] $rose(ready);
  endproperty : validAssertedThenReadyNeedsToBeAssertedWithin16Clk

endinterface : Axi4LiteAssertions

`endif

