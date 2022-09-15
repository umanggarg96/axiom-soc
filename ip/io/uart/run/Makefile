# AXIOM_HOME env-variables should be set

IP_DIR=$(AXIOM_HOME)/ip
IO_DIR=$(IP_DIR)/io
UART_DIR=$(IO_DIR)/uart
RTL_DIR=$(UART_DIR)/rtl
TB_DIR=$(UART_DIR)/tb

TOP_DIR=$(TB_DIR)/top
TEST_DIR=$(TB_DIR)/test
ENV_DIR=$(TB_DIR)/env
SEQ_DIR=$(TB_DIR)/sequence

VIP_DIR=$(AXIOM_HOME)/vip
AMBA_VIP_DIR=$(VIP_DIR)/amba
APB_VIP_DIR=$(AMBA_VIP_DIR)/apb

.PHONY: compile sim clean all

compile:
	vlog $(APB_VIP_DIR)/axiom_apb_pkg.sv
	vlog $(ENV_DIR)/env_pkg.sv
	vlog $(SEQ_DIR)/seq_pkg.sv
	vlog $(TEST_DIR)/test_pkg.sv
	vlog $(RTL_DIR)/uart.sv
	vlog $(TOP_DIR)/top.sv

all: compile sim

sim:
	vsim -c top +UVM_TESTNAME=test_base -do "run -a ; q"  

clean:
	rm -rf transcript work
