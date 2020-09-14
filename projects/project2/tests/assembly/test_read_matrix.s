.import ../../src/read_matrix.s
.import ../../src/utils.s

.data
file_path: .asciiz "../inputs/simple0/bin/m0.bin"

.text
main:
    #allocate memory from stack
    addi sp sp -8
    addi t0 sp 0
    addi t1 sp 4
    # Read matrix into memory
    la t2 file_path
    mv a0 t2
    mv a1 t0
    mv a2 t1
    jal ra read_matrix
    mv s0 a0
    

    # Print out elements of matrix
    mv a0 s0
    lw a1 0(sp) 
    lw a2 4(sp)


    jal ra print_int_array

    # Terminate the program
    addi sp sp 8
    jal exit
