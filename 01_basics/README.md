# 01 — Basics

> **Recommended simulator:** [RARS](https://github.com/TheThirdOne/rars) (RISC-V Assembler and Runtime Simulator)

This folder contains the very first programs you should study.
They cover the fundamental building blocks of any RISC-V assembly program.

---

## Files

| File | What it teaches |
|------|-----------------|
| `01_basic_arithmetic_operations.s` | `addi`, `mul`, `sub` on registers; printing an integer result |
| `02_if_else_conditional_branch.s` | `bne` / `j` to implement a simple if/else block |
| `03_for_loop_template.s` | Skeleton of a `for` loop using `blt` and `addi` |
| `04_while_loop_basic.s` | `bnez` / `j` to build a `while` loop |
| `05_while_loop_array_access.s` | While loop that reads elements from an array with pointer arithmetic |
| `06_countdown_liftoff.s` | Countdown from 10 → 0, prints "Liftoff!" — introduces `beq`, `la`, `ecall` |
| `07_countdown_liftoff_improved.s` | Cleaner version of the countdown (better label names, formatted output) |
| `08_digital_clock_display.s` | Simulates a `MM:SS` clock display in the console; shows modulo & leading-zero logic |
| `09_factorial_iterative.s` | Computes `5!` iteratively using a loop and `mul` |
| `10_fibonacci_sequence.s` | Prints the first 9 Fibonacci numbers |
| `11_multiplication_table.s` | Prints the multiplication table for a chosen number |
| `12_multiplication_table_v2.s` | Alternative multiplication table (teacher reference version) |

---

## Key concepts

- **Registers used:** `t0-t6` (temporaries), `s0-s7` (saved), `a0-a7` (arguments / syscalls)
- **`ecall` syscall numbers:**
  - `1` → print integer
  - `4` → print string
  - `10` → exit program
  - `11` → print character
- Loops in RISC-V are written using branch instructions + a `j` (jump) back to the top
- Labels are just addresses — use them freely to name code sections
