# 📚 RISC-V Assembly — First Year Examples

A collection of **RISC-V assembly programs** written during the first year of computer engineering.
Organized by topic so other students can find examples quickly and learn step by step.

> **Simulator used:** [RARS](https://github.com/TheThirdOne/rars) — RISC-V Assembler and Runtime Simulator  
> All programs are written for **RV32I** (32-bit RISC-V) and tested in RARS.

---

## 🗂️ Repository structure

```
riscv-assembly-examples/
│
├── 01_basics/               ← Start here! Arithmetic, loops, conditions, classic algorithms
├── 02_memory_and_data/      ← Load/store, data types, bitwise operations
├── 03_arrays_and_strings/   ← Array traversal, sorting, string manipulation
├── 04_peripherals_and_io/   ← Sensors, displays, keypad, conveyor belt, fingerprint reader
├── 05_graphics/             ← Drawing pixels, boxes, triangles on the Bitmap Display
├── 06_sprites_and_animation/← Pac-Man! Sprite rendering (bitwise & full-color)
└── 07_interactive/          ← Real-time D-PAD input — painting, moving shapes
```

Each folder has its own `README.md` explaining the concepts and what each file teaches.

---

## 🚀 Getting started

### 1. Install RARS
Download the latest `.jar` from [github.com/TheThirdOne/rars/releases](https://github.com/TheThirdOne/rars/releases)  
Run with: `java -jar rars.jar`

### 2. Open a file
`File → Open` → navigate to any `.s` file in this repo

### 3. Run it
- Press **F3** to assemble
- Press **F5** to run
- Use the **Bitmap Display** or **Console** tool to see output

---

## 📖 Suggested learning path

| Step | Folder | What you'll learn |
|------|--------|--------------------|
| 1 | `01_basics` | Registers, arithmetic, loops, conditions, algorithms |
| 2 | `02_memory_and_data` | How memory works, `.data` section, load/store |
| 3 | `03_arrays_and_strings` | Pointer arithmetic, arrays, strings |
| 4 | `04_peripherals_and_io` | Talking to hardware via memory-mapped I/O |
| 5 | `05_graphics` | Drawing on a pixel display |
| 6 | `06_sprites_and_animation` | Sprite rendering techniques |
| 7 | `07_interactive` | Real-time input + graphics = mini games |

---

## 📂 Full file index

### `01_basics/`
| File | Description |
|------|-------------|
| `01_basic_arithmetic_operations.s` | Add, subtract, multiply registers; print the result |
| `02_if_else_conditional_branch.s` | Simple `if / else` using branch instructions |
| `03_for_loop_template.s` | Template skeleton for a `for` loop |
| `04_while_loop_basic.s` | Basic `while` loop with `bnez` |
| `05_while_loop_array_access.s` | While loop reading elements from an array |
| `06_countdown_liftoff.s` | Countdown 10→0, prints "Liftoff!" |
| `07_countdown_liftoff_improved.s` | Cleaner version with better formatting |
| `08_digital_clock_display.s` | Simulates a MM:SS clock in the console |
| `09_factorial_iterative.s` | Computes 5! iteratively |
| `10_fibonacci_sequence.s` | Prints the first 9 Fibonacci numbers |
| `11_multiplication_table.s` | Multiplication table for any number |
| `12_multiplication_table_v2.s` | Alternative multiplication table |

### `02_memory_and_data/`
| File | Description |
|------|-------------|
| `01_load_add_store_basic.s` | Load two values from memory, add them, store result |
| `02_load_different_data_sizes.s` | Load `.word`, `.half`, `.byte` — shows sign extension |
| `03_load_data_sizes_extended.s` | Extended: sums all loaded values |
| `04_compare_variables_store_result.s` | Compare two variables, store 5 (equal) or 1 (not equal) |
| `05_address_arithmetic.s` | Compute a memory address by adding two offsets |
| `06_add_two_numbers_in_memory.s` | Load two numbers from `.data`, add, store back |
| `07_bitwise_or_and_mask.s` | Set bits with `ori`, clear bits with `andi` + mask |
| `08_byte_by_byte_comparison.s` | Compare two 32-bit values one byte at a time |
| `09_five_memory_exercises.s` | Five short memory exercises in one file |

### `03_arrays_and_strings/`
| File | Description |
|------|-------------|
| `01_find_max_in_array.s` | Find the largest value in a byte array |
| `02_find_max_and_its_position.s` | Find the max value *and* its index — uses a subroutine |
| `03_find_max_in_vector_verbose.s` | Same with extra print output for clarity |
| `04_copy_array_to_another.s` | Copy a byte array to a second buffer |
| `05_copy_array_with_print.s` | Copy + print each element step by step |
| `06_sort_vector_find_highest.s` | Bubble sort a vector and find the highest element |
| `07_palindrome_check_and_uppercase.s` | Check palindrome + convert string to uppercase |

### `04_peripherals_and_io/`
| File | Description |
|------|-------------|
| `01_read_system_time_hhmmss.s` | Get system time (ms), convert to HH:MM |
| `02_dpad_keypad_input_reader.s` | Poll D-PAD and print which key is pressed |
| `03_automatic_door_controller.s` | Sensor-triggered door with time validation |
| `04_fingerprint_scanner_stub.s` | Minimal fingerprint reader skeleton |
| `05_fingerprint_door_security.s` | Full fingerprint security: scan → validate → open → log |
| `06_supermarket_conveyor_belt.s` | Control a conveyor belt via memory-mapped I/O |
| `07_money_counter_with_sensor.s` | Count bills with a sensor, reset on button press |
| `08_money_counter_with_display.s` | Same counter + graphical display |
| `09_led_matrix_fill_with_color.s` | Fill an LED matrix with a solid color |
| `10_airplane_gps_waypoint_distance.s` | Calculate total flight distance over GPS waypoints |

### `05_graphics/`
| File | Description |
|------|-------------|
| `01_plot_pixel_and_box_on_screen.s` | Core routines: `PlotPixel`, `PlotBox`, `FillScreen` |
| `02_plot_box_and_triangle.s` | Adds `PlotTriangle` (triangle growing wider downward) |
| `03_plot_shapes_with_functions.s` | Calls shape functions with `a0-a4` argument convention |
| `04_draw_upward_and_downward_triangle.s` | Two triangle variants: pointing up and pointing down |
| `05_draw_cross_shapes_on_screen.s` | Draw cross (+) shapes at various positions and sizes |
| `06_draw_cross_shapes_exam_version.s` | Exam version of the cross drawing |
| `07_draw_face_using_shapes.s` | Compose a face from eyes, nose, mouth using shape functions |

### `06_sprites_and_animation/`
| File | Description |
|------|-------------|
| `01_pacman_ghost_sprite_8x8.s` | Draw 8×8 Pac-Man and Ghost using bitwise sprite data |
| `02_pacman_ghost_multiple_sprites.s` | Draw both sprites at different screen positions |
| `03_pacman_sprite_improved.s` | Pac-Man with better positioning and movement |
| `04_pacman_sprite_bitwise_render.s` | Bitwise renderer loop: each bit of a row byte = one pixel |
| `05_large_color_sprite_data.s` | Full 42×60 ARGB color sprite with 3 animation frames |

### `07_interactive/`
| File | Description |
|------|-------------|
| `01_hand_painting_with_dpad.s` | Move a cursor with the D-PAD and paint pixels on screen |
| `02_move_triangle_up_down_dpad.s` | Triangle moves up/down in response to D-PAD presses |

---

## 🛠️ Quick RISC-V cheat sheet

```asm
# Load / Store
la  t0, label       # load address of label
lw  t1, 0(t0)       # load word (32-bit) from memory
lb  t1, 0(t0)       # load byte (sign-extended)
sw  t1, 0(t0)       # store word to memory

# Arithmetic
add  t2, t0, t1     # t2 = t0 + t1
addi t2, t0, 5      # t2 = t0 + 5  (immediate)
sub  t2, t0, t1     # t2 = t0 - t1
mul  t2, t0, t1     # t2 = t0 * t1
div  t2, t0, t1     # t2 = t0 / t1
rem  t2, t0, t1     # t2 = t0 % t1

# Branches (conditional jump)
beq  t0, t1, label  # jump if t0 == t1
bne  t0, t1, label  # jump if t0 != t1
blt  t0, t1, label  # jump if t0 < t1  (signed)
bge  t0, t1, label  # jump if t0 >= t1 (signed)
beqz t0, label      # jump if t0 == 0
bnez t0, label      # jump if t0 != 0
j    label          # unconditional jump

# Functions
call label          # call subroutine (saves return address in ra)
ret                 # return from subroutine (jumps to ra)

# Common syscalls (ecall)
# a7 = syscall number, arguments in a0, a1, ...
li a7, 1  ; ecall  # print integer (a0 = value)
li a7, 4  ; ecall  # print string  (a0 = address)
li a7, 10 ; ecall  # exit program
li a7, 11 ; ecall  # print character (a0 = ASCII code)
li a7, 30 ; ecall  # get system time in ms → a0
```

---

## 📝 Notes for students

- **`-Copy` files** from the original folder are **not included** — they were just backups.
- Some programs require RARS peripherals enabled:
  - *Bitmap Display* (for graphics programs)
  - *Digital Lab Sim* or *Keyboard and Display MMIO Simulator* (for I/O programs)
- The simulator addresses (like `0xffff6000`) are RARS-specific — they will differ on real hardware.
- Comments are in English and Spanish in some files — both are valid!

---

## 🤝 Contributing

Found a bug or want to add an example?
1. Fork the repo
2. Add your `.s` file in the right topic folder
3. Open a pull request with a short description

---

*Made with ❤️ during first year Computer Engineering — shared so others can learn faster.*
