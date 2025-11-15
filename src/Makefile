LIB = specs.vh tools.v
SOURCE_FILES = ./alu/alu.v pipeline.v test.v  
SOURCE_ALU = ./alu/alu.v ./alu/alu_test.v

define context_rule
	./compose.sh $1 $(LIB) -o $2
endef 

context: $(SOURCE_FILES) $(LIB)
	$(call context_rule, $(SOURCE_FILES), context)

context_alu: $(SOURCE_ALU) $(LIB)
	$(call context_rule, $(SOURCE_ALU), context_alu)

run: $(SOURCE_FILES) $(LIB)
	iverilog -g2012 -o run $(SOURCE_FILES) $(LIB)

run_alu: $(SOURCE_ALU) $(LIB)
	iverilog -g2012 -o run_alu $(SOURCE_ALU) $(LIB)

.PHONY: test_all test_alu clean context context_alu

test_all: run run_alu
	vvp run
	vvp run_alu

test_alu: run_alu
	vvp run_alu

clean:
	rm -f run run_alu context context_alu