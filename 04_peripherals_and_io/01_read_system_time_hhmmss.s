#############################
.equ OSExit      10
.equ OSTime      30
.equ OSPrintInt  1
.equ OSPrintChar 11

.text

    li a7, OSTime
    ecall
    mv s0, a0         # move time (ms) to s0

    li t0, 1000
    div s0, s0, t0    # convert ms to seconds

    li t0, 86400      # seconds per day
    rem s0, s0, t0    # seconds in the last day

    # Get hours
    li t0, 3600
    div s1, s0, t0    # s1 = hours (UTC)
    addi a0, s1, 2    # Spain time
    li a7, OSPrintInt
    ecall

    # Print ':'
    li a0, 58         # ASCII for ':'
    li a7, OSPrintChar
    ecall

    # Get minutes
    li t0, 3600
    rem s0, s0, t0    # remaining seconds after hours
    li t0, 60
    div s2, s0, t0    # s2 = minutes
    mv a0, s2
    li a7, OSPrintInt
    ecall

end:
    li a7, OSExit
    ecall
