// 2. Define a sequence item class that extends uvm_sequence_item
    class my_sequence_item extends uvm_sequence_item;
        `uvm_object_utils(my_sequence_item) //  UVM Registeration Macros (Factory Registeration)

        // Factory Deferred Construction
        // Object Constructor
        function new(input string name ="my_sequence_item"); // Factory Deferred Construction
            super.new(name);
        endfunction


        logic clk;
        logic rst;
        randc logic [ADDR_WIDTH-1:0]  Address;
        rand  logic [DATA_WIDTH-1:0]  Data_in;
        logic                   EN; // write enable
        logic [DATA_WIDTH-1:0]  Data_out;
        logic                   valid_out;

    endclass
