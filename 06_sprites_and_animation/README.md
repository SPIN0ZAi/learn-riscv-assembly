# 06 — Sprites & Animation

These programs render sprites (pixel art images) on the Bitmap Display.
Two rendering techniques are shown: **bitwise (1-bit)** and **full color (32-bit)**.

---

## Files

| File | What it teaches |
|------|-----------------|
| `01_pacman_ghost_sprite_8x8.s` | Draw 8×8 Pac-Man and Ghost sprites using `PlotSprite8x8`; calls `FillScreen` first |
| `02_pacman_ghost_multiple_sprites.s` | Draw multiple 8×8 sprites at different positions on screen |
| `03_pacman_sprite_improved.s` | Pac-Man moves across the screen; better movement logic |
| `04_pacman_sprite_bitwise_render.s` | Renders sprites using bitwise row data — each bit = one pixel (compact format) |
| `05_large_color_sprite_data.s` | Full 42×60 color sprite stored as `.word` ARGB data (3 animation frames) |

---

## Sprite formats

### Bitwise (1-bit per pixel)
```asm
packman:
    .byte 0b00111100   # each bit is one pixel (0=transparent, 1=color)
    .byte 0b01111110
    ...
```
The renderer loops over each bit with `slli` / `andi` to decide whether to call `PlotPixel`.

### Full color (32-bit per pixel)
```asm
.word 0xff000000   # black (opaque)
.word 0xffffff00   # yellow
.word 0x00000000   # transparent (alpha = 0)
```
Each `.word` maps directly to one pixel — just `sw` it to the display address.

---

## Key concepts

- **`PlotSprite8x8`** — subroutine that takes `(posX, posY, spriteAddr, color)` and plots an 8×8 sprite
- **Bitwise loop:** `srli t0, row, bit_index` then `andi t0, t0, 1` to test each pixel
- **Animation frames:** multiple sprite frames stored consecutively; switch by advancing the data pointer
- **`slli` trick:** multiply index by row width to jump to the right row in sprite data
