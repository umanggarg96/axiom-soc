`default_nettype none
module top;
    import uvm_pkg::*;
    import test_pkg::*;

    parameter time PCLK_PERIOD = 10;

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

    // pwm
    wire        pwm;

    pwm dut(.*);

    axiom_apb_master #(.IF_NAME("apb_master_if")) bfm
    (
            .*,
            .pprot()
    );
    

    initial run_test();

    initial begin
        pclk = 1'b0;
        forever #(PCLK_PERIOD/2) pclk = !pclk;
    end

    initial begin
        presetn = 1'b0;
        repeat(20) @(posedge pclk);
        #5;
        presetn = 1'b1;
    end

endmodule
