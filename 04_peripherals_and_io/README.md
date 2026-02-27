# 04 — Peripherals & I/O

These programs interact with simulated hardware peripherals:
sensors, displays, door locks, keypads, conveyor belts, LED matrices, and GPS.

> All programs target the **RARS** simulator with its built-in I/O peripherals.

---

## Files

| File | What it teaches |
|------|-----------------|
| `01_read_system_time_hhmmss.s` | `ecall 30` (OSTime) → convert ms to HH:MM format using `div` and `rem` |
| `02_dpad_keypad_input_reader.s` | Poll the D-PAD peripheral; detect UP / DOWN / LEFT / RIGHT presses |
| `03_automatic_door_controller.s` | Read a door sensor, validate time window, open/close door with delay |
| `04_fingerprint_scanner_stub.s` | Skeleton: Reset bit, read fingerprint port, validate, open door |
| `05_fingerprint_door_security.s` | Full fingerprint security system: scan → validate → open → log in memory |
| `06_supermarket_conveyor_belt.s` | Control a belt motor via memory-mapped I/O; detect/react to objects |
| `07_money_counter_with_sensor.s` | Read bill sensor (`ecall 201`), count bills and sum money; reset on button |
| `08_money_counter_with_display.s` | Same counter but also draws a graphical display using PlotBox / FillScreen |
| `09_led_matrix_fill_with_color.s` | Fill an LED matrix row by row by incrementing a base address |
| `10_airplane_gps_waypoint_distance.s` | Compute total flight distance by iterating GPS waypoints via subroutines |

---

## Key concepts

- **Memory-mapped I/O:** peripherals have fixed addresses (e.g. `0xffff6000`)
  — `lw` reads the port state, `sw` writes control bits back
- **Bit isolation:** `andi t0, t0, 0b1` isolates bit 0; shift left/right to check any bit
- **Polling loop:** keep calling `lw` in a loop until the status bit is set
- **`ecall` numbers above 10** are simulator-specific (RARS) for sensors, time, etc.
- **Subroutines (functions):** save/restore `ra` with `sw ra, 0(sp)` / `lw ra, 0(sp)` when calling nested functions
