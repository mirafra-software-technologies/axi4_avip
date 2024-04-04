`ifndef AXI4LITESLAVEREADINTERFACE_INCLUDED_
`define AXI4LITESLAVEREADINTERFACE_INCLUDED_

import Axi4LiteGlobalsPkg::*;

interface Axi4LiteSlaveReadInterface(input aclk, input aresetn);
 //ReadAddressChannel
  logic arvalid;
  logic arready;

  //ReadDataChannel
  logic rvalid;
  logic rready;

endinterface: Axi4LiteSlaveReadInterface 

`endif
