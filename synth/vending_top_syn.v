/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : X-2025.06-SP2
// Date      : Wed Jul  8 22:33:38 2026
/////////////////////////////////////////////////////////////


module control_unit ( clk, rst, coin_in, confirm, cancel, can_sell, 
        credit_load, clear, mem_write, sel_change, load_change, dispense, 
        error_out, state_out );
  input [1:0] coin_in;
  output [2:0] state_out;
  input clk, rst, confirm, cancel, can_sell;
  output credit_load, clear, mem_write, sel_change, load_change, dispense,
         error_out;
  wire   mem_write, sel_change, n16, n19, n20, n21, n1, n2, n3, n4, n5, n6, n7,
         n8, n9, n10, n11, n12, n13, n14, n15, n17;
  assign dispense = mem_write;
  assign error_out = sel_change;

  DFFARX1_RVT \current_state_reg[0]  ( .D(n21), .CLK(clk), .RSTB(n16), .Q(
        state_out[0]), .QN(n17) );
  DFFARX1_RVT \current_state_reg[2]  ( .D(n19), .CLK(clk), .RSTB(n16), .Q(
        state_out[2]), .QN(n15) );
  DFFARX1_RVT \current_state_reg[1]  ( .D(n20), .CLK(clk), .RSTB(n16), .Q(
        state_out[1]), .QN(n14) );
  AND3X1_RVT U3 ( .A1(state_out[2]), .A2(state_out[0]), .A3(n14), .Y(
        sel_change) );
  INVX0_RVT U4 ( .A(rst), .Y(n16) );
  AND3X1_RVT U5 ( .A1(state_out[1]), .A2(state_out[0]), .A3(n15), .Y(mem_write) );
  OR2X1_RVT U6 ( .A1(sel_change), .A2(mem_write), .Y(load_change) );
  INVX0_RVT U7 ( .A(load_change), .Y(n4) );
  OR3X1_RVT U8 ( .A1(state_out[2]), .A2(can_sell), .A3(n14), .Y(n3) );
  AND2X1_RVT U9 ( .A1(state_out[0]), .A2(n15), .Y(n1) );
  NAND2X0_RVT U10 ( .A1(n1), .A2(cancel), .Y(n2) );
  NAND3X0_RVT U11 ( .A1(n4), .A2(n3), .A3(n2), .Y(n19) );
  AND2X1_RVT U12 ( .A1(n15), .A2(n14), .Y(n6) );
  OR2X1_RVT U13 ( .A1(coin_in[1]), .A2(coin_in[0]), .Y(n5) );
  AND2X1_RVT U14 ( .A1(n6), .A2(n5), .Y(credit_load) );
  AND3X1_RVT U15 ( .A1(state_out[2]), .A2(n14), .A3(n17), .Y(clear) );
  INVX0_RVT U16 ( .A(cancel), .Y(n9) );
  NAND2X0_RVT U17 ( .A1(confirm), .A2(n9), .Y(n8) );
  AND3X1_RVT U18 ( .A1(state_out[0]), .A2(n14), .A3(n15), .Y(n10) );
  OR3X1_RVT U19 ( .A1(state_out[1]), .A2(coin_in[0]), .A3(coin_in[1]), .Y(n7)
         );
  AND2X1_RVT U20 ( .A1(n15), .A2(n17), .Y(n11) );
  AO222X1_RVT U21 ( .A1(n8), .A2(n10), .A3(n7), .A4(n11), .A5(n9), .A6(
        sel_change), .Y(n21) );
  NAND3X0_RVT U22 ( .A1(confirm), .A2(n10), .A3(n9), .Y(n13) );
  NAND3X0_RVT U23 ( .A1(n11), .A2(can_sell), .A3(state_out[1]), .Y(n12) );
  NAND2X0_RVT U24 ( .A1(n13), .A2(n12), .Y(n20) );
endmodule


