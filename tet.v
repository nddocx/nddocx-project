`timescale 1ns/10ps

module tet (
    input [3:0] A,
    input [3:0] B,
    input clk,   // Thêm các tín hiệu xung
    output reg [9:0] C
);
    reg [4:0] T1, T2;
    reg [9:0] T3;

    // Tính T1 = A + B khi có cạnh lên của clk1
    always @(posedge clk) begin
        T1 <= A + B;
    end

    // Tính T2 = A - B khi có cạnh lên của clk2
    always @(posedge clk) begin
        T2 <= A - B;
    end

    // Tính T3 = T1 * T2 khi có cạnh lên của clk3 và xuất kết quả ra C
    always @(posedge clk) begin
        T3 <= T1 * T2;
        C  <= T3;
    end
endmodule

module tb;
    reg [3:0] a, b;
    wire [9:0] c;
    reg clk;

    // Tạo tín hiệu xung clk1, clk2, clk3 với các chu kỳ khác nhau
    initial begin
        clk = 0; 
        forever #10 clk = ~clk;  // Xung clk1 với chu kỳ 20ns
    end

//    initial begin
//        forever #10 clk2 = ~clk2;  // Xung clk2 với chu kỳ 30ns
//    end

//    initial begin
//        forever #20 clk3 = ~clk3;  // Xung clk3 với chu kỳ 40ns
//    end

    // Khởi tạo mô-đun adder
    tet dut (.A(a), .B(b), .clk(clk), .C(c));

    // Thực hiện các trường hợp kiểm tra (test case)
    initial begin
        $dumpfile("wave.vcd");         // Lưu kết quả mô phỏng
        $dumpvars(0, tb, dut);         // Theo dõi các tín hiệu

        a = 4'd1; b = 4'd2; #50;       // Trường hợp kiểm tra 1
        a = 4'd3; b = 4'd5; #70;       // Trường hợp kiểm tra 2
        a = 4'd6; b = 4'd2; #90;       // Trường hợp kiểm tra 3

        $finish;                       // Kết thúc mô phỏng
    end
endmodule

