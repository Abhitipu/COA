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

    j           endProg
sanityCheck:                                        # Takes the number in $a0, invalid message address in $a1.
                                                    # and performs sanity check, if falied shows error message
                                                    # goes to end Program
    lw          $t0, sanitymin                    
    slt         $t1, $a0, $t0                       # t1 = num<sanityMin ? 1:0
    add		    $a0, $zero, $a1		                # $a0 = $zero + $a1 to call Invalid message
    bne         $t1, $zero, InvalidMessage          # if num<sanityMin jump to Invalid message
    jr		    $ra					                # jump to $ra
    
InvalidMessage:
    li          $v0, 4
    syscall
    j           endProg

endProg:
    li          $v0, 10
    syscall
    