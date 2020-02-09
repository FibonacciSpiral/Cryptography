/*
    This is the first of the two substitution box (S-Box) functions
    used in the Fk module. S-Box for each S function is a specific
    mapping, using the outer two bits on input as the row value and 
    the inner two bits as a column value. Output is the resulting 
    2-bit number.

    Endian-ness matters in this situation because the coordinates
    and output are all read as 2-bit numbers.

    Example:
        input  = 0100
        row    = 0__0 = 0
        col    = _10_ = 2
        output => (0, 2) => 2'b11 => 3

    Specific S0-Box values can be seen below.
*/
module S0 (

    input [3:0] leftSide,   // Left four bits from previous XOR step
    output reg [1:0] sBoxOut    // Output from S-Box

);
    // Using a case statement for the hypothetical mux, this allows accurate
    // mapping of the S-Box.

    /*
    S0-Box: outer two bits specify row, inner two bits specify column

        0 1 2 3
       ---------
    0 | 1 0 3 2 |
    1 | 3 2 1 0 |
    2 | 0 2 1 3 |
    3 | 3 1 3 2 |
       ---------
    */

always@(*) begin
    case(leftSide)                          // (row, col)
        4'b0000 : sBoxOut = 2'b01;   // (0, 0)
        4'b0001 : sBoxOut = 2'b11;   // (1, 0)
        4'b0010 : sBoxOut = 2'b00;   // (0, 1)
        4'b0011 : sBoxOut = 2'b10;   // (1, 1)
        4'b0100 : sBoxOut = 2'b11;   // (0, 2)
        4'b0101 : sBoxOut = 2'b01;   // (1, 2)
        4'b0110 : sBoxOut = 2'b10;   // (0, 3)
        4'b0111 : sBoxOut = 2'b00;   // (1, 3)
        4'b1000 : sBoxOut = 2'b00;   // (2, 0)
        4'b1001 : sBoxOut = 2'b11;   // (3, 0)
        4'b1010 : sBoxOut = 2'b10;   // (2, 1)
        4'b1011 : sBoxOut = 2'b01;   // (3, 1)
        4'b1100 : sBoxOut = 2'b01;   // (2, 2)
        4'b1101 : sBoxOut = 2'b11;   // (3, 2)
        4'b1110 : sBoxOut = 2'b11;   // (2, 3)
        4'b1111 : sBoxOut = 2'b10;   // (3, 3)
		  default : sBoxOut = 2'b00;
    endcase
    end

endmodule