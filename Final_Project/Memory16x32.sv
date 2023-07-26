module Memory16x32
#(
    parameter ADDR_WIDTH = 4,
    parameter DATA_WIDTH = 32,
    parameter DEPTH = 2**ADDR_WIDTH
)
    
    
(
    input  wire clk,
    input  wire rst,
    input  wire [ADDR_WIDTH-1:0]  Address,
    input  wire [DATA_WIDTH-1:0]  Data_in,
    input  wire                   EN,
    output reg  [DATA_WIDTH-1:0]  Data_out,
    output wire                   valid_out
);


    integer i;
    // Declare memory 16x32 bits 
    reg [DATA_WIDTH-1:0] Memory16x32 [DEPTH-1:0];

    always @(posedge clk, negedge rst) begin
        if (!rst)
            begin
                for (i=0; i<DEPTH; i=i+1)
                    Memory16x32[i] <= 0;
            end
        else if (EN)
            begin
                Memory16x32[Address] <= Data_in;
            end
        else
            begin
                Data_out <= Memory16x32[Address];
            end
    end

assign valid_out = (!EN && rst);


endmodule : Memory16x32
