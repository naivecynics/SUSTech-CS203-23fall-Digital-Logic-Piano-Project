// - PIANO-PROJECT - 
// CONSTANT LIBRARY

// TOP.v
`define FREE 3'b000
`define AUTO 3'b001
`define LERN 3'b010
`define SETT 3'b011
`define IDLE 3'b100

// Button_Debouncer.v
`define DEBOUNCE 100000
//`define DEBOUNCE 1         // for testbench

// seg_light_7.v
`define SCAN_PEROID 250000
//`define SCAN_PEROID 4      // for testbench

    //parameter period=2; //500HZ stable 
    //parameter period=250000;   //400HZ stable
    //parameter period =5000000; //20HZ loop one by one 
    //parameter period=2500000;  //40HZ twenkle
    //parsmeter period =1000000; //100HZ twenkle

// bpm_counter.v
//`define CLK_PERIOD_REAL 10000000 // 0.01ms
//`define CLK_PERIOD_REAL 1000000 // 10ms
`define CLK_PERIOD_REAL 100000 // 500ms
`define VALUE 60000

// keyboard.v
`define SETT_I_USED 8'b0000_0000
`define SETT_I_NOTE 1
`define SETT_I 2'b00
`define SETT_P 2'b01
`define SETT_C 2'b10
`define SETT_FINI 4'b1000