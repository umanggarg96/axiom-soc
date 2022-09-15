`default_nettype none
module top;
    import uvm_pkg::*;
    import test_pkg::*;

    parameter time PCLK_PERIOD = 10;
    parameter time BAUD_CLK_PERIOD = 100;

    // apb
    logic       pclk;
    logic       presetn;
    wire        psel;
    wire        penable;
    wire [31:0] paddr;
    wire        pwrite;
    wire [3:0]  pstrb;
    wire [31:0] pwdata;
    wire [31:0] prdata;
    wire        pready;
    wire        pslverr;

    // uart
    logic       baud_clk;
    wire        rx;
    wire        tx;

    uart dut(.*);

    axiom_apb_master #(.IF_NAME("apb_master_if")) bfm
    (
            .*,
            .pprot()
    );
    

    initial run_test();

    initial begin
        baud_clk = 1'b0;
        pclk = 1'b0;
        fork
            forever #(PCLK_PERIOD/2) pclk = !pclk;
            forever #(BAUD_CLK_PERIOD/2) baud_clk = !baud_clk;
        join
    end

    initial begin
        presetn = 1'b0;
        repeat(20) @(posedge pclk);
        #5;
        presetn = 1'b1;
    end

endmodule
