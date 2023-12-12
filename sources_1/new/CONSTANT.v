// - PIANO-PROJECT - 
// CONSTANT LIBRARY

// P17 : 1 ^ -10 s 
// 100MHz

// BPM_Counter.v
`define CLK_PERIOD_REAL 60'd6_00000_00_0000
`define CLK_PERIOD_TBC 40'd6_00000_00 // #500 clk = ~clk;

// Button_Debouncer.v
`define BUTTON_SLOW 40'd5_00000_0
    // 1 Hz : 5_00000_00
    //10 Hz : 5_00000_0
    //100 Hz: 5_00000_    

