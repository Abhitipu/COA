# 
# Assignment 3
# Problem no: 3
# Semester: 5th
# Group: 28
# Members: 
# Aryan Singh (19CS30007)
# Abhinandan De (19CS10069)
# 

# This program reads two 16 bit signed integers.
# Then performs booths mutliplication algorithm to compute the product

    .globl main

    .data

# Program output text constants

sanitymin:
    .word 1
prompt1:
    .asciiz "Enter m: "
prompt2:
    .asciiz "Enter n: "
prompt3:
    .asciiz "Enter a: "
prompt4:
    .asciiz "Enter r: "
space:
    .asciiz " "
newline:
    .asciiz "\n"
sanityMessage:
    .asciiz "The given input must be positive integers!\n"
    .text
# main program
# 
# program variables
# m     :       $s0 rows
# n     :       $s1 column
# a     :       $s2 populate Gp a0
# r     :       $s3 Gp ratio

main:
    jal         initStack                           # initializing stack
    li          $v0, 4                              # print string mode
    la          $a0, prompt1                        # loading the address of prompt 1
    syscall

    li          $v0, 5                              # read int mode
    syscall                                         # scans int into $v0
    add         $s0, $zero, $v0                     # saves m in $s0

    li          $v0, 4                              # print string mode
    la          $a0, prompt2                        # loading the address of prompt 2
    syscall

    li          $v0, 5                              # read int mode
    syscall                                         # scans int into $v0
    add         $s1, $zero, $v0                     # saves n in $s1

    li          $v0, 4                              # print string mode
    la          $a0, prompt3                        # loading the address of prompt 3
    syscall

    li          $v0, 5                              # read int mode
    syscall                                         # scans int into $v0
    add         $s2, $zero, $v0                     # saves a in $s2

    li          $v0, 4                              # print string mode
    la          $a0, prompt4                        # loading the address of prompt 4
    syscall

    li          $v0, 5                              # read int mode
    syscall                                         # scans int into $v0
    add         $s3, $zero, $v0                     # saves r in $s3

   
    la          $a1, sanityMessage                  # prepare arguments for sanity check of $s0
    add         $a0, $zero, $s0                      
    jal		    sanityCheck				            # jump to sanityCheck and save position to $ra
    
    la          $a1, sanityMessage                  # prepare arguments for sanity check of $s1
    add         $a0, $zero, $s1                      
    jal		    sanityCheck				            # jump to sanityCheck and save position to $ra

    la          $a1, sanityMessage                  # prepare arguments for sanity check of $s2
    add         $a0, $zero, $s2                      
    jal		    sanityCheck				            # jump to sanityCheck and save position to $ra

    la          $a1, sanityMessage                  # prepare arguments for sanity check of $s3
    add         $a0, $zero, $s3                      
    jal		    sanityCheck				            # jump to sanityCheck and save position to $ra

    mult	    $s0, $s1			                # $s0 * $s1 = Hi and Lo registers
    mflo	    $s4					                # copy Lo to $s4
    move        $a0, $s4                            # argument
    jal         mallocInStack                       # malloc(n*m)

    move        $s5, $v0                            # s5 = base address
    move        $t0, $s5                            # t0 , a ptr to base address
    move        $t1, $zero                          # count variable
mainLoop:
    beq         $t1, $s4, mainLoopEnd               # loop termination condition
    sw          $s2, ($t0)                          # *(t0) = s2
    mult        $s2, $s3                            # $s2 * $s3 = HI LO
    mflo        $s2                                 # s2 = r * s2
    addi        $t0, $t0, 4                         # t0 = (t0 + 4byte)
    addi        $t1, $t1, 1                         # cnt++
    j           mainLoop    
mainLoopEnd:
    move        $a0, $s0
    move        $a1, $s1
    move        $a2, $s5
    jal         printMatrix
    j           endProg
sanityCheck:                                        # Takes the number in $a0, invalid message address in $a1.
                                                    # and performs sanity check, if falied shows error message
                                                    # goes to end Program
    lw          $t0, sanitymin                    
    slt         $t1, $a0, $t0                       # t1 = num<sanityMin ? 1:0
    add		    $a0, $zero, $a1		                # $a0 = $zero + $a1 to call Invalid message
    bne         $t1, $zero, InvalidMessage          # if num<sanityMin jump to Invalid message
    jr		    $ra					                # jump to $ra






initStack:
    # need to save current fp
    addi        $sp, $sp, -4                        # allocating 4 bytes
    sw          $fp, ($sp)                          # saving fp on stack
    move        $fp, $sp                            # initiating new frame pointor
    jr          $ra                                 # return to ra

pushToStack:
    addi        $sp, $sp, -4                        # allocating 4 bytes, sp-=4
    sw          $a0, ($sp)                          # saves a0 to M[sp]
    jr          $ra                                 # return to ra

mallocInStack:
    move        $v0, $a0                            # moves argument to v0
    sll         $v0, $v0, 2                         # v0 converted to number of bytes
    sub         $v0, $sp, $v0                       # v0 = sp - 4*a0
    move        $sp, $v0                            # allocated 4*a0 bytes and moved sp to sp - 4*a0
    jr          $ra                                 # return to ra

printMatrix:
    addi        $sp, $sp, -8                        # allocate 8 bytes, 4 for ra, 4 for fp
    sw          $ra, 4($sp)                         # M[sp+4] = ra
    sw          $fp, ($sp)                          # M[sp] = fp
    move        $fp, $sp                            # fp = sp
    # local variable $t0-1d equivalent index i= t0//n, j = t0%n
    # $t2 = j
    # $t3 = m*n
    mult	    $a0, $a1			                # $a0 * $a1 = Hi and Lo registers
    mflo	    $t3					                # copy Lo to $t2
    move        $t0, $zero                          # t0=0
    move        $t2, $zero                          # j=0
printMatrix_loop:
    beq         $t0, $t3, printMatrix_loop_end      # if t0 == n*m loop terminates
    addi        $t2, $t2, 1                         # j++
    sll         $t1, $t0, 2                         # t0 converted to bytes
    add         $t1, $t1, $a2                       # a+4*t0
    lw          $t1, ($t1)                          # t1 = *(a+4*t0)
    move        $t4, $a0                            # saving a0
    move        $a0, $t1                            # to print
    li          $v0, 1                              # print int mode
    syscall

    la          $a0, space                          # " " print
    li          $v0, 4                              # print string
    syscall

    bne         $t2, $a1, printMatrixLoopEndif      # branch if n!= j
    sub         $t2, $t2, $a1                       # j-=n
    li          $v0, 4                              # print string mode
    la          $a0, newline                        # "\n"
    syscall
printMatrixLoopEndif:
    move        $a0, $t4                            # a0 = m restored    
    addi        $t0, $t0, 1                         # index++
    j		    printMatrix_loop				    # jump to printMatrix_loop
    
printMatrix_loop_end:
    move        $sp, $fp                            # Doubtful!!! sp = fp 
    lw          $ra, 4($fp)                         # restore ra = M[fp + 4]
    lw          $fp, ($fp)                          # restore fp = M[fp]
    addi        $sp, $sp, 8                         # frees the memory on stack
    jr          $ra                                 # return to ra


InvalidMessage:
    li          $v0, 4
    syscall
    j           endProg

endProg:
    li          $v0, 10
    syscall
    