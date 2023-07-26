class my_env extends uvm_env;
        `uvm_component_utils(my_env)
        // uvm_analysis_port #(my_sequence_item) analysis_port_env; // not used  
        // my_sequence_item sequence_item_env; // not needed
        function new(input string name = "my_env", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        virtual interface kyrillos_interface config_virtual;
        virtual interface kyrillos_interface local_virtual;

        // Component Creation

        // Class Instantiation
        my_agent my_agent_instance;
        my_scoreboard my_scoreboard_instance;
        my_subscriber my_subscriber_instance;



        function void build_phase (input uvm_phase phase);
            super.build_phase(phase);
            $display("my_env");
            // Class Instance Assignment
            my_agent_instance = my_agent::type_id::create("my_agent_instance", this);
            my_scoreboard_instance = my_scoreboard::type_id::create("my_scoreboard_instance", this);
            my_subscriber_instance = my_subscriber::type_id::create("my_subscriber_instance", this);
            //sequence_item_env = my_sequence_item::type_id::create("sequence_item_env", this);
            // analysis_port_env = new("analysis_port_env", this);


            if(!uvm_config_db #(virtual kyrillos_interface)::get(this, "", "my_vif", config_virtual))
                begin
                    // `uvm_fatal (get_full_name(), "Error!")
                end
            else
                begin
                    local_virtual = config_virtual;
                    uvm_config_db #(virtual kyrillos_interface)::set(this, "my_agent_instance", "my_vif", local_virtual);
                end
        endfunction

        function void connect_phase (input uvm_phase phase);
            super.connect_phase(phase);
            $display("my_env");
            // $display("%p my_agent_instance.analysis_port_agent, %p my_scoreboard_instance.analysis_export_scoreboard", my_agent_instance.analysis_port_agent, my_scoreboard_instance.analysis_export_scoreboard);
            $display("%p my_agent_instance.analysis_port_agent, %p my_subscriber_instance.analysis_export", my_agent_instance.analysis_port_agent, my_subscriber_instance.analysis_export);
            my_agent_instance.analysis_port_agent.connect(my_scoreboard_instance.analysis_export_scoreboard);
            // my_agent_instance.my_monitor_instance.analysis_port_monitor.connect(my_scoreboard_instance.my_tlm_analysis_fifo.analysis_export);
            my_agent_instance.analysis_port_agent.connect(my_subscriber_instance.analysis_export);
        endfunction

        function void end_of_elaboration_phase (input uvm_phase phase);
            super.end_of_elaboration_phase(phase);
            $display("my_env");
        endfunction

        function void start_of_simulation_phase (input uvm_phase phase);
            super.start_of_simulation_phase(phase);
            $display("my_env");
        endfunction

        task run_phase (input uvm_phase phase);
            super.run_phase(phase);
            $display("my_env");
        endtask

    endclass