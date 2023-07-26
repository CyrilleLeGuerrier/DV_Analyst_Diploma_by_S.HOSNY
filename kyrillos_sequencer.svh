class my_sequencer extends uvm_sequencer #(my_sequence_item);
    // All uvm_component and uvm_object must be registered with the factory using a pre-defined factory registration macro.
    // factory registration for sequencer
`uvm_component_utils(my_sequencer) //  UVM Registeration Macros (Factory Registeration)

        // Default constructor new()
        // The uvm_component and uvm_object constructors are virtual methods i.e. they have fixed prototype template defined that has to be followed.
        // Constructor for uvm_component
        // The default constructor has two arguments: name and parent
        //
        // 1. The name denotes an instance name for an object.
        // 2. The parent denotes the handle to its parent. In the constructor, the parent argument is null and the actual parent can be provided while creating an object.
        //    The parent is null if it is a top-level component and all other derived components provide the actual parent.
        // 3. All derived classes must call super.new() methods.
        // 4. Default arguments provide an initial assignment. Later, it is reassigned with other values on calling the create() method of the uvm_component_registry wrapper class. 
        // Component Constructor
        // Called deferred construction as new method is called by the create method in build phase
        function new(input string name = "my_sequencer", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        function void build_phase (input uvm_phase phase); // polymorphic overriding
            super.build_phase(phase);
            $display("my_sequencer"); // Constructs the components hierarchy from the top down
        endfunction

        //uvm_build_phase
        //class uvm_build_phase extends uvm_topdown_phase
        //This is a uvm_topdown_phase whose exec_func calls the uvm_component::build_phase method

        // el function eli foo2 deh w e5watha eli ta7t el base bta3hom mawgood fel base line classes (uvm_sequencer, uvm_monitor, etc.,)
        // and this function is overidden in the used-defined classes (my_sequencer)
        // m4 lazm t3raf kol el phasing tasks and functions enta bt3raf bs eli enta m7tag t3mlhom overriding

        function void connect_phase (input uvm_phase phase);
            super.connect_phase(phase);
            $display("my_sequencer");
        endfunction

        //uvm_connect_phase
        //class uvm_connect_phase extends uvm_bottomup_phase
        //This is a uvm_bottomup_phase whose exec_func calls the uvm_component::connect_phase method 

        //        function void end_of_elaboration_phase (input uvm_phase phase);
        //            super.end_of_elaboration_phase(phase);
        //            $display("my_sequencer");
        //        endfunction
        //
        //        function void start_of_simulation_phase (input uvm_phase phase);
        //            super.start_of_simulation_phase(phase);
        //            $display("my_sequencer");
        //        endfunction

        task run_phase (input uvm_phase phase);
            super.run_phase(phase);
            $display("my_sequencer");
        endtask

    endclass    