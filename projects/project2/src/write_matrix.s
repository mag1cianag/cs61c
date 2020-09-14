.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
#   If any file operation fails or doesn't write the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is the pointer to the start of the matrix in memory
#   a2 (int)   is the number of rows in the matrix
#   a3 (int)   is the number of columns in the matrix
# Returns:
#   None
#
# If you receive an fopen error or eof, 
# this function exits with error code 53.
# If you receive an fwrite error or eof,
# this function exits with error code 54.
# If you receive an fclose error or eof,
# this function exits with error code 55.
# ==============================================================================
write_matrix:

    # Prologue
    addi sp sp -24 
    sw ra 0(sp)
    sw s0 4(sp) 
    sw s1 8(sp)
    sw s2 12(sp)
    sw a2 16(sp)
    sw a3 20(sp)
    mv s1 a1 # address of matrix
    mul s2 a2 a3 # row * col 
    
    
    # fopen
    mv a1 a0
    li a2 1
    jal ra fopen
    blt a0 zero exit_53
    mv s0 a0 # descriptor

    # fwrite row
    mv a1 s0
    addi a2 sp 16
    li a3 1 
    li a4 4
    jal ra fwrite
    blt a0 zero exit_54
    li t0 1
    bne a0 t0 exit_1

    # fwrite col
    mv a1 s0
    addi a2 sp 20
    li a3 1
    li a4 4
    jal ra fwrite
    blt a0 zero exit_54
    li t0 1
    bne a0 t0 exit_1

    # fwrite matrix
    mv a1 s0
    mv a2 s1
    mv a3 s2
    li a4 4
    jal ra fwrite 
    blt a0 zero exit_54
    bne a0 s2 exit_1

    # fclose
    mv a1 s0
    jal ra fclose
    bne a0 zero exit_55

    # Epilogue
    lw ra 0(sp)
    lw s0 4(sp) 
    lw s1 8(sp)
    lw s2 12(sp)
    addi sp sp 24 

    ret

exit_1:
    li a1 1
    jal ra exit2

exit_53:
    li a1 53
    jal ra exit2

exit_54:
    li a1 54
    jal ra exit2

exit_55:
    li a1 55 
    jal ra exit2