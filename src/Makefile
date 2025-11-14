LIB = specs.vh tools.v
SOURCE_FILES = ./alu/alu.v pipeline.v test.v  
SOURCE_ALU = ./alu/alu.v ./alu/alu_test.v

run: $(SOURCE_FILES) $(LIB)
	iverilog -g2012 -o run $(SOURCE_FILES) $(LIB)

run_alu: $(SOURCE_ALU) $(LIB)
	iverilog -g2012 -o run_alu $(SOURCE_ALU) $(LIB)

context: $(SOURCE_FILES) $(LIB)
	./compose.sh $(SOURCE_FILES) $(LIB) -o context

.PHONY: test_all test_alu clean

test_all: run run_alu
	vvp run
	vvp run_alu

test_alu: run_alu
	vvp run_alu

clean:
	rm -f run run_alu