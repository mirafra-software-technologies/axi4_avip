`ifndef AXI4LITESLAVEWRITEINTERFACE_INCLUDED_
`define AXI4LITESLAVEWRITEINTERFACE_INCLUDED_

import Axi4LiteGlobalsPkg::*;

interface Axi4LiteSlaveWriteInterface(input aclk, input aresetn);

  //WriteAddressChannelSignals
  logic            awvalid   ;
  logic            awready   ;
  //WriteDataChannelSignals
  logic            wvalid    ;
  logic            wready    ;
  //WriteResponseChannelSignals
  logic            bvalid    ;
  logic            bready    ;


endinterface: Axi4LiteSlaveWriteInterface 

`endif
