.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
#
# If the length of the vector is less than 1, 
# this function exits with error code 7.
# =================================================================
argmax:
    li t0 1
    bge a1 t0 pre
    li a1 7
    jal ra exit2
pre:
    # Prologue

   addi a1,a1,-1 #a1 is index now 
   li t0,0 #max
   li t1,0 # return value
loop_start:
   blt a1,zero,loop_end 
   slli t2,a1,2
   add t4,t2,a0
   lw t3,0(t4)
   blt t3,t0,loop_continue
   mv t0,t3
   mv t1,a1

loop_continue:
    addi a1,a1,-1
    j loop_start

loop_end:
    mv a0,t1    

    # Epilogue

    ret