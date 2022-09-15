class env extends uvm_env;

    `uvm_component_utils(env)

    apb_master_agent apb_master;

    function new(string name="env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        virtual axiom_apb_interface vif;

        super.build_phase(phase);
        `uvm_info("ENV", "Inside build_phase", UVM_NONE)

        apb_master = apb_master_agent::type_id::create("apb_master", this);

        if(!uvm_config_db#(virtual axiom_apb_interface)::get(this, "", "apb_master_if", vif))
            `uvm_fatal("ENV", "Unable to fetch apb_master_if")

        apb_master.vif = vif;
    endfunction

endclass
