############################
# Constants and Definitions
############################
.data
.equ COLOR_BLACK,   0xff000000
.equ COLOR_RED,     0xffff0000
.equ COLOR_GREEN,   0xff00ff00
.equ COLOR_YELLOW,  0xffffff00
.equ COLOR_BLUE,    0xff0000ff
.equ COLOR_MAGENTA, 0xffff00ff
.equ COLOR_CYAN,    0xff00ffff
.equ COLOR_WHITE,   0xffffffff
.equ COLOR_CARNE,   0x00ecd8f2
.equ COLOR_PURPLE,  0x00bb19ff
.equ COLOR_PINK,    0x00FFB8FF
.equ COLOR_ORANGE,  0x00FFB852

.equ OSExit, 10

.text

#################################
# Main Entry Point
#################################
main:
    # Clear screen to black
    li a0, COLOR_BLACK
    call FillScreen

    call CursorDrawings

    j ExitProgram

#################################
# Cursor Drawing with D-PAD
#################################
CursorDrawings:
    li s0, LED_MATRIX_0_WIDTH
    li s1, LED_MATRIX_0_HEIGHT
    srli s0, s0, 1  # s0 = center x
    srli s1, s1, 1  # s1 = center y

loop:
    # Save current pixel color (for restoring later)
    mv a0, s0
    mv a1, s1
    call GetPixelColor  # Returns current pixel color in a0
    mv s3, a0           # Save original color in s3

    # Calculate cursor color based on Switches 0
    li a2, 0xff000000  # Base color (black with full alpha)
    lw t0, SWITCHES_0_BASE

    andi t1, t0, 1
    beqz t1, noBIT0
    li t1, 0x000000ff  # Blue component
    or a2, a2, t1
noBIT0:

    andi t1, t0, 2
    beqz t1, noBIT1
    li t1, 0x0000ff00  # Green component
    or a2, a2, t1
noBIT1:

    andi t1, t0, 4
    beqz t1, noBIT2
    li t1, 0x00ff0000  # Red component
    or a2, a2, t1
noBIT2:

    # If no color selected, use white for cursor
    beq a2, zero, useWhite
    j drawCursor
useWhite:
    li a2, COLOR_WHITE

drawCursor:
    # Draw cursor pixel
    mv a0, s0
    mv a1, s1
    call PlotPixel

    # Check Switch 1 to decide whether to keep the pixel
    lw t0, SWITCHES_1_BASE
    andi t0, t0, 1
    bnez t0, keepPixel  # Switch 1 ON: Keep the white pixel

    # Switch 1 OFF: Restore original pixel color
    mv a0, s0
    mv a1, s1
    mv a2, s3  # Restore original color
    call PlotPixel

keepPixel:
    # Handle D-Pad inputs
    la t0, D_PAD_0_BASE

    # UP
    lw t1, 0(t0)
    beqz t1, noUP
    addi s1, s1, -1
waitUP:
    lw t1, 0(t0)
    bnez t1, waitUP
noUP:

    # DOWN
    lw t1, 4(t0)
    beqz t1, noDOWN
    addi s1, s1, 1
waitDOWN:
    lw t1, 4(t0)
    bnez t1, waitDOWN
noDOWN:

    # LEFT
    lw t1, 8(t0)
    beqz t1, noLEFT
    addi s0, s0, -1
waitLEFT:
    lw t1, 8(t0)
    bnez t1, waitLEFT
noLEFT:

    # RIGHT
    lw t1, 12(t0)
    beqz t1, noRIGHT
    addi s0, s0, 1
waitRIGHT:
    lw t1, 12(t0)
    bnez t1, waitRIGHT
noRIGHT:

    j loop

#################################
# Get Pixel Color
# Inputs:
#   a0: x
#   a1: y
# Outputs:
#   a0: color
#################################
GetPixelColor:
    la t0, LED_MATRIX_0_BASE
    li t1, LED_MATRIX_0_WIDTH
    li t2, LED_MATRIX_0_HEIGHT

    # Bounds check
    bltz a0, EndGPC
    bge a0, t1, EndGPC
    bltz a1, EndGPC
    bge a1, t2, EndGPC

    mul t3, a1, t1
    add t3, t3, a0
    slli t3, t3, 2
    add t3, t0, t3
    lw a0, 0(t3)  # Load pixel color
    ret

EndGPC:
    li a0, COLOR_BLACK  # Return black if out of bounds
    ret

#################################
# Plot a Pixel
# Inputs:
#   a0: x
#   a1: y
#   a2: color
#################################
PlotPixel:
    la t0, LED_MATRIX_0_BASE
    li t1, LED_MATRIX_0_WIDTH
    li t2, LED_MATRIX_0_HEIGHT

    # Bounds check
    bltz a0, EndPP
    bge a0, t1, EndPP
    bltz a1, EndPP
    bge a1, t2, EndPP

    mul t3, a1, t1
    add t3, t3, a0
    slli t3, t3, 2
    add t3, t0, t3
    sw a2, 0(t3)

EndPP:
    ret

#################################
# Fill Screen
# Input:
#   a0: color
#################################
FillScreen:
    la t0, LED_MATRIX_0_BASE
    li t2, LED_MATRIX_0_SIZE

LoopFS:
    sw a0, 0(t0)
    addi t0, t0, 4
    addi t2, t2, -1
    bgtz t2, LoopFS
    ret

#################################
# Exit Program
#################################
ExitProgram:
    li a7, OSExit
    ecall