class my_sequence extends uvm_sequence;
    // All uvm_component and uvm_object must be registered with the factory using a pre-defined factory registration macro.
    // Factory registration for uvm_object
    // Factory registration for sequence
`uvm_object_utils(my_sequence)

    // Default constructor new()
    // The uvm_component and uvm_object constructors are virtual methods i.e. they have fixed prototype template defined that has to be followed.
    // Constructor for uvm_object
    // The default constructor has a single argument as the name denotes an instance name for an object.
    function new(input string name ="my_sequence");
        super.new(name);
    endfunction

    my_sequence_item sequence_item_sequence;

    task pre_body; // acts as build phase (no phasing in classes extending uvm_object)   
        sequence_item_sequence = my_sequence_item::type_id::create("sequence_item_sequence");
    endtask

    task body; // acts as run phase 

        start_item(sequence_item_sequence);
        sequence_item_sequence.rst = 0;
        finish_item(sequence_item_sequence);

        start_item(sequence_item_sequence);
        sequence_item_sequence.rst = 1;
        finish_item(sequence_item_sequence);


        // loop for writing in the memory
        for (int i=0; i<16; i++)
            begin
                start_item(sequence_item_sequence);
                // Inputs only that are directed or random
                void'(sequence_item_sequence.randomize());
                sequence_item_sequence.EN = 1;

                $display("%p in my_sequence", sequence_item_sequence.Address);
                $display("%p in my_sequence", sequence_item_sequence.EN);
                $display("%p in my_sequence", sequence_item_sequence.Data_in);

                finish_item(sequence_item_sequence);
            end


            // loop for reading from the memory
        for (int i=0; i<16; i++)
            begin
                start_item(sequence_item_sequence);
                // Inputs only that are directed or random
                void'(sequence_item_sequence.randomize());
                sequence_item_sequence.EN = 0;
                sequence_item_sequence.Data_in.rand_mode(0);

                $display("%p in my_sequence", sequence_item_sequence.Address);
                $display("%p in my_sequence", sequence_item_sequence.EN);
                $display("%p in my_sequence", sequence_item_sequence.Data_in);

                finish_item(sequence_item_sequence);
            end


    endtask
endclass