module credit_reg ( clk, rst, clear, credit_load, coin_value, credit );
  input [7:0] coin_value;
  output [7:0] credit;
  input clk, rst, clear, credit_load;
  wire   n4, n5, n6, n7, n8, n9, n10, n11, n12, n2, n3, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50;

  DFFARX1_RVT \credit_reg[7]  ( .D(n5), .CLK(clk), .RSTB(n4), .Q(credit[7]) );
  DFFARX1_RVT \credit_reg[6]  ( .D(n6), .CLK(clk), .RSTB(n4), .Q(credit[6]), 
        .QN(n50) );
  DFFARX1_RVT \credit_reg[5]  ( .D(n7), .CLK(clk), .RSTB(n4), .Q(credit[5]) );
  DFFARX1_RVT \credit_reg[4]  ( .D(n8), .CLK(clk), .RSTB(n4), .Q(credit[4]) );
  DFFARX1_RVT \credit_reg[3]  ( .D(n9), .CLK(clk), .RSTB(n4), .Q(credit[3]) );
  DFFARX1_RVT \credit_reg[2]  ( .D(n10), .CLK(clk), .RSTB(n4), .Q(credit[2])
         );
  DFFARX1_RVT \credit_reg[1]  ( .D(n11), .CLK(clk), .RSTB(n4), .Q(credit[1])
         );
  DFFARX1_RVT \credit_reg[0]  ( .D(n12), .CLK(clk), .RSTB(n4), .Q(credit[0]), 
        .QN(n49) );
  INVX2_RVT U3 ( .A(rst), .Y(n4) );
  AND2X1_RVT U4 ( .A1(n2), .A2(n3), .Y(n46) );
  AND2X1_RVT U5 ( .A1(credit_load), .A2(n45), .Y(n2) );
  NAND2X0_RVT U6 ( .A1(n44), .A2(n50), .Y(n3) );
  NAND2X0_RVT U7 ( .A1(coin_value[3]), .A2(credit_load), .Y(n13) );
  INVX0_RVT U8 ( .A(n13), .Y(n14) );
  INVX0_RVT U9 ( .A(clear), .Y(n48) );
  OA221X1_RVT U10 ( .A1(credit[0]), .A2(n14), .A3(n49), .A4(n13), .A5(n48), 
        .Y(n12) );
  NAND3X0_RVT U11 ( .A1(coin_value[3]), .A2(credit[0]), .A3(coin_value[1]), 
        .Y(n15) );
  AND2X1_RVT U12 ( .A1(n15), .A2(credit_load), .Y(n17) );
  AND2X1_RVT U13 ( .A1(coin_value[3]), .A2(credit[0]), .Y(n20) );
  OR2X1_RVT U14 ( .A1(coin_value[1]), .A2(n20), .Y(n16) );
  AND2X1_RVT U15 ( .A1(n17), .A2(n16), .Y(n18) );
  HADDX1_RVT U16 ( .A0(credit[1]), .B0(n18), .SO(n19) );
  AND2X1_RVT U17 ( .A1(n48), .A2(n19), .Y(n11) );
  AO222X1_RVT U18 ( .A1(n20), .A2(coin_value[1]), .A3(n20), .A4(credit[1]), 
        .A5(coin_value[1]), .A6(credit[1]), .Y(n25) );
  INVX0_RVT U19 ( .A(coin_value[6]), .Y(n22) );
  INVX0_RVT U20 ( .A(n25), .Y(n21) );
  OA221X1_RVT U21 ( .A1(coin_value[6]), .A2(n25), .A3(n22), .A4(n21), .A5(
        credit_load), .Y(n23) );
  HADDX1_RVT U22 ( .A0(credit[2]), .B0(n23), .SO(n24) );
  AND2X1_RVT U23 ( .A1(n48), .A2(n24), .Y(n10) );
  AO222X1_RVT U24 ( .A1(coin_value[6]), .A2(credit[2]), .A3(coin_value[6]), 
        .A4(n25), .A5(credit[2]), .A6(n25), .Y(n30) );
  INVX0_RVT U25 ( .A(coin_value[3]), .Y(n27) );
  INVX0_RVT U26 ( .A(n30), .Y(n26) );
  OA221X1_RVT U27 ( .A1(coin_value[3]), .A2(n30), .A3(n27), .A4(n26), .A5(
        credit_load), .Y(n28) );
  HADDX1_RVT U28 ( .A0(credit[3]), .B0(n28), .SO(n29) );
  AND2X1_RVT U29 ( .A1(n48), .A2(n29), .Y(n9) );
  AO222X1_RVT U30 ( .A1(coin_value[3]), .A2(credit[3]), .A3(coin_value[3]), 
        .A4(n30), .A5(credit[3]), .A6(n30), .Y(n35) );
  INVX0_RVT U31 ( .A(n35), .Y(n32) );
  INVX0_RVT U32 ( .A(coin_value[4]), .Y(n31) );
  OA221X1_RVT U33 ( .A1(n32), .A2(n31), .A3(n35), .A4(coin_value[4]), .A5(
        credit_load), .Y(n33) );
  HADDX1_RVT U34 ( .A0(credit[4]), .B0(n33), .SO(n34) );
  AND2X1_RVT U35 ( .A1(n48), .A2(n34), .Y(n8) );
  AO222X1_RVT U36 ( .A1(coin_value[4]), .A2(credit[4]), .A3(coin_value[4]), 
        .A4(n35), .A5(credit[4]), .A6(n35), .Y(n40) );
  INVX0_RVT U37 ( .A(n40), .Y(n37) );
  INVX0_RVT U38 ( .A(coin_value[5]), .Y(n36) );
  OA221X1_RVT U39 ( .A1(n37), .A2(n36), .A3(n40), .A4(coin_value[5]), .A5(
        credit_load), .Y(n38) );
  HADDX1_RVT U40 ( .A0(credit[5]), .B0(n38), .SO(n39) );
  AND2X1_RVT U41 ( .A1(n48), .A2(n39), .Y(n7) );
  AO222X1_RVT U42 ( .A1(coin_value[5]), .A2(credit[5]), .A3(coin_value[5]), 
        .A4(n40), .A5(credit[5]), .A6(n40), .Y(n41) );
  OR2X1_RVT U43 ( .A1(coin_value[6]), .A2(n41), .Y(n45) );
  NAND2X0_RVT U44 ( .A1(coin_value[6]), .A2(n41), .Y(n44) );
  NAND3X0_RVT U45 ( .A1(credit_load), .A2(n45), .A3(n44), .Y(n42) );
  INVX0_RVT U46 ( .A(n42), .Y(n43) );
  OA221X1_RVT U47 ( .A1(credit[6]), .A2(n43), .A3(n50), .A4(n42), .A5(n48), 
        .Y(n6) );
  HADDX1_RVT U48 ( .A0(credit[7]), .B0(n46), .SO(n47) );
  AND2X1_RVT U49 ( .A1(n48), .A2(n47), .Y(n5) );
