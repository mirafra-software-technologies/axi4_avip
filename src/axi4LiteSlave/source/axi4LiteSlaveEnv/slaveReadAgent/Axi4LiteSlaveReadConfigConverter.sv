`ifndef AXI4LITESLAVEREADCONFIGCONVERTER_INCLUDED_
`define AXI4LITESLAVEREADCONFIGCONVERTER_INCLUDED_                                                                                             
class Axi4LiteSlaveReadConfigConverter extends uvm_object;                                                 
`uvm_object_utils(Axi4LiteSlaveReadConfigConverter)                                                      
                                                                                                     
  extern function new(string name = "Axi4LiteSlaveReadConfigConverter");                                   
  extern static function void fromClass(input Axi4LiteSlaveReadAgentConfig input_conv, output axi4LiteReadTransferConfigStruct output_conv);
  extern function void do_print(uvm_printer printer);  

endclass : Axi4LiteSlaveReadConfigConverter                                                                
                                                                                                     
function Axi4LiteSlaveReadConfigConverter::new(string name = "Axi4LiteSlaveReadConfigConverter");                 
  super.new(name);                                                                                  
endfunction : new                                                                                   

function void Axi4LiteSlaveReadConfigConverter::fromClass(input Axi4LiteSlaveReadAgentConfig input_conv, output axi4LiteReadTransferConfigStruct output_conv);
  output_conv.maxDelayForValid = input_conv.maxDelayForValid;
endfunction: fromClass  
 
 function void Axi4LiteSlaveReadConfigConverter:: do_print(uvm_printer printer);                            
   axi4LiteReadTransferConfigStruct configStruct;
   printer.print_field("maxDelayForValid",configStruct.maxDelayForValid,$bits(configStruct.maxDelayForValid),UVM_HEX);
 endfunction : do_print                                                                              
                                                                                                
`endif
