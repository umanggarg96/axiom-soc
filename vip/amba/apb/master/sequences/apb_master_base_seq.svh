class apb_master_base_seq extends uvm_sequence;
    `uvm_object_utils(apb_master_base_seq)

    function new(string name="apb_master_base_seq");
        super.new(name);
    endfunction

    task read(bit [31:0] addr, output bit [31:0] data);
        apb_master_txn txn = apb_master_txn::type_id::create("txn");
        start_item(txn);
        txn.addr = addr;
        txn.is_write = 0;
        finish_item(txn);
        data = txn.data;
    endtask

    task write(bit [31:0] addr, bit [31:0] data);
        apb_master_txn txn = apb_master_txn::type_id::create("txn");
        start_item(txn);
        txn.addr = addr;
        txn.is_write = 1;
        txn.data = data;
        finish_item(txn);
    endtask

endclass
