.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d 
# Returns:
#	None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 72.
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 73.
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 74.
# =======================================================
matmul:

    # Error checks
    blez a1, err1
    blez a2, err1
    blez a4, err2
    blez a5, err2
    bne a2, a4, err3



    # Prologue
    


outer_loop_start:




inner_loop_start:












inner_loop_end:




outer_loop_end:


    # Epilogue
    
    
    ret



err1: 
    li a0, 72
    j done

err2: 
    li a0, 73
    j done

err3: 
    li a0, 74
    j done
    
done: 
    li a7, 93
    ecall

    