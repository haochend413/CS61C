# .globl matmul

# .text
# # =======================================================
# # FUNCTION: Matrix Multiplication of 2 integer matrices
# # 	d = matmul(m0, m1)
# # Arguments:
# # 	a0 (int*)  is the pointer to the start of m0 
# #	a1 (int)   is the # of rows (height) of m0
# #	a2 (int)   is the # of columns (width) of m0
# #	a3 (int*)  is the pointer to the start of m1
# # 	a4 (int)   is the # of rows (height) of m1
# #	a5 (int)   is the # of columns (width) of m1
# #	a6 (int*)  is the pointer to the start of d 
# # Returns:
# #	None (void), sets d = matmul(m0, m1)
# # Exceptions:
# #   - If m0 dimensions are invalid (rows <= 0 or cols <= 0), exit with code 72.
# #   - If m1 dimensions are invalid (rows <= 0 or cols <= 0), exit with code 73.
# #   - If m0_cols != m1_rows, exit with code 74.
# # =======================================================
# matmul:
#     # Error checks
#     blez a1, err1  # m0_rows <= 0
#     blez a2, err1  # m0_cols <= 0
#     blez a4, err2  # m1_rows <= 0
#     blez a5, err2  # m1_cols <= 0
#     bne a2, a4, err3  # m0_cols != m1_rows

#     # Prologue
#     addi sp, sp, -20
#     sw s0, 0(sp)   # Save dot result
#     sw s1, 4(sp)   # Save address for next store
#     sw s2, 8(sp)   # Save m0 pointer
#     sw s3, 12(sp)  # Save m1 pointer
#     sw a2, 16(sp)  # Save m0_cols

#     # Initialize counters and pointers
#     li t0, 0       # Outer loop counter (i)
#     li t1, 0       # Inner loop counter (j)
#     mv s1, a6      # Output array pointer (d)
#     mv s2, a0      # m0 pointer
#     mv s3, a3      # m1 pointer
#     mv t3, a3      # Save initial m1 pointer for reset

# outer_loop_start:
#     li t1, 0       # Reset inner loop counter
#     mv s3, t3      # Reset m1 pointer to start of matrix

# inner_loop_start:
#     # Save registers for dot call
#     addi sp, sp, -44
#     sw a0, 0(sp)
#     sw a1, 4(sp)
#     sw a2, 8(sp)
#     sw a3, 12(sp)
#     sw a4, 16(sp)
#     sw a5, 20(sp)
#     sw t0, 24(sp)
#     sw t1, 28(sp)
#     sw t2, 32(sp)
#     sw t3, 36(sp)
#     sw ra, 40(sp)

#     # Setup arguments for dot
#     mv a0, s2      # m0 row pointer
#     mv a1, s3      # m1 column pointer
#     mv a2, a2      # Length (m0_cols, preserved)
#     li a3, 1       # Stride for m0 (row-major)
#     mv a4, a5      # Stride for m1 (m1_cols)

#     # Call dot
#     jal ra, dot

#     # Store result in output array
#     sw a0, 0(s1)

#     # Restore registers
#     lw a0, 0(sp)
#     lw a1, 4(sp)
#     lw a2, 8(sp)
#     lw a3, 12(sp)
#     lw a4, 16(sp)
#     lw a5, 20(sp)
#     lw t0, 24(sp)
#     lw t1, 28(sp)
#     lw t2, 32(sp)
#     lw t3, 36(sp)
#     lw ra, 40(sp)
#     addi sp, sp, 44

#     # Increment inner loop
#     addi t1, t1, 1  # j++
#     addi s3, s3, 4  # Next m1 element
#     addi s1, s1, 4  # Next output element
#     bne t1, a5, inner_loop_start  # Continue if j < m1_cols

# inner_loop_end:
#     # Increment outer loop
#     addi t0, t0, 1  # i++
#     li t4, 4
#     mul t4, a2, t4  # Advance m0 pointer by m0_cols * 4
#     add s2, s2, t4
#     bne t0, a1, outer_loop_start  # Continue if i < m0_rows

# outer_loop_end:
#     # Epilogue
#     lw s0, 0(sp)
#     lw s1, 4(sp)
#     lw s2, 8(sp)
#     lw s3, 12(sp)
#     lw a2, 16(sp)
#     addi sp, sp, 20
#     ret

# err1:
#     li a1, 72
#     j exit2

# err2:
#     li a1, 73
#     j exit2

# err3:
#     li a1, 74
#     j exit2

    

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
    addi sp, sp, -16
    sw s0, 0(sp) # save dot result; 
    sw s1, 4(sp) # address for next store; 
    sw s2, 8(sp)
    sw s3, 12(sp)
    
    # set two counters
    addi t0, x0, 0 # outer
    addi t1, x0, 0 # inner
    # setup address
    addi s1, a6, 0
    # setup two matrixs
    # m0
    addi s2, a0, 0
    # m1 
    addi s3, a3, 0
    addi t3, a3, 0
    

outer_loop_start: # the row of left

    li t1, 0       # Reset inner loop counter
    mv s3, t3      # Reset m1 pointer to start of matrix
    
    




