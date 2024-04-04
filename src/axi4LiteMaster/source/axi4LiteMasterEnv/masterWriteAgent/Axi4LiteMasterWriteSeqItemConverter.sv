`ifndef AXI4LITEMASTERWRITESEQITEMCONVERTER_INCLUDED_
`define AXI4LITEMASTERWRITESEQITEMCONVERTER_INCLUDED_

class Axi4LiteMasterWriteSeqItemConverter extends uvm_object;
  `uvm_object_utils(Axi4LiteMasterWriteSeqItemConverter)
  
  extern function new(string name = "Axi4LiteMasterWriteSeqItemConverter");
  extern static function void fromWriteClass(input Axi4LiteMasterWriteTransaction input_conv_h,output axi4LiteWriteTransferPacketStruct output_conv_h);
  extern static function void toWriteClass(input axi4LiteWriteTransferPacketStruct input_conv_h, output Axi4LiteMasterWriteTransaction output_conv_h);
  extern function void do_print(uvm_printer printer);
endclass : Axi4LiteMasterWriteSeqItemConverter

function Axi4LiteMasterWriteSeqItemConverter::new(string name = "Axi4LiteMasterWriteSeqItemConverter");
  super.new(name);
endfunction : new


function void Axi4LiteMasterWriteSeqItemConverter::fromWriteClass(input Axi4LiteMasterWriteTransaction input_conv_h, output axi4LiteWriteTransferPacketStruct output_conv_h);
  `uvm_info("axi4_master_seq_item_conv_class",$sformatf("----------------------------------------------------------------------"),UVM_HIGH);

  output_conv_h.writeDelayForBready = input_conv_h.writeDelayForBready;
endfunction : fromWriteClass

function void Axi4LiteMasterWriteSeqItemConverter::toWriteClass(input axi4LiteWriteTransferPacketStruct input_conv_h, output Axi4LiteMasterWriteTransaction output_conv_h);

  `uvm_info("axi4_master_seq_item_conv_class",$sformatf("----------------------------------------------------------------------"),UVM_HIGH);
 
  output_conv_h = new();
  output_conv_h.writeDelayForBready = input_conv_h.writeDelayForBready;
endfunction : toWriteClass


function void Axi4LiteMasterWriteSeqItemConverter::do_print(uvm_printer printer);
  axi4LiteWriteTransferPacketStruct writePacketStruct; 
  super.do_print(printer);
  printer.print_field("writeDelayForBready",writePacketStruct.writeDelayForBready,$bits(writePacketStruct.writeDelayForBready),UVM_HEX);

endfunction : do_print

`endif
