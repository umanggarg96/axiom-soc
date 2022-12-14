class apb_master_driver extends uvm_driver #(apb_master_txn);
    `uvm_component_utils(apb_master_driver);

    virtual axiom_apb_interface vif;

    function new(string name="apb_master_driver", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!vif)
            `uvm_fatal(get_type_name(), "Null vif passed")
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            reset_interface();
            reset_deasserted();
            fork begin
                fork
                    drive_transfers();
                    monitor_reset();
                join_any
                disable fork;
            end join
        end
    endtask

    task reset_deasserted();
        wait(vif.presetn === 1'b1);
    endtask

    task drive_transfers();
        bit wait_for_edge = 1'b1;
        forever begin
            apb_master_txn txn;
            seq_item_port.get_next_item(txn);
            if(wait_for_edge) @(posedge vif.pclk);
            vif.psel <= 1'b1;
            vif.pwrite <= txn.is_write;
            vif.paddr <= txn.addr;
            if(txn.is_write) vif.pwdata <= txn.data;
            @(posedge vif.pclk);
            vif.penable <= 1'b1;

            forever
                @(posedge vif.pclk)
                if(vif.pready) break;

            txn.is_error = vif.pslverr;
            if(!vif.pwrite) txn.data = vif.prdata;
            vif.penable <= 1'b0;

            // TODO : This appears as a zero-time glitch on psel, fix it
            vif.psel    <= 1'b0;

            seq_item_port.item_done();

            // ensure b2b transfers
            if(wait_for_edge) begin
                wait_for_edge = 1'b0;
                fork
                    #1 wait_for_edge = 1'b1;
                join_none
            end
        end
    endtask

    task monitor_reset();
        @(negedge vif.presetn);
    endtask

    function void reset_interface();
        vif.psel    <= '0;
        vif.penable <= '0;
        vif.paddr   <= '0;
        vif.pwrite  <= '0;
        vif.pwdata  <= '0;
    endfunction

endclass
