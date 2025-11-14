LIB = specs.vh tools.v
SOURCE_FILES = alu.v pipeline.v test.v  

run: $(SOURCE_FILES) $(LIB)
	iverilog -g2012 -o run $(SOURCE_FILES) $(LIB)

context: $(SOURCE_FILES) $(LIB)
	./compose.sh $(SOURCE_FILES) $(LIB) -o context

.PHONY: test_all

test_all: run
	vvp run

