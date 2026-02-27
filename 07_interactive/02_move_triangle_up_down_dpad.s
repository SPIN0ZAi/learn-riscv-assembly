############################
# Constants and Definitions
############################
.data
.equ COLOR_BLACK,   0xff000000
.equ COLOR_WHITE,   0xffffffff

.equ SWITCHES_1_BASE, 0xFF200050


.equ OSExit, 10

.text

#################################
# Main Entry Point
#################################
main:
    # Clear screen to black
    li a0, COLOR_BLACK
    call FillScreen

    li s0, 32     # center x
    li s1, 16     # center y
    li s2, 1      # base width
    li s3, 5      # height

    call TriangleMovement

    j ExitProgram

#################################
# Triangle Drawing with D-PAD
#################################
TriangleMovement:
loop:
    # Erase old triangle
    mv a0, s0
    mv a1, s1
    mv a2, s2
    mv a3, s3
    li a4, COLOR_BLACK
    call DrawTriangle

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

    # Draw new triangle
    mv a0, s0
    mv a1, s1
    mv a2, s2
    mv a3, s3
    li a4, COLOR_WHITE
    call DrawTriangle

    j loop

#################################
# Draw Triangle
# Inputs:
#   a0: x center
#   a1: y start
#   a2: base width
#   a3: height
#   a4: color
#################################
DrawTriangle:
    addi sp, sp, -28
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)

    mv s0, a0  # x center
    mv s1, a1  # y start
    mv s2, a2  # base width
    mv s3, a3  # height
    mv s4, a4  # color

loopCOL:
    mv s5, s2
loopRow:
    mv a0, s0
    mv a1, s1
    mv a2, s4
    call PlotPixel

    addi s0, s0, 1
    addi s5, s5, -1
    bgtz s5, loopRow

    sub s0, s0, s2
    addi s0, s0, -1
    addi s2, s2, 2

    addi s1, s1, 1
    addi s3, s3, -1
    bgtz s3, loopCOL

    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    addi sp, sp, 28
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
