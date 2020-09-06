.globl factorial

.data
n: .word 8

.text
main:
    la t0, n   # t0 = address of 8
    lw a0, 0(t0) # a0 = 8
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    # YOUR CODE HERE
    addi sp,sp -4
    sw s0,0(sp)
    addi s0,x0,1
    beq a0,s0, endif
    else:
    addi sp,sp,-12
    sw ra ,8(sp)
    sw a0,4(sp)
    sw a1,0(sp)
    addi a0,a0,-1
    jal ra, factorial
    mul a1,s0,a1
    lw a1,0(sp)
    lw a0,4(sp)
    lw ra,8(sp)
    addi sp,sp,12
    ret
    endif:
    addi a1,x0,1
    lw s0,0(sp)
    ret