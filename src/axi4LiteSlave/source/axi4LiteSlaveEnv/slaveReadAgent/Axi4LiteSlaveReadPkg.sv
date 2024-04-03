`ifndef AXI4LITESLAVEREADPKG_INCLUDED_
`define AXI4LITESLAVEREADPKG_INCLUDED_

package Axi4LiteSlaveReadPkg;

  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import Axi4LiteGlobalsPkg::*;

  `include "Axi4LiteSlaveReadTransaction.sv"
  `include "Axi4LiteSlaveReadAgentConfig.sv"
  `include "Axi4LiteSlaveReadSeqItemConverter.sv"
  `include "Axi4LiteSlaveReadConfigConverter.sv"
  `include "Axi4LiteSlaveReadSequencer.sv"
  `include "Axi4LiteSlaveReadDriverProxy.sv"
  `include "Axi4LiteSlaveReadMonitorProxy.sv"
  `include "Axi4LiteSlaveReadValidNotYetGeneratedFatalMonitorProxy.sv"
  `include "Axi4LiteSlaveReadCoverage.sv"
  `include "Axi4LiteSlaveReadAgent.sv"
  
endpackage : Axi4LiteSlaveReadPkg

`endif
