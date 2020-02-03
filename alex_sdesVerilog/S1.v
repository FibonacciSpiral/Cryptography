/*
    This is the second of the two substitution box (S-Box) functions
    used in the Fk module. S-Box for each S function is a specific
    mapping, using the outer two bits on input as the row value and 
    the inner two bits as a column value. Output is the resulting 
    2-bit number.

    Example:
        input  = 0001
        row    = 0__1 = 1
        col    = _00_ = 0
        output => (1, 0) => 2'b10 => 2

    Specific S1-Box values can be seen below.
*/
module S1 (

    input [0:3] rightSide,  // Right four bits from previous XOR step
    output [0:1] sBoxOut    // Output from S-Box

);
    // Using a case statement for the hypothetical mux, this allows accurate
    // mapping of the S-Box.

    /*
    S1-Box: outer two bits specify row, inner two bits specify column

        0 1 2 3
       ---------
    0 | 0 1 2 3 |
    1 | 2 0 1 3 |
    2 | 3 0 1 0 |
    3 | 2 1 0 3 |
       ---------
    */

    case(rightSide)                          // (row, col)
        4'b0000 : assign sBoxOut = 2'b00;   // (0, 0)
        4'b0001 : assign sBoxOut = 2'b10;   // (1, 0)
        4'b0010 : assign sBoxOut = 2'b01;   // (0, 1)
        4'b0011 : assign sBoxOut = 2'b00;   // (1, 1)
        4'b0100 : assign sBoxOut = 2'b10;   // (0, 2)
        4'b0101 : assign sBoxOut = 2'b01;   // (1, 2)
        4'b0110 : assign sBoxOut = 2'b11;   // (0, 3)
        4'b0111 : assign sBoxOut = 2'b11;   // (1, 3)
        4'b1000 : assign sBoxOut = 2'b11;   // (2, 0)
        4'b1001 : assign sBoxOut = 2'b10;   // (3, 0)
        4'b1010 : assign sBoxOut = 2'b00;   // (2, 1)
        4'b1011 : assign sBoxOut = 2'b01;   // (3, 1)
        4'b1100 : assign sBoxOut = 2'b01;   // (2, 2)
        4'b1101 : assign sBoxOut = 2'b00;   // (3, 2)
        4'b1110 : assign sBoxOut = 2'b00;   // (2, 3)
        4'b1111 : assign sBoxOut = 2'b11;   // (3, 3)
    endcase

endmodule;