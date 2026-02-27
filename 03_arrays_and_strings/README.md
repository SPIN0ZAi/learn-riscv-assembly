# 03 — Arrays & Strings

This folder shows how to work with arrays of bytes and strings in RISC-V.
You will see pointer arithmetic, loops over arrays, sorting, and string operations.

---

## Files

| File | What it teaches |
|------|-----------------|
| `01_find_max_in_array.s` | Iterate a byte array, track the maximum value using `bge` |
| `02_find_max_and_its_position.s` | Find the maximum *and* its index in the array; calls a subroutine |
| `03_find_max_in_vector_verbose.s` | Same idea with extra print output — good for understanding the flow |
| `04_copy_array_to_another.s` | Copy a `.byte` array into a `.zero`-reserved buffer using `lb` / `sb` |
| `05_copy_array_with_print.s` | Copy array and print each element; clearer step-by-step version |
| `06_sort_vector_find_highest.s` | Bubble sort + find highest element + print sorted result (challenging!) |
| `07_palindrome_check_and_uppercase.s` | Check if a string is a palindrome; also converts it to uppercase |

---

## Key concepts

- **Pointer arithmetic:** increment `t0` with `addi t0, t0, 1` to move byte by byte
- **`lb` vs `lbu`:** `lb` sign-extends, `lbu` zero-extends — matters for bytes > 127
- **`sb`** — stores only the lowest byte of a register to memory
- **Subroutine calls:** `call label` / `ret` — the callee uses `a0`/`a1` for return values
- **String termination:** strings end with `\0` (null byte) — check for `beqz` on `lb` result
- **Sorting:** nested loops comparing adjacent elements and swapping — O(n²)
