`ifndef AXI4LITEMASTERINTERFACE_INCLUDED_
`define AXI4LITEMASTERINTERFACE_INCLUDED_

// Import Axi4LiteGlobalsPkg 
import Axi4LiteGlobalsPkg::*;

interface Axi4LiteInterface(input aclk, input aresetn);

  //Write_address_channel
  logic awvalid;
  logic	awready;

  //Write_data_channel
  logic wvalid;
 	logic wready;

  //Write Response Channel
  logic bvalid;
  logic bready;
 
  //Read Address Channel
  logic arvalid;
 	logic	arready;

  //Read Data Channel
  logic rvalid;
  logic rready;

endinterface: Axi4LiteInterface 

`endif
