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
    output          B0,
    output          K,
    output          C0
    );

assign {A7,A6,A5,A4,A3,A2,A1,A0} = ~sw_a[17:10];
assign {B7,B6,B5,B4,B3,B2,B1,B0} = ~sw_a[9:2];
assign K                = ~sw_a[0];
assign C0               = ~sw_a[1];

endmodule

module adpt_out
(
    input           SUM7,
    input           SUM6,
    input           SUM5,
    input           SUM4,
    input           SUM3,
    input           SUM2,
    input           SUM1,
    input           SUM0,
    input           OF,
    output [31:0]   led
);

assign led = ~{23'h0, OF, SUM7, SUM6, SUM5, SUM4, SUM3, SUM2, SUM1, SUM0};

endmodule

module xor2
(
    input   a,
    input   b,
    output  y
);

assign y = a ^ b;

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
    input  wire A,     // 本地数据A
    input  wire B,     //本地数据B
    input  wire Cin,   // 低位来的进位
    output wire Sum,   // 本为和
    output wire Cout   // 高位的进位
);

    // Sum = A异或 B异或 Cin
    assign Sum = A ^ B ^ Cin;

    // Cout = AB + (A +B)Cin
    assign Cout = (A & B) | ((A ^ B) & Cin);

endmodule

module LookAheadCarry4 (
    input  wire        C0,    // 低位进位
    input  wire [3:0]  A,    //  4位数据
    input  wire [3:0]  B,   // 4位数据
    output wire [3:0]  C_out    // 4个进位C_out[0] = C1, ..., C_out[3] = C4
);

  wire [3:0] d;
  wire [3:0] t;
 //产生本地进位
     assign d[0]=A[0]&B[0];
     assign d[1]=A[1]&B[1];
     assign d[2]=A[2]&B[2];
     assign d[3]=A[3]&B[3];
 //产生传递条件
     assign t[0]=A[0]|B[0];
     assign t[1]=A[1]|B[1];
     assign t[2]=A[2]|B[2];
     assign t[3]=A[3]|B[3];
 // 产生4位进位
    assign C_out[0] = d[0] | (t[0] & C0);                                // C1
    assign C_out[1] = d[1] | (t[1] & d[0]) | (t[1] & t[0] & C0);         // C2
    assign C_out[2] = d[2] | (t[2] &d[1]) | (t[2] & t[1] & d[0]) | 
                     (t[2] & t[1] & t[0] & C0);                          // C3
    assign C_out[3] = d[3] | (t[3] & d[2]) | (t[3] & t[2] & d[1]) | 
                     (t[3] & t[2] &t[1] & d[0]) | (t[3] & t[2] & t[1] & t[0] & C0); // C4

endmodule