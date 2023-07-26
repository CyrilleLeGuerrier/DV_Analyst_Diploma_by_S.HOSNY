class my_test extends uvm_test;
        `uvm_component_utils(my_test)

        function new(input string name = "my_test", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        virtual interface kyrillos_interface config_virtual;
        virtual interface kyrillos_interface local_virtual;

        // Component Creation

        // Class Instantiation
        my_env my_env_instance;
        my_sequence sequence_test;


        function void build_phase (input uvm_phase phase);
            super.build_phase(phase);
            $display("my_test");
            // Class Instance Assignment
            my_env_instance = my_env::type_id::create("my_env_instance", this);
            // typedef uvm_component_registry #(my_env,"my_env") type_id;
            sequence_test = my_sequence::type_id::create("sequence_test", this);

            if (!uvm_config_db#(virtual kyrillos_interface)::get(this, "", "my_vif", config_virtual))
            begin
                //  `uvm_fatal(get_full_name(), "Error!")
            end
            local_virtual = config_virtual;
            //                                           Scope          Name         Value 
            uvm_config_db#(virtual kyrillos_interface)::set(this, "my_env_instance", "my_vif", local_virtual);
        endfunction

        function void connect_phase (input uvm_phase phase);
            super.connect_phase(phase);
            $display("my_test");
        endfunction

        function void end_of_elaboration_phase (input uvm_phase phase);
            super.end_of_elaboration_phase(phase);
            $display("my_test");
        endfunction

        function void start_of_simulation_phase (input uvm_phase phase);
            super.start_of_simulation_phase(phase);
            $display("my_test");
        endfunction

        task run_phase (input uvm_phase phase);
            super.run_phase(phase);
            $display("my_test");

            phase.raise_objection(this);
            $display("Starting from my_test");
            sequence_test.start(my_env_instance.my_agent_instance.sequencer_agent);
            phase.drop_objection(this);
        endtask




    endclass