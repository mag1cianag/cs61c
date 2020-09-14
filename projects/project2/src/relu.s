.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the size of elements in the array
# Returns:
#	None
#
# If the length of the vector is less than 1, 
# this function exits with error code 8.
# ==============================================================================

relu: 
    li t0 1
    bge a1,t0, start   
    addi a1 x0 8
    jal ra exit2
start:  
    li t0 ,0 #conter

loop_start:
    bge t0,a1,loop_end
    slli t1,t0,2 # offset
    add t2,a0,t1 #current address of a[i]
    lw t3,0(t2) # t3 is a[i]

    bge t3,zero,loop_continue    

    sw zero,0(t2)

loop_continue:
    addi t0,t0,1
    j loop_start

loop_end:
	ret