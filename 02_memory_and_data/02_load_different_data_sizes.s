.data
data_32: .word 0xBADA714E
data_16: .half 0xDEAD, 0xBEEF
data_08: .byte 0x12, 0x34, 0x56, 0x78
result:  .word 0

.text
main:
    # Load 32-bit data
    la t0, data_32
    lw t1, 0(t0) 

    # Load 16-bit data (first half)
    la t0, data_16
    lh t2, 0(t0)  # Load lower half (0xDEAD)
    lh t3, 2(t0)  # Load upper half (0xBEEF)

    # Load 8-bit data
    la t0, data_08
    lbu t4, 0(t0)  # Load first byte (0x12)
    lbu t5, 1(t0)  # Load second byte (0x34)
    lbu t6, 2(t0)  # Load third byte (0x56)
    lbu s1, 3(t0)  # Load fourth byte (0x78)

    # Sum all values
    add s0, t1, t2  # data_32 + first half of data_16
    add s0, s0, t3  # + second half of data_16
    add s0, s0, t4  # + first byte of data_08
    add s0, s0, t5  # + second byte of data_08
    add s0, s0, t6  # + third byte of data_08
    add s0, s0, s1  # + fourth byte of data_08

    # Store result in memory
    la t0, result
    sw s0, 0(t0)

    # Exit
    addi a7, zero, 10
    ecall
