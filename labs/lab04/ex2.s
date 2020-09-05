.data
source: # 数组地址 开始初始化
    .word   3  
    .word   1
    .word   4
    .word   1
    .word   5
    .word   9
    .word   0
dest:  # 默认 初始化为0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0

.text
main:
    addi t0, x0, 0 # t0 = 0  (t0 rep k)
    addi s0, x0, 0 # s0 = 0  (s0 rep sum)
    la s1, source # s1  = address of  array source
    la s2, dest # s2 = address of array dest
loop:
    slli s3, t0, 2  # s3 = t0 << 2  equals * 4 due to byte addressed  (calculate the real offset)
    add t1, s1, s3 # t1 eauals a pointer to source
    lw t2, 0(t1) # t2=source[k]
    beq t2, x0, exit
    add a0, x0, t2 # pass the  augs
    addi sp, sp, -8 # two words
    sw t0, 0(sp)
    sw t2, 4(sp)
    jal square
    lw t0, 0(sp)
    lw t2, 4(sp)
    addi sp, sp, 8 # release stack
    add t2, x0, a0 # t2 = fun(source[k])
    add t3, s2, s3  #  t3 = address dest[k]
    sw t2, 0(t3) # dest[k]  = fun(source[k])
    add s0, s0, t2 # sum += dest[k]
    addi t0, t0, 1 # k++
    jal x0, loop
square:
    add t0, a0, x0  # t0 = source[k]
    add t1, a0, x0 #t1 = source[k]
    addi t0, t0, 1 # t0++
    addi t2, x0, -1 # t2 = -1
    mul t1, t1, t2 # -1 * source[k]
    mul a0, t0, t1 # ~ * (source[k]++)
    jr ra #back
exit:
    add a0, x0, s0
    add a1, x0, x0
    ecall # Terminate ecall