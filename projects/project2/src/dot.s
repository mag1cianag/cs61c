.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
#
# If the length of the vector is less than 1, 
# this function exits with error code 5.
# If the stride of either vector is less than 1,
# this function exits with error code 6.
# =======================================================
dot:
case0:
    li t0 1
    bge a2 t0 case1
    li a1 5
    jal ra exit2
case1:
    li t0 1
    bge a3 t0 case2
    li a1 6
    jal ra exit2
case2:
    li t0 1
    bge a4 t0 pre
    li a1 6
    jal ra exit2
pre:
    # Prologue

    li t0 0 # sum 
    li t1 0 # index
loop_start:
    bge t1 a2 loop_end
    slli t2 t1 2 # offset
    mul t3 t2 a3    
    mul t4 t2 a4

    add t3 t3 a0
    add t4 t4 a1

    lw t3,0(t3)
    lw t4,0(t4)

    mul t2,t3,t4
    add t0,t0,t2
    addi t1 t1 1
    j loop_start 

loop_end:
    mv a0,t0
    # Epilogue
    ret