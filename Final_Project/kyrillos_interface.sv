interface kyrillos_interface
    
    
#(
    parameter ADDR_WIDTH = 4,
    parameter DATA_WIDTH = 32,
    parameter DEPTH = 2**ADDR_WIDTH
)


    ();

    bit   clk;
    logic rst;
    logic [ADDR_WIDTH-1:0]  Address;
    logic [DATA_WIDTH-1:0]  Data_in;
    logic                   EN;
    logic [DATA_WIDTH-1:0]  Data_out;
    logic                   valid_out;

    always #5 clk=~clk; // just a hack but in reality we need clock sequence and reset sequence

endinterface
