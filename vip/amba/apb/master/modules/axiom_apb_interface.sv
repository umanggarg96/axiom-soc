interface axiom_apb_interface ();
    localparam ADDR_WIDTH = 32;
    localparam DATA_WIDTH = 32;

    logic                     pclk;
    logic                     presetn;
    logic                     psel;
    logic                     penable;
    logic [ADDR_WIDTH-1:0]    paddr;
    logic                     pwrite;
    logic [DATA_WIDTH/8-1:0]  pstrb;
    logic [2:0]               pprot;
    logic [DATA_WIDTH-1:0]    pwdata;
    logic [DATA_WIDTH-1:0]    prdata;
    logic                     pready;
    logic                     pslverr;

endinterface
