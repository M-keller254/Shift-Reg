`timescale 1ns / 1ps
`include "shift_reg.v"

module shift_reg_tb;

    // Inputs
    reg clk;
    reg rst;
    reg load;
    reg [3:0] data_in;
    reg shift_dir;
    reg serial_in;

    // Outputs
    wire [3:0] data_out;

    // Instantiate the shift_reg module
    shift_reg uut (
        .clk(clk),
        .rst(rst),
        .load(load),
        .data_in(data_in),
        .shift_dir(shift_dir),
        .serial_in(serial_in),
        .data_out(data_out)
    );

    // Clock generation
    always #5 clk = ~clk; // Toggle clock every 5 time units

    // VCD file dumping
    initial begin
        // Create a VCD file for waveform dumping
        $dumpfile("shift_reg_waveform.vcd"); // Name of the VCD file
        $dumpvars(0, shift_reg_tb); // Dump all signals in the testbench
    end

    // Testbench logic
    initial begin
        // Initialize inputs
        clk = 0;
        rst = 0;
        load = 0;
        data_in = 4'b0000;
        shift_dir = 0;
        serial_in = 0;

        //Reset the shift register
        rst = 1;
        #10;  
        rst = 0;
        #10;  

        //  Parallel load
        data_in = 4'b1101; // Load 1101
        load = 1;
        #10;  
        load = 0;
        #10;  

        // Right shift
        shift_dir = 0; // Set shift direction to right
        serial_in = 1; // Insert 1 into the leftmost bit
        #10;  
        serial_in = 0; // Insert 0 into the leftmost bit
        #10;  

        // Left shift
        shift_dir = 1; // Set shift direction to left
        serial_in = 1; // Insert 1 into the rightmost bit
        #10;  
        serial_in = 0; // Insert 0 into the rightmost bit
        #10;  

        // End simulation
        $stop;
    end

endmodule