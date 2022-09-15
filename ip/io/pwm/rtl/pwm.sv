module pwm #(
    parameter CHANNELS = 1,
    parameter RESOLUTION = 16
)(
    // apb
    input  wire                 pclk,
    input  wire                 presetn,
    input  wire                 psel,
    input  wire                 penable,
    input  wire  [31:0]         paddr,
    input  wire                 pwrite,
    input  wire  [3:0]          pstrb,
    input  wire  [31:0]         pwdata,
    output logic [31:0]         prdata,
    output logic                pready,
    output logic                pslverr,

    // pwm
    output wire [CHANNELS-1:0] pwm
);
    logic [RESOLUTION-1:0] counter;
    logic [RESOLUTION-1:0] duty_cycle;

    always @(posedge pclk) begin
        if(!presetn) begin
            prdata <= '0;
            pready <= '0;
            pslverr <= '0;
            duty_cycle <= 0;
        end else begin
            pready <= 1'b1;
            case(paddr)
                32'h0: begin
                    pslverr <= 1'b0;
                    if(psel && penable && pready && pwrite) duty_cycle <= pwdata;
                    if(psel && !pwrite) prdata <= duty_cycle;
                end
                default:
                    pslverr <= 1'b1;
            endcase
        end
    end

    always @(posedge pclk) begin
        if(!presetn)
            counter <= '0;
        else
            counter <= counter + 1;
    end

    assign pwm[0] = counter < duty_cycle;

endmodule
