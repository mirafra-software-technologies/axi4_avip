`ifndef AXI4LITEMASTERWRITEINTERFACE_INCLUDED_
`define AXI4LITEMASTERWRITEINTERFACE_INCLUDED_

import Axi4LiteGlobalsPkg::*;

interface Axi4LiteMasterWriteInterface(input aclk, input aresetn);

  logic  valid;
  logic	 ready;

endinterface: Axi4LiteMasterWriteInterface 

`endif
