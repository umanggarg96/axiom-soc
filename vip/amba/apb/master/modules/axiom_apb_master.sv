module axiom_apb_master #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter IF_NAME = "apb_master_if"
) (
    input  wire                     pclk,
    input  wire                     presetn,
    output wire                     psel,
    output wire                     penable,
    output wire [ADDR_WIDTH-1:0]    paddr,
    output wire                     pwrite,
    output wire [DATA_WIDTH/8-1:0]  pstrb,
    output wire [2:0]               pprot,
    output wire [DATA_WIDTH-1:0]    pwdata,
    input  wire [DATA_WIDTH-1:0]    prdata,
    input  wire                     pready,
    input  wire                     pslverr
);
    import uvm_pkg::*;

    axiom_apb_interface apb_if();

    assign  apb_if.pclk     =  pclk;
    assign  apb_if.presetn  =  presetn;
    assign  psel            =  apb_if.psel;
    assign  penable         =  apb_if.penable;
    assign  paddr           =  apb_if.paddr;
    assign  pwrite          =  apb_if.pwrite;
    assign  pstrb           =  apb_if.pstrb;
    assign  pprot           =  apb_if.pprot;
    assign  pwdata          =  apb_if.pwdata;
    assign  apb_if.prdata   =  prdata;
    assign  apb_if.pready   =  pready;
    assign  apb_if.pslverr  =  pslverr;


    initial begin
        uvm_config_db#(virtual axiom_apb_interface)
            ::set(null, "*", IF_NAME, apb_if);
    end

endmodule
