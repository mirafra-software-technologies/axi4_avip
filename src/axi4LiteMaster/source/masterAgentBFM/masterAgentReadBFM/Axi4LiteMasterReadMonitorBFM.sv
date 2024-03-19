`ifndef AXI4LITEMASTERREADMONITORBFM_INCLUDED_
`define AXI4LITEMASTERREADMONITORBFM_INCLUDED_

//--------------------------------------------------------------------------------------------
//Interface : Axi4LiteMasterReadMonitorBFM
//Used as the HDL monitor for axi4
//It connects with the HVL monitor_proxy for driving the stimulus
//--------------------------------------------------------------------------------------------
import Axi4LiteGlobalsPkg::*;
interface Axi4LiteMasterReadMonitorBFM(input bit aclk, input bit aresetn,
                                       //Read Address Channel Signals
                                       input  [ADDRESS_WIDTH-1: 0]araddr,
                                       input  [2:0]arprot,
                                       input  arvalid,
                                       input  arready, 
                                       //Read Data Channel Signals
                                       input  [DATA_WIDTH-1: 0]rdata,
                                       input  [1:0]rresp,
                                       input  rvalid,
                                       input  rready  
                                      );  

  //-------------------------------------------------------
  // Importing UVM Package 
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh" 
  
  import Axi4LiteMasterReadPkg::Axi4LiteMasterReadMonitorProxy; 
 
  //Variable : Axi4LiteMasterReadMonitorProxy
  //Creating the handle for proxy monitor
 
  Axi4LiteMasterReadMonitorProxy axi4LiteMasterReadMonitorProxy;
  
  //-------------------------------------------------------
  // Task: wait_for_aresetn
  // Waiting for the system reset to be active low
  //-------------------------------------------------------
  task wait_for_aresetn();
    @(negedge aresetn);
    `uvm_info("axi4LiteMasterReadMonitorProxy",$sformatf("SYSTEM RESET DETECTED"),UVM_HIGH) 
    @(posedge aresetn);
    `uvm_info("FROM MASTER MON BFM",$sformatf("SYSTEM RESET DEACTIVATED"),UVM_HIGH)
  endtask : wait_for_aresetn

endinterface : Axi4LiteMasterReadMonitorBFM

`endif
