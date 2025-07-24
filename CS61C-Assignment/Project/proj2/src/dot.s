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
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 75.
# - If the stride of either vector is less than 1,
#   this function terminates the program with error code 76.
# =======================================================
dot:
    # check 
    blez a2, err1       # if length < 1, exit 75
    blez a3, err2       # if stride v0 < 1, exit 76
    blez a4, err2       # if stride v1 < 1, exit 76 

    # Prologue
    addi sp, sp, -16
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    
    # counter
    addi t0, x0, 0
    # sum
    addi t1, x0, 0
    # mul
    addi t2, x0, 0
    
    # load addresses
    addi s0, a0, 0
    addi s1, a1, 0
    
    addi a1, x0, 4
    mul a3, a3, a1
    mul  a4, a4, a1
    
  
    
loop_start:
    # load values; 
    lw s2, 0(s0)
    lw s3, 0(s1)
    # mul; 
    mul t2, s2, s3
    
    # store 
    add t1, t1, t2

loop_cont: 
    # step & check
    # consider stride! 
    addi t0, t0, 1
    beq t0, a2, loop_end
    # step with stride * 4, I think
    
    add s0, s0, a3
    add s1, s1, a4
    
    j loop_start



loop_end:
    # put a0;
    add a0, x0, t1
    
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    addi sp, sp, 16


    # Epilogue

    
    ret

err1:
    li a0, 75 
    j done
    
    
err2:
    li a0, 76
done: 
    li a7, 93
    ecall