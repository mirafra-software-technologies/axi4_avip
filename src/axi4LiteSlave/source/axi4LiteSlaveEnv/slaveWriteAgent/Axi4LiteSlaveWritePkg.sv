`ifndef Axi4LITESLAVEWRITEPKG_INCLUDED_
`define Axi4LITESLAVEWRITEPKG_INCLUDED_

package Axi4LiteSlaveWritePkg;

  `include "uvm_macros.svh"
  import uvm_pkg::*;

  import Axi4LiteGlobalsPkg::*;

  `include "Axi4LiteSlaveWriteTransaction.sv"
  `include "Axi4LiteSlaveWriteAgentConfig.sv"
  `include "Axi4LiteSlaveWriteSeqItemConverter.sv"
  `include "Axi4LiteSlaveWriteConfigConverter.sv"
  `include "Axi4LiteSlaveWriteSequencer.sv"
  `include "Axi4LiteSlaveWriteDriverProxy.sv"
  `include "Axi4LiteSlaveWriteMonitorProxy.sv"
  `include "Axi4LiteSlaveWriteValidNotYetGeneratedFatalMonitorProxy.sv"
  `include "Axi4LiteSlaveWriteCoverage.sv"
  `include "Axi4LiteSlaveWriteAgent.sv"
  
endpackage : Axi4LiteSlaveWritePkg

`endif
