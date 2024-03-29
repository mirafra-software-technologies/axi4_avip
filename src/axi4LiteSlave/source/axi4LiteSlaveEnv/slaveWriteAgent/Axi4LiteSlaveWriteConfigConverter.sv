`ifndef AXI4LITESLAVEWRITECONFIGCONVERTER_INCLUDED_
`define AXI4LITESLAVEWRITECONFIGCONVERTER_INCLUDED_                                                                                             
class Axi4LiteSlaveWriteConfigConverter extends uvm_object;                                                 
`uvm_object_utils(Axi4LiteSlaveWriteConfigConverter)                                                      
                                                                                                     
  extern function new(string name = "Axi4LiteSlaveWriteConfigConverter");                                   
  extern static function void fromClass(input Axi4LiteSlaveWriteAgentConfig input_conv,output axi4LiteWriteTransferConfigStruct output_conv);
  extern function void do_print(uvm_printer printer);  

endclass : Axi4LiteSlaveWriteConfigConverter                                                                
                                                                                                     
function Axi4LiteSlaveWriteConfigConverter::new(string name = "Axi4LiteSlaveWriteConfigConverter");                 
  super.new(name);                                                                                  
endfunction : new                                                                                   

function void Axi4LiteSlaveWriteConfigConverter::fromClass(input Axi4LiteSlaveWriteAgentConfig input_conv,output axi4LiteWriteTransferConfigStruct output_conv);
  input_conv.maxDelayForValid = output_conv.maxDelayForValid;
endfunction: fromClass   

function void Axi4LiteSlaveWriteConfigConverter:: do_print(uvm_printer printer);                            
  axi4LiteWriteTransferConfigStruct configStruct;
   printer.print_field("maxDelayForValid",configStruct.maxDelayForValid,$bits(configStruct.maxDelayForValid),UVM_HEX);
endfunction : do_print                                                                              

`endif
