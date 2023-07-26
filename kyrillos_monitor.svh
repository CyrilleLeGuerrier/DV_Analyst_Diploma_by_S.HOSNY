class my_monitor extends uvm_monitor;
        `uvm_component_utils(my_monitor)
        uvm_analysis_port #(my_sequence_item) analysis_port_monitor;
        my_sequence_item sequence_item_monitor1;
        my_sequence_item sequence_item_monitor2;

        function new(input string name = "my_monitor", uvm_component parent = null);
            super.new(name, parent);
            $display("my_monitor");
        endfunction

        virtual interface kyrillos_interface monitor_virtual;

        function void build_phase (input uvm_phase phase);
            super.build_phase(phase);
            $display("my_monitor");

            if (!uvm_config_db#(virtual kyrillos_interface)::get(this, "", "my_vif", monitor_virtual))
            begin
                //`uvm_fatal(get_full_name(), "Error!")
            end

            sequence_item_monitor1 = my_sequence_item::type_id::create("sequence_item_monitor1");
            sequence_item_monitor2 = my_sequence_item::type_id::create("sequence_item_monitor2");
            analysis_port_monitor = new("analysis_port_monitor", this); // TLM is not part of the factory
        endfunction

        function void connect_phase (input uvm_phase phase);
            super.connect_phase(phase);
            $display("my_monitor");
        endfunction

        function void end_of_elaboration_phase (input uvm_phase phase);
            super.end_of_elaboration_phase(phase);
            $display("my_monitor");
        endfunction

        function void start_of_simulation_phase (input uvm_phase phase);
            super.start_of_simulation_phase(phase);
            $display("my_monitor");
        endfunction

        task run_phase (input uvm_phase phase);
            super.run_phase(phase);
            $display("my_monitor");

            forever begin
                @(posedge monitor_virtual.clk)
                if(monitor_virtual.valid_out == 1) // reading
                    begin
                        // sequence_item_monitor1.Address   <= monitor_virtual.Address;
                        // sequence_item_monitor1.Data_in   <= monitor_virtual.Data_in;
                        // sequence_item_monitor1.EN       <= monitor_virtual.EN;
                        $display("%p Data_out in sequence_item_monitor1", sequence_item_monitor1.Data_out);
                        $display("%p valid_out in sequence_item_monitor1", sequence_item_monitor1.valid_out);
                        sequence_item_monitor1.Address   <= monitor_virtual.Address;
                        sequence_item_monitor1.EN        <= monitor_virtual.EN;
                        sequence_item_monitor1.Data_out  <= monitor_virtual.Data_out;
                        sequence_item_monitor1.valid_out <= monitor_virtual.valid_out;
                        $cast(sequence_item_monitor2, sequence_item_monitor1);
                        $display("%p Data_out in sequence_item_monitor2", sequence_item_monitor2.Data_out);
                        $display("%p valid_out in sequence_item_monitor2", sequence_item_monitor2.valid_out);
                        $display("%p", analysis_port_monitor);
                        analysis_port_monitor.write(sequence_item_monitor2);
                    end
                else // writing
                    begin
                        // sequence_item_monitor1.Address   <= monitor_virtual.Address;
                        // sequence_item_monitor1.Data_in   <= monitor_virtual.Data_in;
                        // sequence_item_monitor1.EN       <= monitor_virtual.EN;
                        $display("%p Address in sequence_item_monitor1", sequence_item_monitor1.Address);
                        $display("%p Data_in in sequence_item_monitor1", sequence_item_monitor1.Data_in);
                        $display("%p EN in sequence_item_monitor1", sequence_item_monitor1.EN);
                        sequence_item_monitor1.Address  <= monitor_virtual.Address;
                        sequence_item_monitor1.Data_in <= monitor_virtual.Data_in;
                        sequence_item_monitor1.EN <= monitor_virtual.EN;
                        $cast(sequence_item_monitor2, sequence_item_monitor1);
                        $display("%p Address in sequence_item_monitor2", sequence_item_monitor2.Address);
                        $display("%p Data_in in sequence_item_monitor2", sequence_item_monitor2.Data_in);
                        $display("%p EN in sequence_item_monitor2", sequence_item_monitor2.EN);
                        $display("%p", analysis_port_monitor);
                        analysis_port_monitor.write(sequence_item_monitor2);
                    end
            end

        endtask

    endclass