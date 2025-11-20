MAKEFLAGS += --warn-undefined-variables

LIB = specs.vh tools.v
SOURCE_ALU = ./alu/alu.v ./alu/alu_test.v
SRC_RF = ./register_file/register_file.v ./register_file/register_file_test.v
SOURCE_FILES = $(SOURCE_ALU) $(SRC_RF) rom.v pc.v cpu.v control_unit.v # pipeline.v test.v  

define context_rule
	./compose.sh $1 $(LIB) -o $2
endef 

.PHONY: test_all test_alu test_rf clean context context_alu

context: $(SOURCE_FILES) $(LIB)
	$(call context_rule, $(SOURCE_FILES), context)

context_alu: $(SOURCE_ALU) $(LIB)
	$(call context_rule, $(SOURCE_ALU), context_alu)

context context_alu: compose.sh

test_all: test_alu test_rf
	@echo "all test execution"

test_alu: $(SOURCE_ALU) $(LIB)
	iverilog -g2012 -o run_alu $(SOURCE_ALU) $(LIB)
	vvp run_alu

test_rf: $(SRC_RF) $(LIB)
	iverilog -g2012 -o run_rf $(SRC_RF) $(LIB)
	vvp run_rf


clean:
	rm -f run run* context context*