endmodule


module memory ( clk, rst, mem_write, sel_item, price, stock );
  input [1:0] sel_item;
  output [7:0] price;
  output [7:0] stock;
  input clk, rst, mem_write;
  wire   \stocks_array[0][4] , \stocks_array[0][3] , \stocks_array[0][2] ,
         \stocks_array[0][1] , \stocks_array[0][0] , \stocks_array[1][4] ,
         \stocks_array[1][3] , \stocks_array[1][2] , \stocks_array[1][1] ,
         \stocks_array[1][0] , \stocks_array[2][4] , \stocks_array[2][3] ,
         \stocks_array[2][2] , \stocks_array[2][1] , \stocks_array[2][0] ,
         \stocks_array[3][4] , \stocks_array[3][3] , \stocks_array[3][2] ,
         \stocks_array[3][1] , \stocks_array[3][0] , n19, n32, n33, n34, n35,
         n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49,
         n50, n51, n29, \sub_x_2/A[4] , \sub_x_2/A[3] , \sub_x_2/A[2] ,
         \sub_x_2/A[1] , \sub_x_2/A[0] , n1, n2, n3, n4, n5, n6, n7, n8, n9,
         n10, n11, n12, n13, n14, n15, n16, n17, n18, n20, n21, n22, n23, n24,
         n25, n26, n27, n28;
  assign price[6] = sel_item[1];
  assign price[5] = sel_item[0];
  assign stock[4] = \sub_x_2/A[4] ;
  assign stock[3] = \sub_x_2/A[3] ;
  assign stock[2] = \sub_x_2/A[2] ;
  assign stock[1] = \sub_x_2/A[1] ;
  assign stock[0] = \sub_x_2/A[0] ;

  DFFARX1_RVT \stocks_array_reg[3][0]  ( .D(n51), .CLK(clk), .RSTB(n28), .Q(
        \stocks_array[3][0] ) );
  DFFARX1_RVT \stocks_array_reg[3][2]  ( .D(n43), .CLK(clk), .RSTB(n28), .Q(
        \stocks_array[3][2] ) );
  DFFARX1_RVT \stocks_array_reg[3][3]  ( .D(n39), .CLK(clk), .RSTB(n28), .Q(
        \stocks_array[3][3] ) );
  DFFARX1_RVT \stocks_array_reg[3][4]  ( .D(n35), .CLK(clk), .RSTB(n28), .Q(
        \stocks_array[3][4] ) );
  DFFARX1_RVT \stocks_array_reg[2][2]  ( .D(n42), .CLK(clk), .RSTB(n28), .Q(
        \stocks_array[2][2] ) );
  DFFARX1_RVT \stocks_array_reg[2][3]  ( .D(n38), .CLK(clk), .RSTB(n28), .Q(
        \stocks_array[2][3] ) );
  DFFARX1_RVT \stocks_array_reg[2][4]  ( .D(n34), .CLK(clk), .RSTB(n28), .Q(
        \stocks_array[2][4] ) );
  DFFARX1_RVT \stocks_array_reg[1][1]  ( .D(n44), .CLK(clk), .RSTB(n28), .Q(
        \stocks_array[1][1] ) );
  DFFARX1_RVT \stocks_array_reg[1][3]  ( .D(n37), .CLK(clk), .RSTB(n28), .Q(
        \stocks_array[1][3] ) );
  DFFARX1_RVT \stocks_array_reg[1][4]  ( .D(n33), .CLK(clk), .RSTB(n28), .Q(
        \stocks_array[1][4] ) );
  DFFARX1_RVT \stocks_array_reg[0][1]  ( .D(n50), .CLK(clk), .RSTB(n28), .Q(
        \stocks_array[0][1] ) );
  DFFARX1_RVT \stocks_array_reg[0][3]  ( .D(n36), .CLK(clk), .RSTB(n28), .Q(
        \stocks_array[0][3] ) );
  DFFARX1_RVT \stocks_array_reg[0][4]  ( .D(n32), .CLK(clk), .RSTB(n28), .Q(
        \stocks_array[0][4] ) );
  DFFASX1_RVT \stocks_array_reg[3][1]  ( .D(n46), .CLK(clk), .SETB(n19), .Q(
        \stocks_array[3][1] ) );
  DFFASX1_RVT \stocks_array_reg[2][0]  ( .D(n49), .CLK(clk), .SETB(n19), .Q(
        \stocks_array[2][0] ) );
  DFFASX1_RVT \stocks_array_reg[2][1]  ( .D(n45), .CLK(clk), .SETB(n19), .Q(
        \stocks_array[2][1] ) );
  DFFASX1_RVT \stocks_array_reg[1][0]  ( .D(n48), .CLK(clk), .SETB(n19), .Q(
        \stocks_array[1][0] ) );
  DFFASX1_RVT \stocks_array_reg[1][2]  ( .D(n41), .CLK(clk), .SETB(n19), .Q(
        \stocks_array[1][2] ) );
  DFFASX1_RVT \stocks_array_reg[0][0]  ( .D(n47), .CLK(clk), .SETB(n19), .Q(
        \stocks_array[0][0] ) );
  DFFASX1_RVT \stocks_array_reg[0][2]  ( .D(n40), .CLK(clk), .SETB(n19), .Q(
        \stocks_array[0][2] ) );
  INVX2_RVT U4 ( .A(sel_item[0]), .Y(price[0]) );
  INVX0_RVT U5 ( .A(rst), .Y(n19) );
  INVX0_RVT U6 ( .A(sel_item[1]), .Y(n29) );
  MUX41X1_RVT U7 ( .A1(\stocks_array[3][1] ), .A3(\stocks_array[1][1] ), .A2(
        \stocks_array[2][1] ), .A4(\stocks_array[0][1] ), .S0(n29), .S1(
        price[0]), .Y(\sub_x_2/A[1] ) );
  MUX41X1_RVT U8 ( .A1(\stocks_array[3][0] ), .A3(\stocks_array[1][0] ), .A2(
        \stocks_array[2][0] ), .A4(\stocks_array[0][0] ), .S0(n29), .S1(
        price[0]), .Y(\sub_x_2/A[0] ) );
  MUX41X1_RVT U9 ( .A1(\stocks_array[3][4] ), .A3(\stocks_array[1][4] ), .A2(
        \stocks_array[2][4] ), .A4(\stocks_array[0][4] ), .S0(n29), .S1(
        price[0]), .Y(\sub_x_2/A[4] ) );
  AND2X1_RVT U10 ( .A1(sel_item[1]), .A2(sel_item[0]), .Y(price[2]) );
  NBUFFX2_RVT U11 ( .A(n19), .Y(n28) );
  MUX41X1_RVT U12 ( .A1(\stocks_array[2][2] ), .A3(\stocks_array[0][2] ), .A2(
        \stocks_array[3][2] ), .A4(\stocks_array[1][2] ), .S0(n29), .S1(
        sel_item[0]), .Y(\sub_x_2/A[2] ) );
  MUX41X1_RVT U13 ( .A1(\stocks_array[2][3] ), .A3(\stocks_array[0][3] ), .A2(
        \stocks_array[3][3] ), .A4(\stocks_array[1][3] ), .S0(n29), .S1(
        sel_item[0]), .Y(\sub_x_2/A[3] ) );
  NAND2X0_RVT U14 ( .A1(sel_item[0]), .A2(n29), .Y(n6) );
  NAND2X0_RVT U15 ( .A1(sel_item[1]), .A2(price[0]), .Y(n4) );
  NAND2X0_RVT U16 ( .A1(n6), .A2(n4), .Y(price[1]) );
  INVX0_RVT U17 ( .A(\sub_x_2/A[4] ), .Y(n17) );
  NOR4X1_RVT U18 ( .A1(\sub_x_2/A[3] ), .A2(\sub_x_2/A[2] ), .A3(
        \sub_x_2/A[1] ), .A4(\sub_x_2/A[0] ), .Y(n16) );
  NAND2X0_RVT U19 ( .A1(n17), .A2(n16), .Y(n1) );
  AND2X1_RVT U20 ( .A1(n1), .A2(mem_write), .Y(n7) );
  NAND2X0_RVT U21 ( .A1(price[2]), .A2(n7), .Y(n20) );
  INVX0_RVT U22 ( .A(n20), .Y(n21) );
  INVX0_RVT U23 ( .A(\sub_x_2/A[0] ), .Y(n9) );
  AO22X1_RVT U24 ( .A1(n21), .A2(n9), .A3(n20), .A4(\stocks_array[3][0] ), .Y(
        n51) );
  AND2X1_RVT U25 ( .A1(n29), .A2(price[0]), .Y(n2) );
  NAND2X0_RVT U26 ( .A1(n2), .A2(n7), .Y(n26) );
  INVX0_RVT U27 ( .A(n26), .Y(n27) );
  INVX0_RVT U28 ( .A(\sub_x_2/A[1] ), .Y(n3) );
  AO22X1_RVT U29 ( .A1(n3), .A2(n9), .A3(\sub_x_2/A[1] ), .A4(\sub_x_2/A[0] ), 
        .Y(n10) );
  AO22X1_RVT U30 ( .A1(n27), .A2(n10), .A3(n26), .A4(\stocks_array[0][1] ), 
        .Y(n50) );
  INVX0_RVT U31 ( .A(n4), .Y(n5) );
  NAND2X0_RVT U32 ( .A1(n5), .A2(n7), .Y(n22) );
  INVX0_RVT U33 ( .A(n22), .Y(n23) );
  AO22X1_RVT U34 ( .A1(n23), .A2(n9), .A3(n22), .A4(\stocks_array[2][0] ), .Y(
        n49) );
  INVX0_RVT U35 ( .A(n6), .Y(n8) );
  NAND2X0_RVT U36 ( .A1(n8), .A2(n7), .Y(n24) );
  INVX0_RVT U37 ( .A(n24), .Y(n25) );
  AO22X1_RVT U38 ( .A1(n25), .A2(n9), .A3(n24), .A4(\stocks_array[1][0] ), .Y(
        n48) );
  AO22X1_RVT U39 ( .A1(n27), .A2(n9), .A3(n26), .A4(\stocks_array[0][0] ), .Y(
        n47) );
  AO22X1_RVT U40 ( .A1(n21), .A2(n10), .A3(n20), .A4(\stocks_array[3][1] ), 
        .Y(n46) );
  AO22X1_RVT U41 ( .A1(n23), .A2(n10), .A3(n22), .A4(\stocks_array[2][1] ), 
        .Y(n45) );
  AO22X1_RVT U42 ( .A1(n25), .A2(n10), .A3(n24), .A4(\stocks_array[1][1] ), 
        .Y(n44) );
  OR3X1_RVT U43 ( .A1(\sub_x_2/A[2] ), .A2(\sub_x_2/A[1] ), .A3(\sub_x_2/A[0] ), .Y(n13) );
  INVX0_RVT U44 ( .A(n13), .Y(n11) );
  AO221X1_RVT U45 ( .A1(\sub_x_2/A[2] ), .A2(\sub_x_2/A[1] ), .A3(
        \sub_x_2/A[2] ), .A4(\sub_x_2/A[0] ), .A5(n11), .Y(n12) );
  AO22X1_RVT U46 ( .A1(n21), .A2(n12), .A3(n20), .A4(\stocks_array[3][2] ), 
        .Y(n43) );
  AO22X1_RVT U47 ( .A1(n23), .A2(n12), .A3(n22), .A4(\stocks_array[2][2] ), 
        .Y(n42) );
  AO22X1_RVT U48 ( .A1(n25), .A2(n12), .A3(n24), .A4(\stocks_array[1][2] ), 
        .Y(n41) );
  AO22X1_RVT U49 ( .A1(n27), .A2(n12), .A3(n26), .A4(\stocks_array[0][2] ), 
        .Y(n40) );
  AO21X1_RVT U50 ( .A1(\sub_x_2/A[3] ), .A2(n13), .A3(n16), .Y(n14) );
  AO22X1_RVT U51 ( .A1(n21), .A2(n14), .A3(n20), .A4(\stocks_array[3][3] ), 
        .Y(n39) );
  AO22X1_RVT U52 ( .A1(n23), .A2(n14), .A3(n22), .A4(\stocks_array[2][3] ), 
        .Y(n38) );
  AO22X1_RVT U53 ( .A1(n25), .A2(n14), .A3(n24), .A4(\stocks_array[1][3] ), 
        .Y(n37) );
  AO22X1_RVT U54 ( .A1(n27), .A2(n14), .A3(n26), .A4(\stocks_array[0][3] ), 
        .Y(n36) );
  INVX0_RVT U55 ( .A(n16), .Y(n15) );
  AO22X1_RVT U56 ( .A1(n17), .A2(n16), .A3(\sub_x_2/A[4] ), .A4(n15), .Y(n18)
         );
  AO22X1_RVT U57 ( .A1(n21), .A2(n18), .A3(n20), .A4(\stocks_array[3][4] ), 
        .Y(n35) );
  AO22X1_RVT U58 ( .A1(n23), .A2(n18), .A3(n22), .A4(\stocks_array[2][4] ), 
        .Y(n34) );
  AO22X1_RVT U59 ( .A1(n25), .A2(n18), .A3(n24), .A4(\stocks_array[1][4] ), 
        .Y(n33) );
  AO22X1_RVT U60 ( .A1(n27), .A2(n18), .A3(n26), .A4(\stocks_array[0][4] ), 
        .Y(n32) );
