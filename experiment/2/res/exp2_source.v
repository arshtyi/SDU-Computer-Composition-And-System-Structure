module adpt_in
(
    input  [31:0]   sw_a,
    output          a,
    output          b,
    output          mode_and,
    output          mode_or,
    output          mode_xor
);

assign {mode_and, mode_or, mode_xor, a, b} = ~sw_a[4:0];

endmodule
module adpt_out 
(
    input           e,
    output [31:0]   led
);

assign led = ~{31'h0, e};

endmodule

module and2
(
    input  a,
    input  b,
    output y
);

assign y = a & b;

endmodule
module and3
(
    input  a,
    input  b,
    input  c,
    output y
);

assign y = a & b & c;

endmodule
module not1
(
    input  a,
    output y
);

assign y = ~a;

endmodule
module or6
(
    input  a,
    input  b,
    input  c,
    input  d,
    input  e,
    input  f,
    output y
);

assign y = a | b | c | d | e | f;  

endmodule