`default_nettype none
module uart (
    // apb
    input  wire        pclk,
    input  wire        presetn,
    input  wire        psel,
    input  wire        penable,
    input  wire [31:0] paddr,
    input  wire        pwrite,
    input  wire [3:0]  pstrb,
    input  wire [31:0] pwdata,
    output wire [31:0] prdata,
    output wire        pready,
    output wire        pslverr,

    // uart
    input  wire        baud_clk,
    input  wire        rx,
    output wire        tx
);

    assign tx      = '0;
    assign pready  = 1'b1;
    assign pslverr = '0;

    logic [31:0] mem[bit[31:0]];

    always @(posedge pclk)
        if(psel & pwrite & penable & pready)
            mem[paddr] = pwdata;

    assign prdata = (psel & !pwrite & penable & pready) ? mem[paddr] : 0;

endmodule
