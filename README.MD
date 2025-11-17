# ASIC Demo

Some CPU related components will be presented in the project.

A minimal **pipelined Arithmetic Logic Unit (ALU)** implemented in Verilog(semi System Verilog)

Project includes:
* testbench 
* assertions 
* clean modular structure. 

Designed for learning ASIC design.


## Goals

- testable units
- designed to be easily exntensible
- easy to build and run on any system (docker + Makefile)

## Usage

```
requirements:
1. docker

steps:
make dev-build
make dev

Then inside created container:
cd app
make test_all
make test_rf
make test_alu
```

## 🖼️ Current ALU Overview 

### Scheme 
[here](./scheme.md)

### Supported operation codes:

|code|description|ready|
|----|-|-|
|OP_SUM|+|✅|
|OP_SUB|-|✅|
|OP_AND|&|✅|
|OP_XOR|^|✅|
|OP_NOP|nop|✅|
|OT_INC|+1|🛠️|
|OT_DEC|-1|🛠️|
|OT_MUL|*|🛠️|
|OT_DIV|/|🛠️|
|OT_CMP| > < <= >= |🛠️|
|OT_NOT| ~ |🛠️|
|OT_MOV| [] -> [] |🛠️|
|OT_SHR| 10 -> 01 |🛠️|
|OT_SHL| 10 <- 01 |🛠️|

**WORD** size Dynamicly set through [specs](./src/specs.vh)

## MAJOR TODO

- [ ] more tests
- [ ] more instructions to support
- [ ] control unit
- [x] register file