`ifndef AXI4LITEGLOBALSPKG_INCLUDED
`define AXI4LITEGLOBALSPKG_INCLUDED

package Axi4LiteGlobalsPkg;

  parameter bit MASTER_AGENT_ACTIVE = 1;

  parameter bit SLAVE_AGENT_ACTIVE = 1;

  parameter int NO_OF_MASTERS = 1;

  parameter int NO_OF_SLAVES = 1;

  parameter int ADDRESS_WIDTH = 32;

  parameter int DATA_WIDTH = 32;

  parameter int DELAY_WIDTH = 5;

  parameter int MAX_DELAY_VALUE = 15;

  typedef enum bit {
    BIG_ENDIAN    = 1'b0,
    LITTLE_ENDIAN = 1'b1
  } endianEnum;

  typedef enum bit [2:0] {
    WRITE_NORMAL_SECURE_DATA               = 3'b000,
    WRITE_NORMAL_SECURE_INSTRUCTION        = 3'b001,
    WRITE_NORMAL_NONSECURE_DATA            = 3'b010,
    WRITE_NORMAL_NONSECURE_INSTRUCTION     = 3'b011,
    WRITE_PRIVILEGED_SECURE_DATA           = 3'b100,
    WRITE_PRIVILEGED_SECURE_INSTRUCTION    = 3'b101,
    WRITE_PRIVILEGED_NONSECURE_DATA        = 3'b110,
    WRITE_PRIVILEGED_NONSECURE_INSTRUCTION = 3'b111
  } awprotEnum;

  typedef enum bit [2:0] {
    READ_NORMAL_SECURE_DATA               = 3'b000,
    READ_NORMAL_SECURE_INSTRUCTION        = 3'b001,
    READ_NORMAL_NONSECURE_DATA            = 3'b010,
    READ_NORMAL_NONSECURE_INSTRUCTION     = 3'b011,
    READ_PRIVILEGED_SECURE_DATA           = 3'b100,
    READ_PRIVILEGED_SECURE_INSTRUCTION    = 3'b101,
    READ_PRIVILEGED_NONSECURE_DATA        = 3'b110,
    READ_PRIVILEGED_NONSECURE_INSTRUCTION = 3'b111
  } arprotEnum;


  typedef enum bit [1:0] {
    WRITE_OKAY   = 2'b00,
    WRITE_EXOKAY = 2'b01,
    WRITE_SLVERR = 2'b10,
    WRITE_DECERR = 2'b11
  } brespEnum;

  typedef enum bit [1:0] {
    READ_OKAY   = 2'b00,
    READ_EXOKAY = 2'b01,
    READ_SLVERR = 2'b10,
    READ_DECERR = 2'b11
  } rrespEnum;

  typedef enum bit {
    WRITE = 1,
    READ  = 0
  } transactionTypeEnum;

  typedef enum bit[1:0] {
    BLOCKING_WRITE      = 2'b00, 
    BLOCKING_READ       = 2'b01, 
    NON_BLOCKING_WRITE  = 2'b10, 
    NON_BLOCKING_READ   = 2'b11 
  }transferTypeEnum;

  
  typedef struct {
    bit [DELAY_WIDTH-1:0]   writeDelayForReady;
    bit [DELAY_WIDTH-1:0]   writeDelayForBready;
  } axi4LiteWriteTransferPacketStruct; 

  typedef struct {
    bit [DELAY_WIDTH-1:0]   readDelayForReady;
    bit [DELAY_WIDTH-1:0]   readDelayForRready;
  } axi4LiteReadTransferPacketStruct;

  typedef struct {
    bit [DELAY_WIDTH-1:0] delayForReadyWriteCfgValue;
    bit [DELAY_WIDTH:0]   maxDelayForReady;
    bit [DELAY_WIDTH:0]   maxDelayForValid;
  } axi4LiteWriteTransferConfigStruct;

  typedef struct {
    bit [DELAY_WIDTH-1:0] delayForReadyReadCfgValue;
    bit [DELAY_WIDTH:0]   maxDelayForReady;
    bit [DELAY_WIDTH:0]   maxDelayForValid;
  } axi4LiteReadTransferConfigStruct;

endpackage : Axi4LiteGlobalsPkg
`endif

