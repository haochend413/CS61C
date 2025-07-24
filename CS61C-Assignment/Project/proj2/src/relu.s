.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 78.
# ==============================================================================
relu:
    # Prologue
    addi sp, sp, -8
    sw s0, 4(sp)
    sw s1, 0(sp)
    blez a1, error_exit
    addi t0, x0, 0 # counter
    

loop: 
    # get address of the array, for future access
    addi s1, a0, 0
    # get array element
    lw s0, 0(s1) # get the thing in the array;
    
    


loop_start:
    # if s0 > 0, do nothing
    blt x0, s0, loop_continue
    # < 0, set to zero
    addi s0, x0,0
    # save to place
    sw s0, 0(s1)    
    # add counter
    addi t0, t0, 1
    

loop_continue:
    beq t0, a1, loop_end
    # update address, value and loop back
    addi s1, s1, 4
    lw s0, 0(s1)
    j loop_start


loop_end:
    # free
    lw s0, 4(sp)
    lw s1, 0(sp)
    addi sp, sp, 8


    # Epilogue
 
	ret
    
error_exit:
    li a0, 78
    li a7, 93         # exit syscall
    ecall
