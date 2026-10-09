`timescale 1us / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2026 16:12:58
// Design Name: 
// Module Name: johnson_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module johnson_tb();
    // For clk_divider testing
//    logic f_100MHz_i;
//    logic rst_i;
//    logic f_o;
    
    // For johnson counter or wrapper testing
    logic clk_i;
    logic rst_i;
    logic [3:0] led_o;
    
    // For bouncing modelling
    logic rst_bounce;
    
    // clk_divider module
//    clk_divider #(.OUTPUT_FREQ_HZ(1000000)) clk_divder_uut(
//        .f_100MHz_i(f_100MHz_i),
//        .rst_i(rst_i),
//        .f_o(f_o)
//    );
    
    // johnson module
//    johnson johnson_uut(
//        .clk_i(clk_i),
//        .rst_i(rst_i),
//        .led_o(led_o)
//    );
    
    // johnson wrapper module
    johnson_wrapper johnson_wrapper_uut(
        .clk_i(clk_i),
        .rst_i(rst_bounce),
        .led_o(led_o)
    );
    
    bounce bounce_model(
        .in_i(rst_i),
        .out_o(rst_bounce)
    );
    
//    always #10 f_100MHz_i = ~f_100MHz_i;
    always #0.01 clk_i = ~clk_i;
        
    initial begin
        // For clk_divider testing
//        f_100MHz_i = 0;
//        rst_i = 0;
//        f_o = 0;
        
        // For johnson testing
        clk_i = 0;
        rst_i = 0;
        led_o = 0;
        rst_bounce = 0;
        
        rst_i <= 1;
        #500
        rst_i <= 0;
        #500
        rst_i <= 1;
        #500
        rst_i <= 0;
        #500
        rst_i <= 1;
        #500
        rst_i <= 0;
        
    end
    
endmodule
