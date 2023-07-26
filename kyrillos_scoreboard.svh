class my_scoreboard extends uvm_scoreboard;
        `uvm_component_utils(my_scoreboard)
        uvm_tlm_analysis_fifo #(my_sequence_item) my_tlm_analysis_fifo;
        my_sequence_item sequence_item_scoreboard;
        uvm_analysis_export #(my_sequence_item) analysis_export_scoreboard;

        int memory_replica_scoreboard [int];
        int temp;

        function new(input string name = "my_scoreboard", uvm_component parent = null);
            super.new(name, parent);
        endfunction



        function void build_phase (input uvm_phase phase);
            super.build_phase(phase);
            $display("my_scoreboard");
            sequence_item_scoreboard = my_sequence_item::type_id::create("sequence_item_scoreboard", this);
            my_tlm_analysis_fifo = new("uvm_tlm_analysis_fifo",this);
            analysis_export_scoreboard = new("analysis_export_scoreboard", this);
        endfunction

        function void connect_phase (input uvm_phase phase);
            super.connect_phase(phase);
            $display("my_scoreboard");

            analysis_export_scoreboard.connect(my_tlm_analysis_fifo.analysis_export);

        endfunction

        function void end_of_elaboration_phase (input uvm_phase phase);
            super.end_of_elaboration_phase(phase);
            $display("my_scoreboard");
        endfunction

        function void start_of_simulation_phase (input uvm_phase phase);
            super.start_of_simulation_phase(phase);
            $display("my_scoreboard");
        endfunction

        task run_phase (input uvm_phase phase);
            super.run_phase(phase);
            $display("my_scoreboard");
            forever
                begin
                    my_tlm_analysis_fifo.get(sequence_item_scoreboard); // get from the mailbox
                    $display("%p Address in my_scoreboard", sequence_item_scoreboard.Address);
                    $display("%p Data_in in my_scoreboard", sequence_item_scoreboard.Data_in);
                    $display("%p EN in my_scoreboard", sequence_item_scoreboard.EN);
                    $display("%p Data_out in my_scoreboard", sequence_item_scoreboard.Data_out);
                    $display("%p valid_out in my_scoreboard", sequence_item_scoreboard.valid_out);
                    if(sequence_item_scoreboard.EN)
                        begin
                            memory_replica_scoreboard [sequence_item_scoreboard.Address] = sequence_item_scoreboard.Data_in;
                            $display("Data written in memory replica successfully");
                        end
                    else
                        begin
                            temp <= sequence_item_scoreboard.Address;
                            if(sequence_item_scoreboard.Data_out == memory_replica_scoreboard[temp])
                                begin
                                    $display("Working Fine");
                                end
                            else
                                begin
                                    $display("Not Working Fine");
                                end
                        end
                    $display("%p", memory_replica_scoreboard);


                end
        endtask

    endclass