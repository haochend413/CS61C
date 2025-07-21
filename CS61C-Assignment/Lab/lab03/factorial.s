.globl factorial

.data
n: .word 8

.text
main:
    la t0, n
    lw a0, 0(t0)
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    # YOUR CODE HERE
    # the value of n is now in a0; 
# here does not seem to have memory issue; 
    # use a2
    addi a2, a0, 0
    addi a3, a0, 0
  loop: 
    addi a4, x0, 1
    beq a2, a4, finish
    sub a2, a2, a4
    mul a3, a3, a2
    jal x0, loop
  finish:
    addi a0, a3, 0 
    jr ra

