/* somador de um bit */
module half_adder (
    input wire cin,
    input wire a,
    input wire b,
    output wire sum,
    output wire cout
);

    assign sum = cin ^ (a ^ b);
    assign cout = b & (cin ^ a) | cin & a;

endmodule //half_adder