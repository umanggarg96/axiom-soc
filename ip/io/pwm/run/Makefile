# AXIOM_HOME env-variables should be set

IP_DIR=$(AXIOM_HOME)/ip
IO_DIR=$(IP_DIR)/io
PWM_DIR=$(IO_DIR)/pwm
RTL_DIR=$(PWM_DIR)/rtl
TB_DIR=$(PWM_DIR)/tb

TOP_DIR=$(TB_DIR)/top
TEST_DIR=$(TB_DIR)/tests
ENV_DIR=$(TB_DIR)/env
SEQ_DIR=$(TB_DIR)/sequences

VIP_DIR=$(AXIOM_HOME)/vip
AMBA_VIP_DIR=$(VIP_DIR)/amba
APB_VIP_DIR=$(AMBA_VIP_DIR)/apb

.PHONY: compile sim clean all

compile:
	vlog $(APB_VIP_DIR)/axiom_apb_pkg.sv
	vlog $(ENV_DIR)/env_pkg.sv
	vlog $(SEQ_DIR)/seq_pkg.sv
	vlog $(TEST_DIR)/test_pkg.sv
	vlog $(RTL_DIR)/pwm.sv
	vlog $(TOP_DIR)/top.sv

all: compile sim

sim:
	vsim -c top +UVM_TESTNAME=basic_test -do "run -a ; q"  

clean:
	rm -rf transcript work
