`timescale 1ns/1ps

module apb_slave_tb;
    reg PCLK;
    reg PRESETn;
    reg PSEL;
    reg PENABLE;
    reg PWRITE;

    reg [31:0] PADDR;
    reg [31:0] PWDATA;

    wire [31:0] PRDATA;
    wire PREADY;
    wire PSLVERR;

    // instantiate the apb slave module
    apb_slave uut (
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .PSEL(PSEL),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PADDR(PADDR),
        .PWDATA(PWDATA),
        .PRDATA(PRDATA),
        .PREADY(PREADY),
        .PSLVERR(PSLVERR)
    );


// generate clock signal
    initial 
        PCLK=0;
    
    always 
        #5 PCLK=~PCLK;


    initial begin
        $dumpfile("apb_slave_tb.vcd");
        $dumpvars(0,apb_slave_tb);
    end

// apb write task
    task apb_write;
        input [31:0] addr;
        input [31:0] data;
        begin
            @(posedge PCLK);
            PADDR   = addr;
            PWDATA  = data;
            PWRITE  = 1'b1;
            PSEL    = 1'b1;
            PENABLE = 1'b0;

            @(posedge PCLK);
            PENABLE = 1'b1;

            @(posedge PCLK);
            PSEL    = 1'b0;
            PENABLE = 1'b0;
            PWRITE  = 1'b0;

            $display("WRITE : Addr=%h Data=%h", addr, data);
        end
    endtask

   // apb read task
    task apb_read;
        input [31:0] addr;
        begin
            @(posedge PCLK);
            PADDR   = addr;
            PWRITE  = 1'b0;
            PSEL    = 1'b1;
            PENABLE = 1'b0;

            @(posedge PCLK);
            PENABLE = 1'b1;

            @(posedge PCLK);

            $display("READ  : Addr=%h Data=%h", addr, PRDATA);

            PSEL    = 1'b0;
            PENABLE = 1'b0;
        end
    endtask
            
    // Test Sequence
    initial begin

        // Initialize Inputs
        PRESETn = 0;
        PSEL    = 0;
        PENABLE = 0;
        PWRITE  = 0;
        PADDR   = 0;
        PWDATA  = 0;

        // Apply Reset
        #20;
        PRESETn = 1;

        // Write Operations
        apb_write(32'h00000000,32'h11111111);
        apb_write(32'h00000004,32'h22222222);
        apb_write(32'h00000008,32'h33333333);
        apb_write(32'h0000000C,32'h44444444);

        // Read Operations
        apb_read(32'h00000000);
        apb_read(32'h00000004);
        apb_read(32'h00000008);
        apb_read(32'h0000000C);

        // Invalid Address
        apb_read(32'h00000020);

        #20;
        $finish;

    end

endmodule