.globl classify

.text
classify:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0 (int)    argc
    #   a1 (char**) argv
    #   a2 (int)    print_classification, if this is zero, 
    #               you should print the classification. Otherwise,
    #               this function should not print ANYTHING.
    # Returns:
    #   a0 (int)    Classification
    # 
    # If there are an incorrect number of command line args,
    # this function returns with exit code 49.
    #
    # Usage:
    #   main.s -m -1 <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>

    li t0 5
    bne a0 t0 exit_49
    # Prologue
    addi sp sp -36
    sw ra 0(sp)
    sw s0 4(sp)
    sw s1 8(sp)
    sw s2 12(sp)
    sw s3 16(sp)
    sw s4 20(sp)
    sw s5 24(sp)
    sw s6 28(sp)
    sw s7 32(sp)


    mv s0 a1 # char**
    mv s1 a2

	# =====================================
    # LOAD MATRICES
    # =====================================

    addi sp sp -24 
    # Load pretrained m0
    lw  a0 4(s0)
    addi a1 sp 0
    addi a2 sp 4
    jal ra read_matrix
    mv s2 a0 # address of m0


    # Load pretrained m1
    lw a0 8(s0)
    addi a1 sp 8
    addi a2 sp 12
    jal ra read_matrix
    mv s3 a0 # address of m1

    # Load input matrix
    lw a0 12(s0)
    addi a1 sp 16
    addi a2 sp 20
    jal ra read_matrix
    mv s4 a0 # address of input matreix



    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)

    # m0 * input
    lw t0 0(sp) # m0's row
    lw t3 20(sp) # input's col

    mul s5 t0 t3 # size
    slli a0 s5 2 # bytes
    jal ra malloc
    mv  s6 a0 # address of hidden

    lw t0 0(sp) # m0's row
    lw t1 4(sp) # m0's col
    lw t2 16(sp) # input's row
    lw t3 20(sp) # input's col

    mv a0 s2
    mv a1 t0
    mv a2 t1
    mv a3 s4
    mv a4 t2
    mv a5 t3
    mv a6 s6
    jal ra matmul



    # relu(hidden)
    mv a0 s6
    mv a1 s5
    jal ra relu


    # m1 * relu(hidden)
    lw t0 8(sp) # m1's row
    lw t1 20(sp) # hidden's col
    mul s5 t0 t1 # update size 
    slli a0 s5 2
    jal ra malloc
    mv s7 a0 # address of scores


    lw t0 8(sp) # m1's rol
    lw t1 12(sp) # m1's col
    lw t2 0(sp) # hidden's row
    lw t3 20(sp) # hidden's col
    mv a0 s3 
    mv a1 t0
    mv a2 t1
    mv a3 s6
    mv a4 t2
    mv a5 t3
    mv a6 s7
    jal ra matmul

    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix

    lw a0 16(s0)
    mv a1 s7
    lw a2 8(sp)
    lw a3 20(sp)
    jal ra write_matrix

     

    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax

    mv a0 s7
    mv a1 s5
    jal ra argmax

    bne s1 zero print_nothing
    # Print classification
    mv a1 a0
    jal ra print_int

print_nothing:

    # Print newline afterwards for clarity

    li a1 '\n'
    jal print_char

    # free
    mv a0 s2
    jal ra free

    mv a0 s3
    jal ra free

    mv a0 s4
    jal ra free

    mv a0 s6
    jal ra free

    mv a0 s7
    jal ra free

    # Epilogue
    addi sp sp 24
    lw ra 0(sp)
    lw s0 4(sp)
    lw s1 8(sp)
    lw s2 12(sp)
    lw s3 16(sp)
    lw s4 20(sp)
    lw s5 24(sp)
    lw s6 28(sp)
    lw s7 32(sp)
    addi sp sp 36 
    ret
 
exit_49:
    li a1 49
    jal ra exit2