module shift_reg (
    input clk,              // Clock signal
    input rst,              // Reset signal (active high)
    input load,             // Parallel load signal (active high)
    input [3:0] data_in,    // 4-bit parallel data input
    input shift_dir,        // Shift direction (0 = right, 1 = left)
    input serial_in,        // Serial input for shifting
    output [3:0] data_out   // 4-bit output (changed to wire)
);

    // Internal 4-bit register to hold the data
    reg [3:0] shift_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset: Clear the shift register
            shift_reg <= 4'b0000;
        end else if (load) begin
            // Parallel load: Load data_in into the shift register
            shift_reg <= data_in;
        end else begin
            // Shift operation
            case (shift_dir)
                1'b0: begin
                    // Right shift
                    shift_reg <= {serial_in, shift_reg[3:1]};
                end
                1'b1: begin
                    // Left shift
                    shift_reg <= {shift_reg[2:0], serial_in};
                end
            endcase
        end
    end

    // Assign the output
    assign data_out = shift_reg;

endmodule