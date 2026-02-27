# 05 — Graphics

These programs draw shapes and graphics on the simulated **Bitmap Display** in RARS.

> **How it works:** The display is a grid of pixels. Each pixel is a 32-bit ARGB color
> stored at a memory address. Writing `0xffff0000` (red) to an address lights up that pixel.

---

## Files

| File | What it teaches |
|------|-----------------|
| `01_plot_pixel_and_box_on_screen.s` | Core graphics functions: `PlotPixel`, `PlotBox`, `FillScreen` |
| `02_plot_box_and_triangle.s` | Extends graphics with a `PlotTriangle` function (nested row/column loops) |
| `03_plot_shapes_with_functions.s` | Calls `PlotTriangle` and `PlotBox` as reusable subroutines with arguments in `a0-a4` |
| `04_draw_upward_and_downward_triangle.s` | Two triangle functions: one that grows wider going down, one that shrinks |
| `05_draw_cross_shapes_on_screen.s` | Draws cross (plus sign) shapes at different positions using `PlotCross` |
| `06_draw_cross_shapes_exam_version.s` | Same cross drawing — exam submission version |
| `07_draw_face_using_shapes.s` | Draws a smiley face by composing eyes, nose, and mouth from `PlotBox` / `PlotTriangle` |

---

## Key concepts

- **Pixel address formula:**
  `address = DISPLAY_BASE + (y * WIDTH + x) * 4`
- **Color format:** `0xAARRGGBB` — e.g. `0xff00ff00` = fully opaque green
- **`FillScreen`** — fills the whole display with one color (fastest way to clear screen)
- **Passing arguments to functions:**
  `a0` = X, `a1` = Y, `a2` = width, `a3` = height, `a4` = color (by convention in these files)
- **Nested loops for shapes:** outer loop = rows (Y), inner loop = columns (X)
- **`call` / `ret`** — calling a drawing function and returning from it

---

## Color constants used

```asm
.equ COLOR_BLACK,   0xff000000
.equ COLOR_RED,     0xffff0000
.equ COLOR_GREEN,   0xff00ff00
.equ COLOR_YELLOW,  0xffffff00
.equ COLOR_BLUE,    0xff0000ff
.equ COLOR_WHITE,   0xffffffff
```