endmodule


module comparator ( credit, price, stock, can_sell );
  input [7:0] credit;
  input [7:0] price;
  input [7:0] stock;
  output can_sell;
  wire   n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12;

  INVX0_RVT U2 ( .A(price[1]), .Y(n3) );
  OA22X1_RVT U3 ( .A1(credit[1]), .A2(n3), .A3(price[5]), .A4(credit[0]), .Y(
        n2) );
  AO21X1_RVT U4 ( .A1(n3), .A2(credit[1]), .A3(n2), .Y(n5) );
  INVX0_RVT U5 ( .A(price[2]), .Y(n4) );
  AO222X1_RVT U6 ( .A1(credit[2]), .A2(n5), .A3(credit[2]), .A4(n4), .A5(n5), 
        .A6(n4), .Y(n6) );
  AO222X1_RVT U7 ( .A1(price[5]), .A2(credit[3]), .A3(price[5]), .A4(n6), .A5(
        credit[3]), .A6(n6), .Y(n7) );
  AO222X1_RVT U8 ( .A1(price[6]), .A2(credit[4]), .A3(price[6]), .A4(n7), .A5(
        credit[4]), .A6(n7), .Y(n8) );
  AO222X1_RVT U9 ( .A1(credit[5]), .A2(n8), .A3(credit[5]), .A4(price[0]), 
        .A5(n8), .A6(price[0]), .Y(n10) );
  INVX0_RVT U10 ( .A(price[6]), .Y(n9) );
  AO222X1_RVT U11 ( .A1(credit[6]), .A2(n10), .A3(credit[6]), .A4(n9), .A5(n10), .A6(n9), .Y(n12) );
  OR4X1_RVT U12 ( .A1(stock[3]), .A2(stock[2]), .A3(stock[1]), .A4(stock[0]), 
        .Y(n11) );
  OA22X1_RVT U13 ( .A1(credit[7]), .A2(n12), .A3(stock[4]), .A4(n11), .Y(
        can_sell) );
