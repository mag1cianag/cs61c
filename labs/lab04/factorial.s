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
    addi t2  x0 1
    mv t1 a0
    addi t1 t1 -1
loop:
    blt t1 t2  next
    mul a0  a0 t1
    addi t1 t1 -1
    jal x0 loop
next:    
    jr ra