inner_loop_start: # the column of right
# reset t1
    addi t1, x0, 0

inner_loop_continued: 
    # store information for calling dot
    addi sp, sp, -44
    sw a0, 0(sp)
    sw a1, 4(sp)
    sw a2, 8(sp)
    sw a3, 12(sp)
    sw a4, 16(sp)
    sw t0, 20(sp)
    sw t1, 24(sp)
    sw t2, 28(sp)
    sw a5, 32(sp)    # <--- Save a5!
    sw t3, 36(sp)
    sw ra, 40(sp)
    
    # get the things in place
#     addi a2, a1, 0 # a2: length 
    # stride of v0: 1
    addi t2, x0, 0
    addi a3, x0, 1
    # stride of v1: a5
    addi a4, a5, 0
    # get the starting places; 
    addi a0, s2, 0
    addi a1, s3, 0
    
    # do dot product
    jal ra, dot 
    
    # a0 now contains the result; 
    # store at s1, which is d; 
    sw a0, 0(s1)
    
    # bring back the previous values; 
    lw a0, 0(sp)
    lw a1, 4(sp)
    lw a2, 8(sp)
    lw a3, 12(sp)
    lw a4, 16(sp)
    lw t0, 20(sp)
    lw t1, 24(sp)
    lw t2, 28(sp)
    lw a5, 32(sp)    # <--- Save a5
    lw t3, 36(sp)
    lw ra, 40(sp)
    addi sp, sp, 44
    
    # check for continuing inner loop; if equal, go to inner_loop_end
    addi  t1, t1, 1 
    
    # else, continue and add addresses
    addi s3, s3, 4 # increase pos of inner start
    # increase next store
    addi s1, s1, 4
    beq t1, a5, inner_loop_end
    j inner_loop_continued







inner_loop_end: 
    # increase outer loop count; 
    addi t0, t0, 1
    beq t0, a1, outer_loop_end
    # else : 
    # increase address and go to next inner_cycle, since increase, t1 is going to be reset;
    li t1, 4
    mul t1, a2, t1 
    add s2, s2, t1 # this sets the next m0 line
    addi t1, x0, 0
#     addi s3, t3, 0 # we need to get s3 back, try t3; 
    # ok, go back to inner loop start
    j outer_loop_start
    
    


    
    



outer_loop_end:


        
    lw s0, 0(sp) # save dot result; 
    lw s1, 4(sp) # address for next store; 
    lw s2, 8(sp)
    lw s3, 12(sp)
    addi sp, sp, 16
    
    ret



err1:
    li a1, 72
    j exit2

err2:
    li a1, 73
    j exit2

err3:
    li a1, 74
    j exit2
    
    
    
    
    
    
# .globl dot

# .text
# # =======================================================
# # FUNCTION: Dot product of 2 int vectors
# # Arguments:
# #   a0 (int*) is the pointer to the start of v0
# #   a1 (int*) is the pointer to the start of v1
# #   a2 (int)  is the length of the vectors
# #   a3 (int)  is the stride of v0
# #   a4 (int)  is the stride of v1
# # Returns:
# #   a0 (int)  is the dot product of v0 and v1
# # Exceptions:
# # - If the length of the vector is less than 1,
# #   this function terminates the program with error code 75.
# # - If the stride of either vector is less than 1,
# #   this function terminates the program with error code 76.
# # =======================================================
# dot:
#     # check 
#     blez a2, errr1       # if length < 1, exit 75
#     blez a3, errr2       # if stride v0 < 1, exit 76
#     blez a4, errr2       # if stride v1 < 1, exit 76 

#     # Prologue
#     addi sp, sp, -16
#     sw s0, 0(sp)
#     sw s1, 4(sp)
#     sw s2, 8(sp)
#     sw s3, 12(sp)
    
#     # counter
#     addi t0, x0, 0
#     # sum
#     addi t1, x0, 0
#     # mul
#     addi t2, x0, 0
    
#     # load addresses
#     addi s0, a0, 0
#     addi s1, a1, 0
    
#     addi a1, x0, 4
#     mul a3, a3, a1
#     mul  a4, a4, a1
    
  
    
# loop_start:
#     # load values; 
#     lw s2, 0(s0)
#     lw s3, 0(s1)
#     # mul; 
#     mul t2, s2, s3
    
#     # store 
#     add t1, t1, t2

# loop_cont: 
#     # step & check
#     # consider stride! 
#     addi t0, t0, 1
#     beq t0, a2, loop_end
#     # step with stride * 4, I think
    
#     add s0, s0, a3
#     add s1, s1, a4
    
#     j loop_start



# loop_end:
#     # put a0;
#     add a0, x0, t1
    
#     lw s0, 0(sp)
#     lw s1, 4(sp)
#     lw s2, 8(sp)
#     lw s3, 12(sp)
#     addi sp, sp, 16


#     # Epilogue

    
#     ret

# errr1:
#     li a0, 75 
#     j rdone
    
    
# errr2:
#     li a0, 76
# rdone: 
#     li a7, 93
#     ecall

    