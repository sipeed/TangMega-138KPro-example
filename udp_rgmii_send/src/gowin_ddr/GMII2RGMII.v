//
//Written by GowinSynthesis
//Product Version "V1.9.9 Beta-5"
//Wed Oct 11 22:34:31 2023

//Source file index table:
//file0 "\D:/Gowin/Gowin_V1.9.9Beta-5/IDE/ipcore/DDR/data/ddr_138k.v"
`timescale 100 ps/100 ps
module GMII2RGMII (
  din,
  clk,
  q
)
;
input [7:0] din;
input clk;
output [3:0] q;
wire \oddr_gen[0].oddr_inst_1_Q1 ;
wire \oddr_gen[1].oddr_inst_1_Q1 ;
wire \oddr_gen[2].oddr_inst_1_Q1 ;
wire \oddr_gen[3].oddr_inst_1_Q1 ;
wire VCC;
wire GND;
  ODDR \oddr_gen[0].oddr_inst  (
    .Q0(q[0]),
    .Q1(\oddr_gen[0].oddr_inst_1_Q1 ),
    .D0(din[0]),
    .D1(din[4]),
    .TX(GND),
    .CLK(clk) 
);
  ODDR \oddr_gen[1].oddr_inst  (
    .Q0(q[1]),
    .Q1(\oddr_gen[1].oddr_inst_1_Q1 ),
    .D0(din[1]),
    .D1(din[5]),
    .TX(GND),
    .CLK(clk) 
);
  ODDR \oddr_gen[2].oddr_inst  (
    .Q0(q[2]),
    .Q1(\oddr_gen[2].oddr_inst_1_Q1 ),
    .D0(din[2]),
    .D1(din[6]),
    .TX(GND),
    .CLK(clk) 
);
  ODDR \oddr_gen[3].oddr_inst  (
    .Q0(q[3]),
    .Q1(\oddr_gen[3].oddr_inst_1_Q1 ),
    .D0(din[3]),
    .D1(din[7]),
    .TX(GND),
    .CLK(clk) 
);
  VCC VCC_cZ (
    .V(VCC)
);
  GND GND_cZ (
    .G(GND)
);
  GSR GSR (
    .GSRI(VCC) 
);
endmodule /* GMII2RGMII */
