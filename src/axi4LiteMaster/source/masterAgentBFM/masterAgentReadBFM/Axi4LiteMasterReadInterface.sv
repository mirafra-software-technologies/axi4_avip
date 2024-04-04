`ifndef AXI4LITEMASTERREADINTERFACE_INCLUDED_
`define AXI4LITEMASTERREADINTERFACE_INCLUDED_

import Axi4LiteGlobalsPkg::*;

interface Axi4LiteMasterReadInterface(input aclk, input aresetn);

  logic arvalid;
 	logic	arready;
  logic rvalid;
 	logic	rready;

endinterface: Axi4LiteMasterReadInterface 

`endif
