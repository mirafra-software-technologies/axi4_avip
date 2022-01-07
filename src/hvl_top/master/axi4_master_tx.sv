`ifndef AXI4_MASTER_TX_INCLUDED_
`define AXI4_MASTER_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: axi4_master_tx
// This class holds the data items required to drive the stimulus to dut
// and also holds methods that manipulate those data items.
//--------------------------------------------------------------------------------------------
class axi4_master_tx extends uvm_sequence_item;
  
  `uvm_object_utils(axi4_master_tx)
  
  //-------------------------------------------------------
  // WRITE ADDRESS CHANNEL SIGNALS
  //-------------------------------------------------------
  //Variable : awid
  //Used to send the write address id
  rand awid_e awid;

  //Variable : awaddr
  //Used to send the write address
  rand bit [ADDRESS_WIDTH-1:0] awaddr;

  //Variable : awlen
  //Used to send the write address length
  rand awlen_e awlen;

  //Variable : awsize
  //Used to send the write address size
  rand awsize_e awsize;
  
  //Variable : awburst
  //Used to send the write address burst
  rand awburst_e awburst;

  //Variable : awlock
  //Used to send the write address lock
  rand awlock_e awlock;
  
  //Variable : awcache
  //Used to send the write address cache
  rand awcache_e awcache;

  //Variable : awprot
  //Used to send the write address prot
  rand awprot_e awprot;

  //Variable : awqos
  //Used to send the write address quality of service
  rand bit awqos;

  //Variable : awvalid
  //Used to send the write address valid
  //bit awvalid;
  
  //Variable : awready
  //Used to send the write address ready
  //bit awready;
  
  //-------------------------------------------------------
  // WRITE DATA CHANNEL SIGNALS
  //-------------------------------------------------------
  //Variable : wdata
  //Used to randomise write data
  //varaible[$] gives a unbounded queue
  //variable[$:value] gives a bounded queue to a value of given value 
  rand bit [DATA_WIDTH-1:0] wdata [$:DATA_WIDTH];

  //Variable : wstrb
  //Used to randomise write strobe
  //varaible[$] gives a unbounded queue
  //variable[$:value] gives a bounded queue to a value of given value 
  rand bit [(DATA_WIDTH/8)-1:0] wstrb [$:DATA_WIDTH];

  //Variable : wlast
  //Used to store the write last transfer
  //bit wlast;

  //Variable : wvalid
  //Used to send the write valid
  //bit wvalid;
  
  //Variable : wready
  //Used to send the write ready
  //bit wready;

  //-------------------------------------------------------
  // WRITE RESPONSE CHANNEL SIGNALS
  //-------------------------------------------------------
  //Variable : bid
  //Used to send the response id
  bid_e bid;

  //Variable : bresp
  //Used to capture the write response of the trasnaction
  bresp_e bresp;
  
  //-------------------------------------------------------
  // READ ADDRESS CHANNEL SIGNALS
  //-------------------------------------------------------
  //Variable : arid
  //Used to send the read address id
  rand arid_e arid;

  //Variable : araddr
  //Used to send the read address
  rand bit [ADDRESS_WIDTH-1:0] araddr;

  //Variable : arlen
  //Used to send the read address length
  rand arlen_e arlen;

  //Variable : arsize
  //Used to send the read address size
  rand arsize_e arsize;
  
  //Variable : arburst
  //Used to send the read address burst
  rand arburst_e arburst;

  //Variable : arlock
  //Used to send the read address lock
  rand arlock_e arlock;
  
  //Variable : arcache
  //Used to send the read address cache
  rand arcache_e arcache;

  //Variable : arprot
  //Used to send the read address prot
  rand arprot_e arprot;

  //Variable : arqos
  //Used to send the read address quality of service
  rand bit arqos;

  //Variable : arvalid
  //Used to send the read address valid
  //bit arvalid;

  //Variable : arready
  //Used to send the read address ready
  //bit arready;
   
  //-------------------------------------------------------
  // READ DATA CHANNEL SIGNALS 
  //-------------------------------------------------------
  //Variable : rdata
  //Used to randomise read data
  //varaible[$] gives a unbounded queue
  //variable[$:value] gives a bounded queue to a value of given value 
  rand bit [DATA_WIDTH-1:0] rdata [$:DATA_WIDTH];

  //Variable : rstrb
  //Used to randomise read strobe
  //varaible[$] gives a unbounded queue
  //variable[$:value] gives a bounded queue to a value of given value 
  rand bit [(DATA_WIDTH/8)-1:0] rstrb [$:DATA_WIDTH];

  //Variable : rresp
  //Used to capture the read response of the trasnaction
  rresp_e rresp;

  //Variable : rlast
  //Used to store the read last transfer
  //bit rlast;

  //Variable : rvalid
  //Used to send the read valid
  //bit rvalid;
  
  //Variable : rready
  //Used to send the read ready
  //bit rready;

  //Variable : endian
  //Used to differentiate the type of memory storage
  rand endian_e endian;

  //-------------------------------------------------------
  // WRITE ADDRESS Constraints
  //-------------------------------------------------------
  //Constraint : awburst_c1
  //Restricting write burst to select only FIXED, INCR and WRAP types
  constraint awburst_c1 { awburst != WRITE_RESERVED;
                        }

  //Constraint : awlength_c2
  //Adding constraint for restricting write trasnfers
  constraint awlength_c2 { if(awburst==WRITE_FIXED || WRITE_WRAP)
                              awlen inside {[0:15]};
                           else if(awburst == WRITE_INCR) 
                              awlen inside {[0:255]};
                         }

  //Constraint : awlength_c3
  //Adding constraint for restricting to get multiples of 2 in wrap burst
  constraint awlength_c3 { if(awburst == WRITE_WRAP)
                              awlen + 1 inside {2,4,8,16};
                         }
  
  //Constraint : awlock_c4
  //Adding constraint to select the lock transfer type
  constraint awlock_c4 { soft awlock == WRITE_NORMAL_ACCESS;
                       }

  //-------------------------------------------------------
  // WRITE DATA Constraints
  //-------------------------------------------------------
  //Constraint : wdata_c1
  //Adding constraint to restrict the write data based on awlength
  constraint wdata_c1 { wdata.size() == awlen + 1;
                      } 

  //Constraint : wstrb_c2
  //Adding constraint to restrict the write strobe based on awlength
  constraint wstrb_c2 { wstrb.size() == awlen + 1;
                      }

  //-------------------------------------------------------
  // READ ADDRESS Constraints
  //-------------------------------------------------------
  //Constraint : arburst_c1
  //Restricting read burst to select only FIXED, INCR and WRAP types
  constraint arburst_c1 { arburst != READ_RESERVED;
                        }

  //Constraint : arlength_c2
  //Adding constraint for restricting read trasnfers
  constraint arlength_c2 { if(arburst==READ_FIXED || READ_WRAP)
                            arlen inside {[0:15]};
                           else if(arburst == READ_INCR) 
                            arlen inside {[0:255]};
                         }
  
  //Constraint : arlength_c3
  //Adding constraint for restricting to get multiples of 2 in wrap burst
  constraint arlength_c3 { if(arburst == READ_WRAP)
                            arlen + 1 inside {2,4,8,16};
                         }

  //Constraint : arlock_c9
  //Adding constraint to select the lock transfer type
  constraint arlock_c4 { soft arlock == READ_NORMAL_ACCESS;
                       }

  //-------------------------------------------------------
  // Memory Constraints
  //-------------------------------------------------------
  //Constraint : endian_c1
  //Adding constraint to select the endianess
  constraint endian_c1 { soft endian == LITTLE_ENDIAN;
                       }

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new (string name = "axi4_master_tx");
  extern function void post_randomize();
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);
endclass : axi4_master_tx

//--------------------------------------------------------------------------------------------
// Construct: new
// initializes the class object
//
// Parameters:
// name - axi4_master_tx
//--------------------------------------------------------------------------------------------
function axi4_master_tx::new(string name = "axi4_master_tx");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function : post_randomize
// Selects the address based on the slave selected
//--------------------------------------------------------------------------------------------
function void axi4_master_tx::post_randomize();
  
  ////Variable : index
  ////Used to store the address_range index value
  //int index;

  ////Derive the slave number using the index
  //for(int i=0; i<NO_OF_SLAVES; i++) begin
  //  if(pselx[i]) begin
  //    index = i;
  //  end
  //end
 
  ////Randmoly chosing paddr value between a given range
  //if (!std::randomize(awaddr) with { awaddr inside {[axi4_master_agent_cfg_h.master_min_addr_range_array[index]:axi4_master_agent_cfg_h.master_max_addr_range_array[index]]};
  //  //awaddr %4 == 0;
  //  //wdata.size() == (awlen+1) * (2**awsize)
  //}) begin
  //  `uvm_fatal("FATAL_STD_RANDOMIZATION_AWADDR", $sformatf("Not able to randomize awaddr"));
  //end

  //Used to restrict the address inside the 4kb boundary
  if(!std::randomize(awaddr) with {awaddr % 4096 == 0; 
                                   awaddr inside {[0:4095]};
                                  }) begin
    `uvm_fatal("FATAL_STD_RANDOMIZATION_AWADDR", $sformatf("Not able to randomize AWADDR"));
  end

  //Used to restrict the wdata so that it should not exceed 4kb address boundary
  //if(!std::randomize(wdata) with {(wdata.size()*DATA_WIDTH)/8 == axi4_master_agent_cfg_h[0].master_max_addr_range_array[0] - awaddr;}) begin
  //  `uvm_fatal("FATAL_STD_RANDOMIZATION_WDATA", $sformatf("Not able to randomize WDATA"));
  //end

  //Used to restrict the wdata so that it should not exceed 4kb boundary
  if(!std::randomize(wstrb) with {wstrb.size() == wdata.size();}) begin
    `uvm_fatal("FATAL_STD_RANDOMIZATION_WSTRB", $sformatf("Not able to randomize WSTRB"));
  end

  //Used to make wdata byte non-zero when strobe is high for that byte lane
  for(int i=0; i<DATA_WIDTH/8; i++) begin
    if(wstrb[i]) begin
      //`uvm_info(get_type_name(),$sformatf("MASTER-TX-strb[%0d]=%0d",i,strb[i]),UVM_HIGH);
      if(!std::randomize(wdata) with {wdata[i][8*i+7 -: 8] != 0;}) begin
        `uvm_fatal("FATAL_STD_RANDOMIZATION_WDATA", $sformatf("Not able to randomize wdata"));
      end
      else begin
        `uvm_info(get_type_name(),$sformatf("MASTER-TX-wdata[%0d]=%0h",8*i+7,wdata[i][8*i+7 +: 8]),UVM_HIGH);
      end 
    end
  end
