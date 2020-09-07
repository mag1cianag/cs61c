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
    addi t0,x0,1
    beq a0,t0, endif
    addi sp,sp,-8
    sw ra ,4(sp)
    sw a0,0(sp)
    addi a0,a0,-1
    jal ra, factorial
    lw t1,0(sp)
    lw ra,4(sp)
    mul a0,a0,t1
    addi sp,sp,8
    ret
    endif:
    addi a0,x0,1
    ret