.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#   If any file operation fails or doesn't read the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
#
# If you receive an fopen error or eof, 
# this function exits with error code 50.
# If you receive an fread error or eof,
# this function exits with error code 51.
# If you receive an fclose error or eof,
# this function exits with error code 52.
# ==============================================================================
read_matrix:

    # Prologue
    addi sp sp -24
    sw ra 0(sp)
    sw s0 4(sp)
    sw s1 8(sp)
    sw s2 12(sp)
    sw s3 16(sp)
    sw s4 20(sp)

    # save address of row and col 
    mv s0 a1 
    mv s1 a2

    # fopen
    mv a1 a0
    li a2 0
    jal ra fopen
    blt a0 zero exit_50
    mv s2 a0 # descriptor

    # read row
    mv a1  s2
    mv a2  s0
    li a3  4
    jal ra fread
    blt a0 zero exit_51
    li t0 4
    bne a0 t0 exit_1

    # read col
    mv a1  s2
    mv a2  s1
    li a3  4
    jal ra fread
    blt a0 zero exit_51
    li t0 4
    bne a0 t0 exit_1

    # compute row * col
    lw s0 0(s0)
    lw s1 0(s1)
    mul t0 s0 s1


    # allocate memory for martrice
    slli s3 t0 2 # bytes
    mv a0 s3 
    jal ra malloc
    mv s4 a0 # s4 is the address of martirce

    # read matrice
    mv a1 s2
    mv a2 s4
    mv a3 s3
    jal ra fread
    blt a0 zero exit_51
    bne a0 s3 exit_1


    # close file
    mv a0 s2
    jal ra fclose
    bne a0 zero exit_52

    # Epilogue
    mv a0 s4
    lw ra 0(sp)
    lw s0 4(sp)
    lw s1 8(sp)
    lw s2 12(sp)
    lw s3 16(sp)
    lw s4 20(sp)
    addi sp sp 24

    ret
    
exit_1:
    li a1 1
    jal ra exit2

exit_50:
    li a1 50
    jal ra exit2
    
exit_51:
    li a1 51
    jal ra exit2

exit_52:
    li a1 52
    jal ra exit2
