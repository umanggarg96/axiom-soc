class basic_test extends test_base;
    `uvm_component_utils(basic_test)

    function new(string name="basic_test", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info("TEST_BASE", "Start of run_phase", UVM_NONE)
        begin
            pwm_basic_seq seq = pwm_basic_seq::type_id::create("seq");
            seq.start(m_env.apb_master.seqnr);
        end
        `uvm_info("TEST_BASE", "End of run_phase", UVM_NONE)
        phase.drop_objection(this);
    endtask

endclass
