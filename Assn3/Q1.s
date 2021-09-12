# 
# Assignment 3
# Problem no: 1
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
sanitymax:
    .word 32767
sanitymin:
    .word -32768
prompt1:
    .asciiz "Enter first number: "
prompt2:
    .asciiz "Enter Second number: "
sanityMessage1:
    .asciiz "The first number is not in proper Range, please enter Numbers in the range -32,768 to +32,767"
sanityMessage2:
    .asciiz "The Second number is not in proper Range, please enter Numbers in the range -32,768 to +32,767"
resultMessage:
    .asciiz "Product of the two numbers are: "

    .text
# main program
# 
# program variables
# n     :       $s0 (Count)
# var1  :       $s1 (MULTIPLIER)|Q
# var2  :       $s2 (MULTIPLICAND)|M
# A     :       $s3 (A) (only used to initialize AQ)
# M     :       $s4 (M) stored in upper 16 bits
# Q     :       $s5 (Q) (only used to initialize AQ)
# Q0Q-1 :       $s6 (Q0Q-1) (this will be maintained in the loop)
# AQ    :       $s7 (A and Q concatenated form) (this will be maintained in the loop)

main:
    li          $v0, 4                              # print string mode
    la          $a0, prompt1                        # loading the address of prompt 1
    syscall

    li          $v0, 5                              # read int mode
    syscall                                         # scans int into $v0
    add         $s1, $zero, $v0                     # saves num1 in $s1

    li          $v0, 4                              # print string mode
    la          $a0, prompt2                        # loading the address of prompt 2
    syscall

    li          $v0, 5                              # read int mode
    syscall                                         # scans int into $v0
    add         $s2, $zero, $v0                     # saves num1 in $s2
    
    la          $a1, sanityMessage1                 # prepare arguments for sanity check of $s1
    add         $a0, $zero, $s1                      
    jal		    sanityCheck				            # jump to sanityCheck and save position to $ra
    
    la          $a1, sanityMessage2                 # prepare arguments for sanity check of $s2
    add         $a0, $zero, $s1                      
    jal		    sanityCheck				            # jump to sanityCheck and save position to $ra


    # Algo starts
    li          $s0, 16                             # n = 16, for 16 bit numbers
    move 	    $s3, $zero		                    # $s3 = $zero, A = 0
    move        $s4, $s2                            # $s4 = $s2, M = multiplicand = var2
    sll         $s4, $s4, 16                        # moved M to upper 16 bits
    move        $s5, $s1                            # $s5 = $s1, Q = multiplier = var1
    andi        $t0, $s5, 1                         # t0 = Q0
    sll         $t0, $t0, 1                         # shift left logical
    add         $s6, $zero, $t0                     # $s6 = Q0Q-1
    sll         $s7, $s3, 16                        # upper 16 bit is A
    andi        $t0, $s5, 0xffff                    # stored lower 16 bit Q
    or          $s7, $s7, $t0                       # s7 is concatenated form of AQ       

BoothLoop:
    li          $t0, 2
    beq         $t0, $s6, BoothLoop_10              # Q0Q-1 = 10
    li          $t0, 1
    beq         $t0, $s6, BoothLoop_01              # Q0Q-1 = 01
BoothLoop_Ashift_Cupdate:                           # Arithmetic Shift and Count Update
    sra         $s7, $s7, 1                         # righ arithmetic shift AQ, AQ updated
    andi        $t0, $s7, 1                         # last digit of AQ extracted
    sll         $t0, $t0, 1                         # extracted bit moved to 2^1 place
    srl         $s6, $s6, 1                         # Q0Q-1 right shifted, Q-1 = Q0
    add         $s6, $s6, $t0                       # Q0Q-1 updated
    addi        $s0, $s0, -1                        # count = count - 1
    beq         $s0, $zero, printAns                # Loop termination condition                            
    j           BoothLoop                           # continue loop
BoothLoop_01:
    add         $s7, $s7, $s4                       # A updated to A+M in AQ 
    j           BoothLoop_Ashift_Cupdate
BoothLoop_10:
    sub         $s7, $s7, $s4                       # A updated to A-M in AQ
    j           BoothLoop_Ashift_Cupdate
    

sanityCheck:                                        # Takes the number in $a0, invalid message address in $a1.
                                                    # and performs sanity check, if falied shows error message
                                                    # goes to end Program
    lw          $t0, sanitymin 
    add         $t2, $a0, $zero                     # saves a copy of a0 in $t2                      
    slt         $t1, $a0, $t0                       # t1 = num<sanityMin ? 1:0
    add		    $a0, $zero, $a1		                # $a0 = $zero + $a1 to call Invalid message
    bne         $t1, $zero, InvalidMessage          # if num<sanityMin jump to Invalid message
    add         $a0, $zero, $t2                     # restoring a0
    lw          $t0, sanitymax
    slt         $t1, $t0, $a0                       # t1 = sanityMax < num ? 1:0
    add		    $a0, $zero, $a1		                # $a0 = $zero + $a1 to call Invalid message
    bne         $t1, $zero, InvalidMessage          # if num<sanityMin jump to Invalid message
    add         $a0, $zero, $t2                     # restoring a0
    jr		    $ra					                # jump to $ra
    
InvalidMessage:
    li          $v0, 4
    syscall

printAns:
    la          $a0, resultMessage                  # print result message
    li          $v0, 4                              # print string mode
    syscall
    move        $a0, $s7                            # argument placed
    li          $v0, 1                              # print int mode
    syscall

endProg:
    li          $v0, 10
    syscall
    