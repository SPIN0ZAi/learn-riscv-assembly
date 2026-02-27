# 07 — Interactive Programs

These programs react to real-time user input via the **D-PAD peripheral** in RARS.
They combine graphics + input polling in a continuous game loop.

---

## Files

| File | What it teaches |
|------|-----------------|
| `01_hand_painting_with_dpad.s` | Move a cursor with the D-PAD and paint pixels; each direction moves one step |
| `02_move_triangle_up_down_dpad.s` | A triangle moves up/down on screen based on UP/DOWN D-PAD presses |

---

## How the game loop works

```
loop:
    1. Check D-PAD input (lw from D_PAD_0_UP / DOWN / LEFT / RIGHT)
    2. If pressed → clear old position (draw with background color)
    3. Update X/Y coordinates (addi s0, s0, 1 etc.)
    4. Draw shape at new position
    5. Jump back to loop
```

---

## Key concepts

- **D-PAD addresses** — each direction has its own memory-mapped register:
  `D_PAD_0_UP`, `D_PAD_0_DOWN`, `D_PAD_0_LEFT`, `D_PAD_0_RIGHT`
- **`lw t0, D_PAD_0_UP` / `beqz t0, skip`** — poll and ignore if not pressed
- **Erase before redraw** — draw the shape in black first, then draw at new position
- **Boundary clamping** — use `blez` / `bge` to stop movement at screen edges
- **`waitUP` / `waitDOWN` loops** — wait for the button to be released before moving again
  (debouncing — prevents multiple moves per press)
