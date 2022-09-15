class pwm_basic_seq extends uvm_sequence;
    `uvm_object_utils(pwm_basic_seq)

    function new(string name="pwm_basic_seq");
        super.new(name);
    endfunction

    task body();
        begin
            apb_master_base_seq seq = apb_master_base_seq::type_id::create("seq");
            seq.set_sequencer(m_sequencer);

            begin
                bit [31:0] addr;
                bit [15:0] wdata, rdata;
                addr = 32'h0;
                wdata = $urandom();
                seq.write(addr, wdata);
                seq.read(addr, rdata);
                if(wdata != rdata)
                    `uvm_error(get_type_name(), $psprintf("data mismatch. Exp: %8h Act: %8h", wdata, rdata))
            end
            #10000;
        end
    endtask

endclass
