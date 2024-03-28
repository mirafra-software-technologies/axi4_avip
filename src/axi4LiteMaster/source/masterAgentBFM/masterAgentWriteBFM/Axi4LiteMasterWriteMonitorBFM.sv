`ifndef AXI4LITEMASTERWRITEMONITORBFM_INCLUDED_
`define AXI4LITEMASTERWRITEMONITORBFM_INCLUDED_

import Axi4LiteGlobalsPkg::*;

interface Axi4LiteMasterWriteMonitorBFM(input bit aclk, 
                                        input bit aresetn,
                                        input  valid,
                                        input  ready
                                      );  

  import uvm_pkg::*;
  `include "uvm_macros.svh" 
  
  import Axi4LiteMasterWritePkg::Axi4LiteMasterWriteMonitorProxy;  
 
  Axi4LiteMasterWriteMonitorProxy axi4LiteMasterWriteMonitorProxy;
  
  task wait_for_aresetn();
    @(negedge aresetn);
    `uvm_info("FROM MASTER MON BFM",$sformatf("SYSTEM RESET DETECTED"),UVM_HIGH) 
    @(posedge aresetn);
    `uvm_info("FROM MASTER MON BFM",$sformatf("SYSTEM RESET DEACTIVATED"),UVM_HIGH)
  endtask : wait_for_aresetn


endinterface : Axi4LiteMasterWriteMonitorBFM

`endif
