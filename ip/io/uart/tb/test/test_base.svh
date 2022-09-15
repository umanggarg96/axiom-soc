
class test_base extends uvm_test;
    `uvm_component_utils(test_base)

    env m_env;

    function new(string name="test_base", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_env = env::type_id::create("m_env", this);
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info("TEST_BASE", "Start of run_phase", UVM_NONE)
        begin
            uart_base_seq seq = uart_base_seq::type_id::create("seq");
            seq.start(m_env.apb_master.seqnr);
        end
        `uvm_info("TEST_BASE", "End of run_phase", UVM_NONE)
        phase.drop_objection(this);
    endtask

endclass
