`ifndef AXI4LITEMASTERINTERFACE_INCLUDED_
`define AXI4LITEMASTERINTERFACE_INCLUDED_

// Import Axi4LiteGlobalsPkg 
import Axi4LiteGlobalsPkg::*;

interface Axi4LiteMasterInterface(input aclk, input aresetn);

  logic awvalid;
  logic	awready;
  logic wvalid;
  logic	wready;
  logic bvalid;
  logic	bready;

  logic arvalid;
  logic	arready;
  logic rvalid;
  logic	rready;

endinterface: Axi4LiteMasterInterface 

`endif
