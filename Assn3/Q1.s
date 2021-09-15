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
# Main program
# 
# program variables
# var1  :       $s1 (MULTIPLIER)|Q
# var2  :       $s2 (MULTIPLICAND)|M
# ans   :       $s3 (s1 * s2)
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
    add         $a0, $zero, $s2                      
    jal		    sanityCheck				            # jump to sanityCheck and save position to $ra
    move        $a0, $s1
    move        $a1, $s2

    jal         multiply_booth
    move        $s3, $v0                            # store the ans in $s3
    la          $a0, resultMessage                  # print result message
    li          $v0, 4                              # print string mode
    syscall
    
    move        $a0, $s3                            # move the answer to print 
    li          $v0, 1                              # print int mode
    syscall

    j           endProg
multiply_booth:
    # Algo starts
    # program variables
    # temp  :       $t0 temp
    # n     :       $t1 (Count)
    # var1  :       $t2 (MULTIPLIER)|Q
    # var2  :       $t3 (MULTIPLICAND)|M
    # A     :       $t4 (A)
    # M     :       $t5 (M)
    # Q     :       $t6 (Q)
    # Q0Q-1 :       $t7 (Q0Q-1) (this will be maintained in the loop)
    li          $t1, 16                             # n = 16, for 16 bit numbers
    move 	    $t4, $zero		                    # $t4 = $zero, A = 0
    move        $t5, $a1                            # $t5 = $a1, M = multiplicand = var2
    move        $t6, $a0                            # $t6 = $a0, Q = multiplier = var1
    andi        $t6, $t6, 0xffff                    # $Q's upper 16 bits set to 0
    andi        $t0, $t6, 1                         # t0 = Q0
    sll         $t0, $t0, 1                         # shift left logical
    add         $t7, $zero, $t0                     # $t7 = Q0Q-1      

BoothLoop:
    li          $t0, 2
    beq         $t0, $t7, BoothLoop_10              # Q0Q-1 = 10
    li          $t0, 1
    beq         $t0, $t7, BoothLoop_01              # Q0Q-1 = 01
BoothLoop_Ashift_Cupdate:                           # Arithmetic Shift and Count Update
    andi        $t0, $t4, 1                         # last digit of A saved
    sra         $t4, $t4, 1                         # right shift A
    sll         $t0, $t0, 16                        # extracted bit sent to 2^16 place                    
    or          $t6, $t0, $t6                       # extracted bit plaeced at 2^16 place of Q
    andi        $t7, $t6, 3                         # new Q0Q-1 extracted
    srl         $t6, $t6, 1                         # Q right shifted
    addi        $t1, $t1, -1                        # count = count - 1
    beq         $t1, $zero, multiply_booth_return                # Loop termination condition                            
    j           BoothLoop                           # continue loop
BoothLoop_01:
    add         $t4, $t4, $t5                       # A updated to A+M in AQ 
    j           BoothLoop_Ashift_Cupdate
BoothLoop_10:
    sub         $t4, $t4, $t5                       # A updated to A-M in AQ
    j           BoothLoop_Ashift_Cupdate

multiply_booth_return:    
    sll         $v0, $t4, 16                        # A sent to upper 16 bits
    or          $v0, $v0, $t6                       # lower 16  bit set as that of Q
    jr          $ra
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
    bne         $t1, $zero, InvalidMessage          # if sanityMax < num jump to Invalid message
    add         $a0, $zero, $t2                     # restoring a0
    jr		    $ra					                # jump to $ra
    
InvalidMessage:
    li          $v0, 4
    syscall
    j           endProg

endProg:
    li          $v0, 10
    syscall
    