endmodule


module subtractor ( credit, price, change );
  input [7:0] credit;
  input [7:0] price;
  output [7:0] change;
  wire   \intadd_0/A[3] , \intadd_0/B[5] , \intadd_0/B[4] , \intadd_0/B[3] ,
         \intadd_0/B[2] , \intadd_0/B[1] , \intadd_0/B[0] , \intadd_0/CI ,
         \intadd_0/SUM[5] , \intadd_0/SUM[4] , \intadd_0/SUM[3] ,
         \intadd_0/SUM[2] , \intadd_0/SUM[1] , \intadd_0/SUM[0] ,
         \intadd_0/n6 , \intadd_0/n5 , \intadd_0/n4 , \intadd_0/n3 ,
         \intadd_0/n2 , \intadd_0/n1 ;

  FADDX1_RVT \intadd_0/U7  ( .A(\intadd_0/B[0] ), .B(price[1]), .CI(
        \intadd_0/CI ), .CO(\intadd_0/n6 ), .S(\intadd_0/SUM[0] ) );
  FADDX1_RVT \intadd_0/U6  ( .A(\intadd_0/B[1] ), .B(price[2]), .CI(
        \intadd_0/n6 ), .CO(\intadd_0/n5 ), .S(\intadd_0/SUM[1] ) );
  FADDX1_RVT \intadd_0/U5  ( .A(\intadd_0/B[2] ), .B(price[0]), .CI(
        \intadd_0/n5 ), .CO(\intadd_0/n4 ), .S(\intadd_0/SUM[2] ) );
  FADDX1_RVT \intadd_0/U4  ( .A(\intadd_0/B[3] ), .B(\intadd_0/A[3] ), .CI(
        \intadd_0/n4 ), .CO(\intadd_0/n3 ), .S(\intadd_0/SUM[3] ) );
  FADDX1_RVT \intadd_0/U3  ( .A(\intadd_0/B[4] ), .B(price[5]), .CI(
        \intadd_0/n3 ), .CO(\intadd_0/n2 ), .S(\intadd_0/SUM[4] ) );
  FADDX1_RVT \intadd_0/U2  ( .A(\intadd_0/B[5] ), .B(price[6]), .CI(
        \intadd_0/n2 ), .CO(\intadd_0/n1 ), .S(\intadd_0/SUM[5] ) );
  INVX0_RVT U1 ( .A(\intadd_0/SUM[0] ), .Y(change[1]) );
  INVX0_RVT U2 ( .A(\intadd_0/SUM[1] ), .Y(change[2]) );
  INVX0_RVT U3 ( .A(\intadd_0/SUM[2] ), .Y(change[3]) );
  INVX0_RVT U4 ( .A(\intadd_0/SUM[3] ), .Y(change[4]) );
  INVX0_RVT U5 ( .A(\intadd_0/SUM[4] ), .Y(change[5]) );
  INVX0_RVT U6 ( .A(\intadd_0/SUM[5] ), .Y(change[6]) );
  XOR2X1_RVT U7 ( .A1(\intadd_0/n1 ), .A2(credit[7]), .Y(change[7]) );
  NOR2X0_RVT U8 ( .A1(credit[0]), .A2(price[5]), .Y(\intadd_0/CI ) );
  INVX0_RVT U9 ( .A(price[6]), .Y(\intadd_0/A[3] ) );
  INVX0_RVT U10 ( .A(credit[1]), .Y(\intadd_0/B[0] ) );
  INVX0_RVT U11 ( .A(credit[2]), .Y(\intadd_0/B[1] ) );
  INVX0_RVT U12 ( .A(credit[3]), .Y(\intadd_0/B[2] ) );
  INVX0_RVT U13 ( .A(credit[4]), .Y(\intadd_0/B[3] ) );
  INVX0_RVT U14 ( .A(credit[5]), .Y(\intadd_0/B[4] ) );
  INVX0_RVT U15 ( .A(credit[6]), .Y(\intadd_0/B[5] ) );
  AO21X1_RVT U16 ( .A1(credit[0]), .A2(price[5]), .A3(\intadd_0/CI ), .Y(
        change[0]) );
