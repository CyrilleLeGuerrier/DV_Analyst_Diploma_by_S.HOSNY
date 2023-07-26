package kyrillos_package; // Define a package called pack1 that

    parameter ADDR_WIDTH = 4;
    parameter DATA_WIDTH = 32;
    parameter DEPTH = 2**ADDR_WIDTH;


    // 1. First of all you need to import the reserved package in any simulator(uvm_pkg) and include the the file (uvm_macros.svh)
    import uvm_pkg::*; // Imports the UVM package (uvm_pkg)
    `include "uvm_macros.svh" // Includes the UVM macros (uvm_macros)


    // Handles of the following classes are created in the bulid phases category at time 0 ns


    `include "kyrillos_sequence_item.svh"
    `include "kyrillos_sequence.svh"
    `include "kyrillos_sequencer.svh"
    `include "kyrillos_driver.svh"
    `include "kyrillos_monitor.svh"
    `include "kyrillos_agent.svh"
    `include "kyrillos_scoreboard.svh"
    `include "kyrillos_subscriber.svh"
    `include "kyrillos_environment.svh"
    `include "kyrillos_test.svh"

endpackage
