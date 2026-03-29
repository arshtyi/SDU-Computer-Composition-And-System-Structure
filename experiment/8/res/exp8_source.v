module adpt_in
(
    input  [31:0]   sw_a,
    output          A7,
    output          A6,
    output          A5,
    output          A4,
    output          A3,
    output          A2,
    output          A1,
    output          A0,
    output          B7,
    output          B6,
    output          B5,
    output          B4,
    output          B3,
    output          B2,
    output          B1,
    output          B0
);

assign {A7,A6,A5,A4,A3,A2,A1,A0} = ~sw_a[15:8];
assign {B7,B6,B5,B4,B3,B2,B1,B0} = ~sw_a[7:0];

endmodule

module adpt_out
(
    input           S7,
    input           S6,
    input           S5,
    input           S4,
    input           S3,
    input           S2,
    input           S1,
    input           S0,
    output [31:0]   led
);

assign led = ~{24'h0, S7, S6, S5, S4, S3, S2, S1, S0};

endmodule


module and2
(
    input   a,
    input   b,
    output  y
);

assign y = a & b;

endmodule

module FA (
    input  wire A,     //     A
    input  wire B,     //     B
    input  wire Cin,   //   λ    
    output wire Sum,   //   
    output wire Cout   //   λ   
);

    // Sum = A    B    Cin
    assign Sum = A ^ B ^ Cin;

    // Cout = A  B + (A    B)  Cin
    assign Cout = (A & B) | ((A ^ B) & Cin);

endmodule
module adder8
(
    input  A7,
    input  A6,
    input  A5,
    input  A4,
    input  A3,
    input  A2,
    input  A1,
    input  A0,
    input  B7,
    input  B6,
    input  B5,
    input  B4,   
    input  B3,
    input  B2,
    input  B1,
    input  B0,
    input  C0,
    output S7,
    output S6,
    output S5,
    output S4,
    output S3,
    output S2,
    output S1,
    output S0,
    output C7

);

wire [7:0] S_out;
wire [7:0] A_in;
wire [7:0] B_in;

assign A_in = {A7, A6, A5, A4, A3, A2, A1, A0};
assign B_in = {B7, B6, B5, B4, B3, B2, B1, B0};
assign {C7, S_out } = A_in + B_in + C0;
assign {S7, S6, S5, S4, S3, S2, S1, S0} = S_out;

endmodule

