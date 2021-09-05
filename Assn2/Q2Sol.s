# 
# Assignment 2
# Problem no: 2
# Semester: 5th
# Group: 28
# Members: 
# Aryan Singh (19CS30007)
# Abhinandan De (19CS10069)
# 

# This program computes and outputs the gcd of two positive numbers a and b
# a and b is taken from the user as input
    .globl  main

    .data

# program output text constants
prompt1:
    .asciiz "Enter  the  first  positive integer: "         
prompt2:
    .asciiz "Enter the second positive integer: "           # storing all the strings in the data segment!
invMesg:
    .asciiz "Enter positive integers!"
result:
    .asciiz "GCD of the two integers is: "

    .text                                                   # Beginning of the main progrma

# main program
#
# program variables
#   a:     $s0
#   b:     $s1
#   gcd:   $s2
#
main:
    li      $v0, 4                          # enter print string mode
    la      $a0, prompt1                    # loading the address of prompt 1
    syscall                                 # Calling printf

    li      $v0, 5                          # get n from user 
    syscall                                 # call scanf
    move    $s0, $v0                        # move result to s0

    li      $v0, 4                          # enter print string mode
    la      $a0, prompt2                    # loading the address of prompt 2
    syscall                                 # Calling printf

    li      $v0, 5                          # get n from user 
    syscall                                 # call scanf
    move    $s1, $v0                        # move result to s0

    ble     $s0, $zero, invalidMesg         # the sanity checks for input
    ble     $s1, $zero, invalidMesg         # the numbers should be greater than 0

    bne     $s0, $zero, gcdLoop             # initial loop check
    move    $s2, $s1                        # if a == 0 result = b
    b       printRes                        # go and print the result

gcdLoop:
    beq     $s1, $zero, assignRes           # Continue until b != 0
    ble     $s0, $s1, reduceB               # if a <= b then reduce b
    sub     $s0, $s0, $s1                   # Control comes here if a > b, assign a = a - b
    b       gcdLoop                         # Continue with the loo[]

reduceB:                                    # the else condition for b >= a
    sub     $s1, $s1, $s0                   # Assign b = b - a 
    b       gcdLoop                         # Carry on with the loop

assignRes:                                  # assign a to the result
    move    $s2, $s0

printRes:                                   # print the result
    li      $v0, 4                          # print string mode
    la      $a0, result                     # load address of the resultant string 
    syscall

    li      $v0, 1                          # print gcd, 1-> print integer mode
    move    $a0, $s2                        # move the result to a0
    syscall                                 # call printf
    b       endProg                         # end the program

invalidMesg:
    li      $v0, 4                          # issue prompt Puts it in the print string ode
    la      $a0, invMesg                    # loading the register a0 with the start adderess of the string to be printed
    syscall                                 # Calling printf

endProg:
    li      $v0, 10                         # terminate the program
    syscall