endmodule


module vending_top ( clk, rst, coin_in, sel_item, confirm, cancel, dispense, 
        error_out, change_out, display, state_out );
  input [1:0] coin_in;
  input [1:0] sel_item;
  output [7:0] change_out;
  output [7:0] display;
  output [2:0] state_out;
  input clk, rst, confirm, cancel;
  output dispense, error_out;
  wire   sel_change, load_change, can_sell, credit_load, clear, mem_write, n5,
         n6, n7, n8, n9, n10, n11, n12, n13, n14, n17, n18, n19, n20, net868,
         net869, net870, net871, net872, net873, net874, net875, net876,
         net877, net878, net879;
  wire   [6:0] coin_value;
  wire   [7:0] change_wire;
  wire   [7:0] price;
  wire   [7:0] stock;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5;

  control_unit u_fsm ( .clk(clk), .rst(rst), .coin_in(coin_in), .confirm(
        confirm), .cancel(cancel), .can_sell(can_sell), .credit_load(
        credit_load), .clear(clear), .mem_write(mem_write), .sel_change(
        sel_change), .load_change(load_change), .dispense(dispense), 
        .error_out(error_out), .state_out(state_out) );
  credit_reg u_credit_reg ( .clk(clk), .rst(rst), .clear(clear), .credit_load(
        credit_load), .coin_value({net877, coin_value[6], coin_in[1], n14, 
        coin_value[3], net878, coin_value[1], net879}), .credit(display) );
  memory u_memory ( .clk(clk), .rst(rst), .mem_write(mem_write), .sel_item(
        sel_item), .price({SYNOPSYS_UNCONNECTED__0, price[6:5], 
        SYNOPSYS_UNCONNECTED__1, SYNOPSYS_UNCONNECTED__2, price[2:0]}), 
        .stock({SYNOPSYS_UNCONNECTED__3, SYNOPSYS_UNCONNECTED__4, 
        SYNOPSYS_UNCONNECTED__5, stock[4:0]}) );
  comparator u_comparator ( .credit(display), .price({net871, price[6:5], 
        net872, net873, price[2:0]}), .stock({net874, net875, net876, 
        stock[4:0]}), .can_sell(can_sell) );
  subtractor u_subtractor ( .credit(display), .price({net868, price[6:5], 
        net869, net870, price[2:0]}), .change(change_wire) );
  DFFARX1_RVT \change_out_reg[7]  ( .D(n13), .CLK(clk), .RSTB(n5), .Q(
        change_out[7]) );
  DFFARX1_RVT \change_out_reg[6]  ( .D(n12), .CLK(clk), .RSTB(n5), .Q(
        change_out[6]) );
  DFFARX1_RVT \change_out_reg[5]  ( .D(n11), .CLK(clk), .RSTB(n5), .Q(
        change_out[5]) );
  DFFARX1_RVT \change_out_reg[4]  ( .D(n10), .CLK(clk), .RSTB(n5), .Q(
        change_out[4]) );
  DFFARX1_RVT \change_out_reg[3]  ( .D(n9), .CLK(clk), .RSTB(n5), .Q(
        change_out[3]) );
  DFFARX1_RVT \change_out_reg[2]  ( .D(n8), .CLK(clk), .RSTB(n5), .Q(
        change_out[2]) );
  DFFARX1_RVT \change_out_reg[1]  ( .D(n7), .CLK(clk), .RSTB(n5), .Q(
        change_out[1]) );
  DFFARX1_RVT \change_out_reg[0]  ( .D(n6), .CLK(clk), .RSTB(n5), .Q(
        change_out[0]) );
  INVX0_RVT U23 ( .A(rst), .Y(n5) );
  INVX0_RVT U24 ( .A(coin_in[0]), .Y(n17) );
  NOR2X0_RVT U25 ( .A1(n17), .A2(coin_in[1]), .Y(coin_value[3]) );
  AND2X1_RVT U26 ( .A1(coin_in[1]), .A2(n17), .Y(coin_value[1]) );
  OR2X1_RVT U27 ( .A1(coin_value[3]), .A2(coin_value[1]), .Y(n14) );
  AND2X1_RVT U29 ( .A1(coin_in[1]), .A2(coin_in[0]), .Y(coin_value[6]) );
  INVX0_RVT U30 ( .A(load_change), .Y(n20) );
  NOR2X0_RVT U31 ( .A1(sel_change), .A2(n20), .Y(n18) );
  AND2X1_RVT U32 ( .A1(load_change), .A2(sel_change), .Y(n19) );
  AO222X1_RVT U33 ( .A1(n20), .A2(change_out[7]), .A3(n18), .A4(change_wire[7]), .A5(n19), .A6(display[7]), .Y(n13) );
  AO222X1_RVT U34 ( .A1(n20), .A2(change_out[6]), .A3(n19), .A4(display[6]), 
        .A5(change_wire[6]), .A6(n18), .Y(n12) );
  AO222X1_RVT U35 ( .A1(n20), .A2(change_out[5]), .A3(n19), .A4(display[5]), 
        .A5(change_wire[5]), .A6(n18), .Y(n11) );
  AO222X1_RVT U36 ( .A1(n20), .A2(change_out[4]), .A3(n19), .A4(display[4]), 
        .A5(change_wire[4]), .A6(n18), .Y(n10) );
  AO222X1_RVT U37 ( .A1(n20), .A2(change_out[3]), .A3(n19), .A4(display[3]), 
        .A5(change_wire[3]), .A6(n18), .Y(n9) );
  AO222X1_RVT U38 ( .A1(n20), .A2(change_out[2]), .A3(n19), .A4(display[2]), 
        .A5(change_wire[2]), .A6(n18), .Y(n8) );
  AO222X1_RVT U39 ( .A1(n20), .A2(change_out[1]), .A3(n19), .A4(display[1]), 
        .A5(change_wire[1]), .A6(n18), .Y(n7) );
  AO222X1_RVT U40 ( .A1(n20), .A2(change_out[0]), .A3(n19), .A4(display[0]), 
        .A5(change_wire[0]), .A6(n18), .Y(n6) );
endmodule

