module apb_slave (
    input PCLK,
    input PRESETn,
    input PSEL,
    input PENABLE,
    input PWRITE,
    input  [31:0] PADDR,
    input  [31:0] PWDATA,

    output reg [31:0] PRDATA,
    output reg PREADY,
    output reg PSLVERR
);

    // 4 x 32-bit Register File
    reg [31:0] reg0;
    reg [31:0] reg1;
    reg [31:0] reg2;
    reg [31:0] reg3;


    always @(posedge PCLK or negedge PRESETn) begin

        if (!PRESETn) begin
            // Reset all registers
            reg0 <= 32'h0;
            reg1 <= 32'h0;
            reg2 <= 32'h0;
            reg3 <= 32'h0;

            PRDATA  <= 32'h0;
            PREADY  <= 1'b0;
            PSLVERR <= 1'b0;
        end
        else begin

            // Default values for every clock
            PREADY  <= 1'b0;
            PSLVERR <= 1'b0;

            // Valid APB transfer
            if (PSEL && PENABLE) begin

                PREADY <= 1'b1;

                
                if (PWRITE) begin

                    case (PADDR)

                        32'h0: reg0 <= PWDATA;
                        32'h4: reg1 <= PWDATA;
                        32'h8: reg2 <= PWDATA;
                        32'hC: reg3 <= PWDATA;

                        default:
                            PSLVERR <= 1'b1;

                    endcase

                end

                // READ OPERATION
                else begin

                    case (PADDR)

                        32'h0: PRDATA <= reg0;
                        32'h4: PRDATA <= reg1;
                        32'h8: PRDATA <= reg2;
                        32'hC: PRDATA <= reg3;

                        default: begin
                            PRDATA  <= 32'h0;
                            PSLVERR <= 1'b1;
                        end

                    endcase

                end

            end

        end

    end

endmodule