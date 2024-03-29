`ifndef AXI4LITESLAVEREADAGENTCONFIG_INCLUDED_
`define AXI4LITESLAVEREADAGENTCONFIG_INCLUDED_

class Axi4LiteSlaveReadAgentConfig extends uvm_object;
  `uvm_object_utils(Axi4LiteSlaveReadAgentConfig)

  uvm_active_passive_enum isActive = UVM_ACTIVE;  
  
  bit hasCoverage;

  bit [DELAY_WIDTH-1:0] maxDelayForReady;
  bit [DELAY_WIDTH:0] maxDelayForValid;

  extern function new(string name = "Axi4LiteSlaveReadAgentConfig");
  extern function void do_print(uvm_printer printer);
endclass : Axi4LiteSlaveReadAgentConfig

function Axi4LiteSlaveReadAgentConfig::new(string name = "Axi4LiteSlaveReadAgentConfig");
  super.new(name); 
endfunction : new

function void Axi4LiteSlaveReadAgentConfig::do_print(uvm_printer printer);
  super.do_print(printer);

  printer.print_string ("isActive",   isActive.name());
  printer.print_field ("hasCoverage", hasCoverage, $bits(hasCoverage), UVM_DEC);
  printer.print_field ("maxDelayForReady", maxDelayForReady, $bits(maxDelayForReady), UVM_DEC);
  printer.print_field ("maxDelayForValid", maxDelayForValid, $bits(maxDelayForValid), UVM_DEC);
endfunction : do_print

`endif

