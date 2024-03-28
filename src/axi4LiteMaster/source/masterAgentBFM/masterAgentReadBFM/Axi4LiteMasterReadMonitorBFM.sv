`ifndef AXI4LITEMASTERREADMONITORBFM_INCLUDED_
`define AXI4LITEMASTERREADMONITORBFM_INCLUDED_

import Axi4LiteGlobalsPkg::*;
interface Axi4LiteMasterReadMonitorBFM(input bit aclk, 
                                       input bit aresetn,
                                       input  valid,
                                       input  ready 
                                      );  

  import uvm_pkg::*;
  `include "uvm_macros.svh" 
  
  import Axi4LiteMasterReadPkg::Axi4LiteMasterReadMonitorProxy; 
 
  Axi4LiteMasterReadMonitorProxy axi4LiteMasterReadMonitorProxy;
  
  task wait_for_aresetn();
    @(negedge aresetn);
    `uvm_info("axi4LiteMasterReadMonitorProxy",$sformatf("SYSTEM RESET DETECTED"),UVM_HIGH) 
    @(posedge aresetn);
    `uvm_info("FROM MASTER MON BFM",$sformatf("SYSTEM RESET DEACTIVATED"),UVM_HIGH)
  endtask : wait_for_aresetn

endinterface : Axi4LiteMasterReadMonitorBFM

`endif
