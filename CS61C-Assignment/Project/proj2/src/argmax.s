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
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 77.
# =================================================================
argmax: 

    # error 
    beq a1, x0, error
    # Prologue
    addi sp, sp, -8
    sw s0, 0(sp)
    sw s1, 4(sp)
    
    
    
    # load things
    # address
    addi s1, a0, 0
    # set max value for compare
    lw t1, 0(s1)
    #  set output index
    addi t2, x0, 0
    # set counter
    addi t0, x0, 0

loop_start:
    # load element
    lw s0, 0(s1)
    # process
    blt t1, s0, process
    # otherwise, jump to continue
    j loop_continue
process: 
    # process
    # set compare
    addi, t1, s0, 0
    # set output
    addi, t2, t0, 0

loop_continue:
    # increase stuff, check
    addi t0, t0, 1
    beq t0, a1, loop_end
    addi s1,s1, 4
    j loop_start

loop_end:
# set output
    add a0, t2, x0
    lw s0, 0(sp)
    lw s1, 4(sp)
    addi sp, sp, 8

    # Epilogue


    ret
    
error: 
    li a0, 77
    li a7, 93
    ecall
