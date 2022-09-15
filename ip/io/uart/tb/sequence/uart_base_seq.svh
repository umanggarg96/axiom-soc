class uart_base_seq extends uvm_sequence;
    `uvm_object_utils(uart_base_seq)

    function new(string name="uart_base_seq");
        super.new(name);
    endfunction

    task body();
        begin
            apb_master_base_seq seq = apb_master_base_seq::type_id::create("seq");
            seq.start(m_sequencer);

            repeat(20) begin
                bit [31:0] addr, wdata, rdata;
                addr = $urandom();
                wdata = $urandom();
                seq.write(addr, wdata);
                seq.read(addr, rdata);
                if(wdata != rdata)
                    `uvm_error(get_type_name(), $psprintf("data mismatch. Exp: %8h Act: %8h", wdata, rdata))
            end
        end
    endtask

endclass
