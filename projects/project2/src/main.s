.import read_matrix.s
.import write_matrix.s
.import matmul.s
.import dot.s
.import relu.s
.import argmax.s
.import utils.s
.import classify.s

.globl main

# This is a dummy main function which imports and calls the classify function.
# While it just exits right after, it could always call classify again.
main:
    # mv s0 a0
    # mv s1 a1
    # mv s2 a2
    # mv a1 s2
    # jal ra print_int

    # lw s3 8(s1)
    # mv a1 s3
    # jal ra print_str

    # mv a0 s0
    # mv a1 s1
    # mv a2 s2
    li a2 0
    jal classify

    jal exit
