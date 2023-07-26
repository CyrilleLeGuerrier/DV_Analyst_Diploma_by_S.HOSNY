class my_subscriber extends uvm_subscriber #(my_sequence_item);
        `uvm_component_utils(my_subscriber)
        my_sequence_item sequence_item_subscriber;
        // uvm_analysis_imp #(my_sequence_item) analysis_export_subscriber; // No need

        //covergroups//
        // vlog: +cover
        // vsim: -do "run 340; coverage report -codeAll -cvg -verbose" -coverage
        covergroup group_1;
        cover_1: coverpoint sequence_item_subscriber.Data_in {bins bin_1[] = {[0:(2**DATA_WIDTH)-1]};}
        cover_2: coverpoint sequence_item_subscriber.Address {bins bin_1[] = {[0:(2**ADDR_WIDTH)-1]};}
        cover_3: coverpoint sequence_item_subscriber.EN {bins bin_1[] = {[0:1]};}
        cover_4: coverpoint sequence_item_subscriber.Data_out {bins bin_1[] = {[0:(2**DATA_WIDTH)-1]};}
        cover_5: coverpoint sequence_item_subscriber.valid_out {bins bin_1[] = {[0:1]};}
        cross_1: cross cover_1, cover_2;
        cross_2: cross cover_2, cover_4;
        endgroup



        function new(input string name = "my_subscriber", uvm_component parent = null);
            super.new(name, parent);
            $display("my_subscriber");
            group_1 = new();
        endfunction








        function void write (input my_sequence_item t); // The only function in uvm_analysis_port/imp/export class
            sequence_item_subscriber = t;
            $display("%p Data_out in my_subscriber", sequence_item_subscriber.Data_out);
            $display("%p valid_out in my_subscriber", sequence_item_subscriber.valid_out);
            group_1.sample();
        endfunction

        function void build_phase (input uvm_phase phase);
            super.build_phase(phase);
            $display("my_subscriber");

            sequence_item_subscriber = my_sequence_item::type_id::create("sequence_item_subscriber", this);

            // analysis_export_subscriber = new("analysis_export_subscriber", this); // no need
        endfunction

        function void connect_phase (input uvm_phase phase);
            super.connect_phase(phase);
            $display("my_subscriber");
            // analysis_port_agent.connect(analysis_export_subscriber);

        endfunction

        function void end_of_elaboration_phase (input uvm_phase phase);
            super.end_of_elaboration_phase(phase);
            $display("my_subscriber");
        endfunction

        function void start_of_simulation_phase (input uvm_phase phase);
            super.start_of_simulation_phase(phase);
            $display("my_subscriber");
        endfunction

        task run_phase (input uvm_phase phase);
            super.run_phase(phase);
            $display("my_subscriber");
        endtask

    endclass