// 3. Declare a user defined driver class that accepts sequence item (the transaction) as a parameter   
    class my_driver extends uvm_driver #(my_sequence_item); // the user defined class my_driver is a non-parameterized class but the parent class uvm_driver is a parameterized one.
        // factory registration for driver component
        `uvm_component_utils(my_driver) // 1
        // typedef uvm_component_registry #(my_driver,"my_driver") type_id;


        function new(input string name = "my_driver", uvm_component parent = null); // 2
            super.new(name, parent);
        endfunction

        virtual interface kyrillos_interface driver_virtual;
        my_sequence_item sequence_item_driver;

        function void build_phase (input uvm_phase phase);
            super.build_phase(phase);
            $display("my_driver");
            sequence_item_driver = my_sequence_item::type_id::create("sequence_item_driver");

            if (!uvm_config_db#(virtual kyrillos_interface)::get(this, "", "my_vif", driver_virtual))
            begin
                //`uvm_fatal(get_full_name(), "Error!")
            end
        endfunction

        function void connect_phase (input uvm_phase phase);
            super.connect_phase(phase);
            $display("my_driver");
        endfunction

        function void end_of_elaboration_phase (input uvm_phase phase);
            super.end_of_elaboration_phase(phase);
            $display("my_driver");
        endfunction

        function void start_of_simulation_phase (input uvm_phase phase);
            super.start_of_simulation_phase(phase);
            $display("my_driver");
        endfunction

        task run_phase (input uvm_phase phase);
            super.run_phase(phase);
            $display("my_driver");

            forever begin // Infinite loop is introduced to wait for sequencer
    
                seq_item_port.get_next_item(sequence_item_driver); // Driver is requesting data from sequencer
                $display("%p Address in my_driver", sequence_item_driver.Address);
                $display("%p in my_driver", sequence_item_driver.EN);
                $display("%p in my_driver", sequence_item_driver.Data_in);
                @(posedge driver_virtual.clk)

                // driver_virtual.rst <= sequence_item_driver.rst; Asynch Rst ??
                driver_virtual.rst     <= sequence_item_driver.rst;
                driver_virtual.Address <= sequence_item_driver.Address;
                driver_virtual.Data_in <= sequence_item_driver.Data_in;
                driver_virtual.EN      <= sequence_item_driver.EN;


                #1 seq_item_port.item_done(); // Driver is notifying sequencer that he is done 
            end
        endtask

    endclass