class apb_master_txn extends uvm_sequence_item;

    bit [31:0] addr;
    bit        is_write;
    bit [31:0] data;    

    // read-only
    bit        is_error;

    `uvm_object_utils_begin(apb_master_txn)
        `uvm_field_int(addr,      UVM_ALL_ON)
        `uvm_field_int(is_write,  UVM_ALL_ON)
        `uvm_field_int(data,      UVM_ALL_ON)
        `uvm_field_int(is_error,  UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name="apb_master_seq");
        super.new(name);
    endfunction

endclass
