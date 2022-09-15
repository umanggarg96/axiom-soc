class apb_master_agent extends uvm_agent;
    `uvm_component_utils(apb_master_agent);

    apb_master_driver drv;
    apb_master_sequencer seqnr;
    virtual axiom_apb_interface vif;
    
    // TODO: add monitor

    function new(string name="apb_master_agent", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!vif)
            `uvm_fatal(get_type_name(), "Null vif passed")

        drv = apb_master_driver::type_id::create("drv", this);
        drv.vif = vif;
        seqnr = apb_master_sequencer::type_id::create("seqnr", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(seqnr.seq_item_export);
    endfunction
endclass
