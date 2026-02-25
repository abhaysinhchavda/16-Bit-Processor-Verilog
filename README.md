# 16-Bit Processor Design using Verilog HDL

> **Bachelor's Degree Final Year Project**
>
> **Author:** Abhaysinh Chavda
>
> **Organization:** Eitra

---

## Overview

A fully functional **16-bit processor** designed and simulated using **Verilog HDL**. The processor follows a multi-cycle architecture with separate data path and control unit, supporting arithmetic, logical, memory, branch, and immediate instructions. Each module has been individually verified through dedicated test benches and waveform analysis.

---

## Architecture

The processor is organized around two main blocks — the **Control Unit** (FSM-based) and the **Data Path** — interconnected via control and data signals.

### Block Diagram

```
                         ┌───────────────────────────────────┐
                         │          Control Unit (FSM)        │
                         │  (Decode, State Machine, Signals)  │
                         └──────────┬────────────┬───────────┘
                                    │ Control     │ Status
                                    │ Signals     │ Flags
                         ┌──────────▼────────────▼───────────┐
                         │            Data Path               │
                         │                                    │
                         │  ┌──────┐  ┌────────────────┐     │
                         │  │  PC  │─▶│ Instruction Mem│     │
                         │  └──────┘  └───────┬────────┘     │
                         │                    │ inst          │
                         │  ┌─────────────────▼──────────┐   │
                         │  │       Register File        │   │
                         │  │      (32 x 16-bit)         │   │
                         │  └──────┬──────────┬──────────┘   │
                         │         │          │              │
                         │    ┌────▼──┐  ┌────▼──┐           │
                         │    │MUX2x1 │  │MUX2x1 │           │
                         │    └────┬──┘  └────┬──┘           │
                         │         │          │              │
                         │         ▼          ▼              │
                         │     ┌──────────────────┐          │
                         │     │   ALU (16-bit)   │          │
                         │     └────────┬─────────┘          │
                         │              │                    │
                         │    ┌─────────▼─────────┐          │
                         │    │  Status Register  │          │
                         │    │   [S Z N V C]     │          │
                         │    └───────────────────┘          │
                         │                                    │
                         │    ┌────────────────────┐          │
                         │    │   Data Memory      │          │
                         │    │   (32 x 16-bit)    │          │
                         │    └────────────────────┘          │
                         └────────────────────────────────────┘
```

---

## Instruction Set Architecture (ISA)

### Instruction Format (16-bit)

| Field    | Bits     | Description             |
|----------|----------|-------------------------|
| Opcode   | [15:10]  | Operation code (6 bits) |
| Dest/Src | [9:5]    | Destination / Address   |
| Src/Imm  | [4:0]    | Source / Immediate      |

### Supported Instructions

| Category          | Mnemonic | Opcode     | Description                         |
|-------------------|----------|------------|-------------------------------------|
| **Memory**        | LD       | `000_000`  | Load from data memory to register   |
|                   | ST       | `000_001`  | Store from register to data memory  |
| **Register Arith**| ADD      | `001_001`  | Add two registers                   |
|                   | SUB      | `001_010`  | Subtract two registers              |
|                   | XOR      | `001_011`  | Bitwise XOR                         |
|                   | AND      | `001_100`  | Bitwise AND                         |
|                   | OR       | `001_101`  | Bitwise OR                          |
|                   | CMP      | `001_110`  | Compare two registers               |
|                   | MUL      | `001_111`  | Multiply two registers              |
|                   | MOV      | `001_000`  | Move register to register           |
| **Immediate**     | MOVi     | `010_000`  | Move immediate value to register    |
|                   | ADDi     | `010_001`  | Add immediate to register           |
|                   | SUBi     | `010_010`  | Subtract immediate from register    |
|                   | XORi     | `010_011`  | XOR with immediate                  |
|                   | ANDi     | `010_100`  | AND with immediate                  |
|                   | ORi      | `010_101`  | OR with immediate                   |
|                   | CMPi     | `010_110`  | Compare with immediate              |
| **Single Reg**    | NEG      | `011_000`  | Two's complement negate             |
|                   | COM      | `011_001`  | One's complement                    |
|                   | SRL      | `011_010`  | Shift right logical                 |
|                   | SLL      | `011_011`  | Shift left logical                  |
|                   | DEC      | `011_100`  | Decrement by 1                      |
|                   | INC      | `011_101`  | Increment by 1                      |
|                   | ASR      | `011_110`  | Arithmetic shift right              |
|                   | CLR      | `011_111`  | Clear register                      |
| **Branch**        | JMP      | `100_000`  | Unconditional jump                  |
|                   | BRZ      | `100_001`  | Branch if Zero flag set             |
|                   | BRN      | `100_010`  | Branch if Negative flag set         |
|                   | BRC      | `100_011`  | Branch if Carry flag set            |
|                   | BRV      | `100_100`  | Branch if Overflow flag set         |

### Status Flags — `[S Z N V C]`

| Bit | Flag | Description        |
|-----|------|--------------------|
| 4   | S    | Sign flag          |
| 3   | Z    | Zero flag          |
| 2   | N    | Negative flag      |
| 1   | V    | Overflow flag      |
| 0   | C    | Carry flag         |

---

## Module Description