endfunction : post_randomize

//--------------------------------------------------------------------------------------------
// Function : do_copy
// Copies the axi4 slave_tx into the rhs object
//
// Parameters:
// rhs - uvm_object
//--------------------------------------------------------------------------------------------
function void axi4_master_tx::do_copy(uvm_object rhs);
  axi4_master_tx axi4_master_tx_copy_obj;

  if(!$cast(axi4_master_tx_copy_obj,rhs)) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
  end
  super.do_copy(rhs);
  
  //WRITE ADDRESS CHANNEL
  awid    = axi4_master_tx_copy_obj.awid;
  awaddr  = axi4_master_tx_copy_obj.awaddr;
  awlen   = axi4_master_tx_copy_obj.awlen;
  awsize  = axi4_master_tx_copy_obj.awsize;
  awburst = axi4_master_tx_copy_obj.awburst;
  awlock  = axi4_master_tx_copy_obj.awlock;
  awcache = axi4_master_tx_copy_obj.awcache;
  awprot  = axi4_master_tx_copy_obj.awprot;
  awqos   = axi4_master_tx_copy_obj.awqos;
  
  //WRITE DATA CHANNEL
  wdata = axi4_master_tx_copy_obj.wdata;
  wstrb = axi4_master_tx_copy_obj.wstrb;
  
  //WRITE RESPONSE CHANNEL
  bid   = axi4_master_tx_copy_obj.bid;
  bresp = axi4_master_tx_copy_obj.bresp;
  
  //READ ADDRESS CHANNEL
  arid    = axi4_master_tx_copy_obj.arid;
  araddr  = axi4_master_tx_copy_obj.araddr;
  arlen   = axi4_master_tx_copy_obj.arlen;
  arsize  = axi4_master_tx_copy_obj.arsize;
  arburst = axi4_master_tx_copy_obj.arburst;
  arlock  = axi4_master_tx_copy_obj.arlock;
  arcache = axi4_master_tx_copy_obj.arcache;
  arprot  = axi4_master_tx_copy_obj.arprot;
  arqos   = axi4_master_tx_copy_obj.arqos;
  
  //READ DATA CHANNEL
  rdata = axi4_master_tx_copy_obj.rdata;
  rstrb = axi4_master_tx_copy_obj.rstrb;
  rresp = axi4_master_tx_copy_obj.rresp;
