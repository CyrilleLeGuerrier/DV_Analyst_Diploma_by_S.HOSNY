

module uvm_tb_top #(parameter ADDR_WIDTH = 4, parameter DATA_WIDTH = 32, parameter DEPTH = 2**ADDR_WIDTH) ();

    import uvm_pkg::*; // Imports the UVM package (uvm_pkg)
    `include "uvm_macros.svh" // Includes the UVM macros (uvm_macros)
    import kyrillos_package::*;


    kyrillos_interface #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH)
    ) intf_instance();

    // virtual intf vif;

    initial
    begin
        // setting the virtual interface instance from the top level is performed using set method
        // Configuration Classes are propagated from top level module to my_test to my_env to my_agent to my_driver
        //             Type(resource)                Scope         Name         Value
        uvm_config_db #(virtual kyrillos_interface)::set(null, "uvm_test_top", "my_vif", intf_instance); // virtual intf my_vif = intf_instance
        run_test("my_test"); // creates a handle to the test class
        // el run_test deh heya task mawgoda fel uvm_pkg mn 5elal `include "uvm_globals.svh"
        // lma bt3mlha calling fel top level testbench module btroo7 heya mn gowaha tnadi
        // task tania esmha run_test bas el run_test el tania deh mawgoda ta8da class esmo uvm_root
        // eli by7sal fel nehaia en el run_test eli gowa uvm_root btnadi 3ala method esmha m_run_phases();
        // w deh heya el bt3ml launching lel phasing
         
        /*intf_instance.clk = 1'b0;
        intf_instance.rst = 1'b0;
        # 10
        intf_instance.rst = 1'b1;*/

        // vif = intf_instance;
        /*$display("%p", intf_instance.Data_out);
        $display("%p", intf_instance.valid_out);*/
    end

    Memory16x32 #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH)
    ) Memory16x32_instance(
        .clk(intf_instance.clk),
        .rst(intf_instance.rst),
        .Address(intf_instance.Address),
        .Data_in(intf_instance.Data_in),
        .EN(intf_instance.EN),
        .Data_out(intf_instance.Data_out),
        .valid_out(intf_instance.valid_out)
    );

    // always #5 intf_instance.clk = ~intf_instance.clk;

endmodule : uvm_tb_top






