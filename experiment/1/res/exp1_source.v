module m74LS138
(
    input  I2,
    input  I1,
    input  I0,
    output Y7,
    output Y6,
    output Y5,
    output Y4,
    output Y3,
    output Y2,
    output Y1,
    output Y0
);

assign Y7 =  I0 &  I1 &  I2;
assign Y6 =  I0 &  I1 & ~I2;
assign Y5 =  I0 & ~I1 &  I2;
assign Y4 =  I0 & ~I1 & ~I2;
assign Y3 = ~I0 &  I1 &  I2;
assign Y2 = ~I0 &  I1 & ~I2;
assign Y1 = ~I0 & ~I1 &  I2;
assign Y0 = ~I0 & ~I1 & ~I2;

endmodule

module m74LS161
(
    input       CLK,
    input       CLR_n,
    input       ENP,
    input       ENT,
    input       LD_n,
    input       A3,
    input       A2,
    input       A1,
    input       A0,
    output reg  Q3,
    output reg  Q2,
    output reg  Q1,
    output reg  Q0,
    output      RCO
);

reg RCO_reg;

always @(posedge CLK or negedge CLR_n)
begin
    if (~CLR_n)
    begin
        Q3 <= 1'b0;
        Q2 <= 1'b0;
        Q1 <= 1'b0;
        Q0 <= 1'b0;
        RCO_reg <= 1'b0;
    end
    else if (~LD_n)
    begin
        Q3 <= A3;
        Q2 <= A2;
        Q1 <= A1;
        Q0 <= A0;
        RCO_reg <= 1'b0;
    end
    else if (ENP & ENT)
    begin
        {RCO_reg, Q3, Q2, Q1, Q0} <= {RCO_reg, Q3, Q2, Q1, Q0} + 1'b1;
    end
end

assign RCO = ENT ? RCO_reg : 1'b0;


endmodule

module m74LS194
(
    input       CLK,
    input       CLR_n,
    input       D3,
    input       D2,
    input       D1,
    input       D0,
    input       SR,
    input       SL,
    input       S1,
    input       S0,
    output reg  Q3,
    output reg  Q2,
    output reg  Q1,
    output reg  Q0
);

reg Q3, Q2, Q1, Q0;

always @(posedge CLK or negedge CLR_n)
begin
    if (~CLR_n)
        {Q3, Q2, Q1, Q0} <= 4'b0;
    else if (S1 & S0)
        {Q3, Q2, Q1, Q0} <= {D3, D2, D1, D0};
    else if (S1)
        {Q3, Q2, Q1, Q0} <= {Q2, Q1, Q0, SR};
    else if (S0)
        {Q3, Q2, Q1, Q0} <= {SR, Q3, Q2, Q1};
    else if (S1)
        {Q3, Q2, Q1, Q0} <= {Q2, Q1, Q0, SL};
end

endmodule

module m74ls74
(
    input           PRN1,
    input           D1,
    input           CLRN1,
    input           CLK1,
    input           PRN2,
    input           D2,
    input           CLRN2,
    input           CLK2,
    output reg      Q1,
    output reg      QN1,
    output reg      Q2,
    output reg      QN2
);

always @(posedge CLK1 or negedge PRN1 or negedge CLRN1)
begin
    if (!PRN1)
    begin
        Q1 <= 1'b1;
        QN1 <= 1'b0;
    end
    else if (!CLRN1)
    begin
        Q1 <= 1'b0;
        QN1 <= 1'b1;
    end
    else
    begin
        Q1 <= D1;
        QN1 <= ~D1;
    end
end

always @(posedge CLK2 or negedge PRN2 or negedge CLRN2)
begin
    if (!PRN2)
    begin
        Q2 <= 1'b1;
        QN2 <= 1'b0;
    end
    else if (!CLRN2)
    begin
        Q2 <= 1'b0;
        QN2 <= 1'b1;
    end
    else
    begin
        Q2 <= D2;
        QN2 <= ~D2;
    end
end


endmodule

module m74LS86
(
    input  A1,
    input  B1,
    input  A2,
    input  B2,
    input  A3,
    input  B3,
    input  A4,
    input  B4,
    output Y1,
    output Y2,
    output Y3,
    output Y4
);

assign {Y1, Y2, Y3, Y4} = {A1 ^ B1, A2 ^ B2, A3 ^ B3, A4 ^ B4};

endmodule

module TRI
(
    input  data_in,
    input  ena,
    output data_out
);

assign data_out = ena ? data_in : 1'bz;

endmodule

module adpt_in
(
    input  [31:0]   sw_a,
    input           btn_clk,
    input           btn_rst,
    output          I15,
    output          I14,
    output          I13,
    output          I12,
    output          I11,
    output          I10,
    output          I9,
    output          I8,
    output          I7,
    output          I6,
    output          I5,
    output          I4,
    output          I3,
    output          I2,
    output          I1,
    output          I0,
    output          clk,
    output          clr
);

assign {I15, I14, I13, I12, I11, I10, I9, I8, I7, I6, I5, I4, I3, I2, I1, I0} = ~sw_a[15:0];
assign clk = ~btn_clk;
assign clr = btn_rst;

endmodule
module adpt_out 
(
    input           Y15,
    input           Y14,
    input           Y13,
    input           Y12,
    input           Y11,
    input           Y10,
    input           Y9,
    input           Y8,
    input           Y7,
    input           Y6,  
    input           Y5,
    input           Y4,
    input           Y3,
    input           Y2,
    input           Y1,
    input           Y0,
    output [31:0]   led
);

assign led = ~{16'h0, Y15, Y14, Y13, Y12, Y11, Y10, Y9, Y8, Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0};

endmodule