endfunction : do_copy

//--------------------------------------------------------------------------------------------
// Function: do_compare
// Compare method is implemented using handle rhs
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function bit axi4_master_tx::do_compare (uvm_object rhs, uvm_comparer comparer);
  axi4_master_tx axi4_master_tx_compare_obj;

  if(!$cast(axi4_master_tx_compare_obj,rhs)) begin
    `uvm_fatal("FATAL_axi_MASTER_TX_DO_COMPARE_FAILED","cast of the rhs object failed")
    return 0;
  end
  
  return super.do_compare(axi4_master_tx_compare_obj, comparer) &&
  //WRITE ADDRESS CHANNEL
  awid    == axi4_master_tx_compare_obj.awid    &&
  awaddr  == axi4_master_tx_compare_obj.awaddr  &&
  awlen   == axi4_master_tx_compare_obj.awlen   &&
  awsize  == axi4_master_tx_compare_obj.awsize  &&
  awburst == axi4_master_tx_compare_obj.awburst &&
  awlock  == axi4_master_tx_compare_obj.awlock  &&
  awcache == axi4_master_tx_compare_obj.awcache &&
  awprot  == axi4_master_tx_compare_obj.awprot  &&
  awqos   == axi4_master_tx_compare_obj.awqos   &&
  
  //WRITE DATA CHANNEL
  wdata == axi4_master_tx_compare_obj.wdata &&
  wstrb == axi4_master_tx_compare_obj.wstrb &&
  
  //WRITE RESPONSE CHANNEL
  bid   == axi4_master_tx_compare_obj.bid   &&
  bresp == axi4_master_tx_compare_obj.bresp &&
  
  //READ ADDRESS CHANNEL
  arid    == axi4_master_tx_compare_obj.arid    &&
  araddr  == axi4_master_tx_compare_obj.araddr  &&
  arlen   == axi4_master_tx_compare_obj.arlen   &&
  arsize  == axi4_master_tx_compare_obj.arsize  &&
  arburst == axi4_master_tx_compare_obj.arburst &&
  arlock  == axi4_master_tx_compare_obj.arlock  &&
  arcache == axi4_master_tx_compare_obj.arcache &&
  arprot  == axi4_master_tx_compare_obj.arprot  &&
  arqos   == axi4_master_tx_compare_obj.arqos   &&

  //READ DATA CHANNEL
  rdata == axi4_master_tx_compare_obj.rdata &&
  rstrb == axi4_master_tx_compare_obj.rstrb &&
  rresp == axi4_master_tx_compare_obj.rresp;
endfunction : do_compare

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//
// Parameters :
// printer  - uvm_printer
//--------------------------------------------------------------------------------------------
function void axi4_master_tx::do_print(uvm_printer printer);
  super.do_print(printer);
  `uvm_info("------------------------------------------WRITE_ADDRESS_CHANNEL","-------------------------------------",UVM_LOW);
  printer.print_string("awid",awid.name());
  printer.print_field("awaddr",awaddr,$bits(awaddr),UVM_HEX);
  printer.print_string("awlen",awlen.name());
  printer.print_string("awsize",awsize.name());
  printer.print_string("awburst",awburst.name());
  printer.print_string("awlock",awlock.name());
  printer.print_string("awcache",awcache.name());
  printer.print_string("awprot",awprot.name());
  printer.print_field("awqos",awqos,$bits(awqos),UVM_HEX);
  `uvm_info("------------------------------------------WRITE_DATA_CHANNEL","----------------------------------------",UVM_LOW);
  //printer.print_field("wdata",wdata,$bits(wdata),UVM_HEX);
  //printer.print_field("wstrb",wstrb,$bits(wstrb),UVM_HEX);
  `uvm_info("------------------------------------------WRITE_RESPONSE_CHANNEL","------------------------------------",UVM_LOW);
  printer.print_string("bid",bid.name());
  printer.print_string("bresp",bresp.name());
  `uvm_info("------------------------------------------READ_ADDRESS_CHANNEL","--------------------------------------",UVM_LOW);
  printer.print_string("arid",arid.name());
  printer.print_field("araddr",araddr,$bits(araddr),UVM_HEX);
  printer.print_string("arlen",arlen.name());
  printer.print_string("arsize",arsize.name());
  printer.print_string("arburst",arburst.name());
  printer.print_string("arlock",arlock.name());
  printer.print_string("arcache",arcache.name());
  printer.print_string("arprot",arprot.name());
  printer.print_field("arqos",arqos,$bits(arqos),UVM_HEX);
  `uvm_info("------------------------------------------READ_DATA_CHANNEL","----------------------------------------",UVM_LOW);
  //printer.print_field("rdata",rdata,$bits(rdata),UVM_HEX);
  //printer.print_field("rstrb",rstrb,$bits(rstrb),UVM_HEX);
  printer.print_string("rresp",rresp.name());
endfunction : do_print

`endif

