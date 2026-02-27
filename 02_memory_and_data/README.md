# 02 — Memory & Data

This folder covers how RISC-V programs read from and write to memory,
and how to work with different data sizes and bitwise operations.

---

## Files

| File | What it teaches |
|------|-----------------|
| `01_load_add_store_basic.s` | `la` + `lw` to load values, `add`, then `sw` to store the result |
| `02_load_different_data_sizes.s` | Loading 32-bit (`.word`), 16-bit (`.half`) and 8-bit (`.byte`) data |
| `03_load_data_sizes_extended.s` | Extended version: loads multiple types and sums them all |
| `04_compare_variables_store_result.s` | `bne` to compare two variables and store 1 or 5 based on equality |
| `05_address_arithmetic.s` | Adding two addresses to compute a pointer offset |
| `06_add_two_numbers_in_memory.s` | Load two numbers from `.data`, add them, store back to memory |
| `07_bitwise_or_and_mask.s` | Using `ori` / `andi` to set and clear specific bits in a word |
| `08_byte_by_byte_comparison.s` | Compare two 32-bit values one byte at a time using `lb` |
| `09_five_memory_exercises.s` | Five small memory exercises combined in one file (good for review) |

---

## Key concepts

- **`.data` section** — where you declare variables (`.word`, `.half`, `.byte`, `.zero`)
- **`la rd, label`** — loads the *address* of a label into a register
- **`lw / lh / lb`** — load 32 / 16 / 8 bit signed value from memory
- **`lbu / lhu`** — load unsigned (no sign extension)
- **`sw / sh / sb`** — store 32 / 16 / 8 bit value to memory
- **Offset addressing:** `lw t1, 4(t0)` reads 4 bytes after the address in `t0`
- **Bitwise ops:** `and`, `or`, `xor`, `andi`, `ori`, `xori` — great for bit masks