| Module                     | File                           | Description                                              |
|----------------------------|--------------------------------|----------------------------------------------------------|
| **Top Module**             | `top_module_16_bit_processor.v`| Top-level integration of Control Unit and Data Path      |
| **Control Unit**           | `control_unit.v`               | FSM-based controller — fetch, decode, execute, writeback |
| **Data Path**              | `data_path.v`                  | Interconnects ALU, registers, memory, MUXes, and PC      |
| **ALU**                    | `alu.v`                        | 16-bit ALU supporting arithmetic, logical, and shift ops |
| **Program Counter**        | `program_counter.v`            | 16-bit PC with reset and load capability                 |
| **Instruction Memory**     | `instruction_memory.v`         | ROM storing the instruction set for execution            |
| **Data Memory**            | `data_memory.v`                | 32 x 16-bit read/write data memory                      |
| **Register File**          | `register_file.v`              | 32 x 16-bit general-purpose register file                |
| **2x1 MUX**               | `mux_2x1.v`                    | 2-to-1 multiplexer for data selection                    |
| **4x1 MUX**               | `mux_4x1.v`                    | 4-to-1 multiplexer for register write-back selection     |
| **Sign Extend**            | `sign_extend.v`                | 5-bit to 16-bit sign extension unit                      |
| **Status Register**        | `status_register.v`            | 5-bit status/flag register [S Z N V C]                   |
| **Temp Storage**           | `temp_storage.v`               | Temporary storage register for MOV operations            |
| **Clock**                  | `clock.v`                      | Clock generator module                                   |

---

## FSM States (Control Unit)

The control unit operates through the following states:

```
RESET → FETCH → DECODE → POST_DECODE →
  ├── EXEC_LD / EXEC_ST          → INC_PC → LD_PC → PRE_FETCH → FETCH
  ├── EXEC_B_ARTH / EXEC_IMD_ARTH / EXEC_SR → WB → POST_WB → INC_PC → ...
  ├── EXEC_MOV / EXEC_IMD_MOV   → POST_EXEC_MOV → WB_MOV → POST_WB → INC_PC → ...
  └── EXEC_BR                    → LD_PC → PRE_FETCH → FETCH
```

---

## Project Structure

```
16-Bit-Processor/
├── Design/                             # Verilog source modules
│   ├── alu.v
│   ├── clock.v
│   ├── control_unit.v
│   ├── data_memory.v
│   ├── data_path.v
│   ├── instruction_memory.v
│   ├── mux_2x1.v
│   ├── mux_4x1.v
│   ├── program_counter.v
│   ├── register_file.v
│   ├── sign_extend.v
│   ├── status_register.v
│   ├── temp_storage.v
│   └── top_module_16_bit_processor.v
├── Test_Bench/                         # Test bench for each module
│   ├── alu_tb.v
│   ├── control_unit_tb.v
│   ├── data_memory_tb.v
│   ├── instruction_memory_tb.v
│   ├── mux_2x1_tb.v
│   ├── mux_4x1_tb.v
│   ├── program_counter_tb.v
│   ├── register_file_tb.v
│   ├── sign_extend_tb.v
│   ├── status_register_tb.v
│   ├── temp_storage_tb.v
│   └── top_module_16_bit_processor_tb.v
├── Simulation/                         # Compiled simulation files
│   ├── *.vvp                           # Icarus Verilog compiled output
│   └── *.vcd                           # GTKWave waveform files
├── Document/                           # Block diagram & flow chart
│   ├── 16_bit.odg
│   └── 16_bit_flow_chart.odg
├── SS/                                 # Screenshots
└── README.md
```

---

## Tools & Technologies

| Tool              | Purpose                                      |
|-------------------|----------------------------------------------|
| **Verilog HDL**   | Hardware description language for design      |
| **Icarus Verilog**| Open-source Verilog simulation and synthesis  |
| **GTKWave**       | Waveform viewer for simulation analysis       |

---

## How to Simulate

### Prerequisites

- [Icarus Verilog](http://iverilog.icarus.com/) installed
- [GTKWave](http://gtkwave.sourceforge.net/) installed

### Compile & Run (Example: ALU module)

```bash
# Compile
iverilog -o Simulation/alu.vvp Design/alu.v Test_Bench/alu_tb.v

# Simulate
vvp Simulation/alu.vvp

# View waveform
gtkwave Simulation/alu.vcd
```

### Compile & Run (Top Module — Full Processor)

```bash
# Compile all design files with top module test bench
iverilog -o Simulation/top_module_16_bit_processor.vvp \
    Design/alu.v \
    Design/clock.v \
    Design/control_unit.v \
    Design/data_memory.v \
    Design/data_path.v \
    Design/instruction_memory.v \
    Design/mux_2x1.v \
    Design/mux_4x1.v \
    Design/program_counter.v \
    Design/register_file.v \
    Design/sign_extend.v \
    Design/status_register.v \
    Design/temp_storage.v \
    Design/top_module_16_bit_processor.v \
    Test_Bench/top_module_16_bit_processor_tb.v

# Simulate
vvp Simulation/top_module_16_bit_processor.vvp

# View waveform
gtkwave Simulation/top_module_16_bit_processor.vcd
```

---

## Key Design Features

- **Multi-cycle architecture** — each instruction goes through Fetch, Decode, Execute, and Write-back stages
- **FSM-based control** — clean state machine for instruction sequencing
- **5-bit status flags** — Sign, Zero, Negative, Overflow, and Carry
- **32 general-purpose registers** — 16-bit wide register file
- **Conditional branching** — supports BRZ, BRN, BRC, BRV, and JMP
- **Immediate & register addressing modes**
- **Fully testable** — individual test bench for every module

---

## License

This project is submitted as part of a Bachelor's degree requirement. Feel free to use it for educational and reference purposes.

---

## Author

**Abhaysinh Chavda**

If you have any questions or suggestions, feel free to open an issue or reach out.
