class my_agent extends uvm_agent;
`uvm_component_utils(my_agent)
    uvm_analysis_port #(my_sequence_item) analysis_port_agent;
    // my_sequence_item sequence_item_agent;

    function new(input string name = "my_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual interface kyrillos_interface config_virtual;
    virtual interface kyrillos_interface local_virtual;

    // Component Creation

    // Class Instantiation
    my_driver my_driver_instance;
    my_monitor my_monitor_instance;
    my_sequencer sequencer_agent;



    function void build_phase (input uvm_phase phase);
        super.build_phase(phase);
        $display("my_agent");
        // The create() method of the wrapper class is used to create objects for the uvm_object and uvm_component class.
        // 1. The build_phase is used to create component instances and build component hierarchy.
        // 2. Since uvm_object is created in the run time, uvm objects are created in the run_phase.

        // Syntax for Component creation:
        // <instance_name> = <type>::<type_id>::create("<name>", <parent>)
        // Class Instance Assignment
        my_driver_instance = my_driver::type_id::create("my_driver_instance", this); // Factory Creation
        my_monitor_instance = my_monitor::type_id::create("my_monitor_instance", this); // Factory Creation
        sequencer_agent = my_sequencer::type_id::create("my_sequencer_agent", this); // Factory Creation
        // sequence_item_agent = my_sequence_item::type_id::create("sequence_item_agent", this); // not needed
        analysis_port_agent = new("analysis_port_agent", this);

        if(!uvm_config_db #(virtual kyrillos_interface)::get(this, "", "my_vif", config_virtual))
            begin
                //`uvm_fatal (get_full_name(), "Error!")
            end
        else // Not Correct 
            begin
                local_virtual = config_virtual;
                uvm_config_db #(virtual kyrillos_interface)::set(this, "my_driver_instance", "my_vif", local_virtual);
                uvm_config_db #(virtual kyrillos_interface)::set(this, "my_monitor_instance", "my_vif", local_virtual);
            end
    endfunction

    function void connect_phase (input uvm_phase phase);
        super.connect_phase(phase);
        $display("my_agent");
        $display("%p my_monitor_instance.analysis_port_monitor, %p analysis_port_agent", my_monitor_instance.analysis_port_monitor, analysis_port_agent);
        my_monitor_instance.analysis_port_monitor.connect(analysis_port_agent);
        my_driver_instance.seq_item_port.connect(sequencer_agent.seq_item_export);
    endfunction

    function void end_of_elaboration_phase (input uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        $display("my_agent");
    endfunction

    function void start_of_simulation_phase (input uvm_phase phase);
        super.start_of_simulation_phase(phase);
        $display("my_agent");
    endfunction

    task run_phase (input uvm_phase phase);
        super.run_phase(phase);
        $display("my_agent");
    endtask
endclass