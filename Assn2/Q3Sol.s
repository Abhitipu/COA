# 
# Assignment 2
# Problem no: 3
# Semester: 5th
# Group: 28
# Members: 
# Aryan Singh (19CS30007)
# Abhinandan De (19CS10069)
# 
# This program computes and displays whether a given Number is PRIME or COMPOSITE
# where n is entered by user

    .globl main
    .data

# program output text constants

question:
    .asciiz "Please enter a positive integer (greater than equal to 10): "
message1:
    .asciiz "Entered Number is Less than 10."
message2:
    .asciiz "Entered Number is PRIME."
message3:
    .asciiz "Entered Number is COMPOSITE."
    .text

# main program
# 
# program variables
# n:                $s0
# i:                $s1
# numberOfFactors:  $s2
# i^2:              $s3
main:
    li      $v0, 4                          # v0 <- 4(print string)
    la      $a0, question                   # loads the address of question on a0
    syscall

    li      $v0, 5                          # get n from user
    syscall
    move    $s0, $v0                        # s0=n <- v0

    slti    $t0, $s0, 10                    # t0 = (s0<10)? 1: 0
    bne     $t0, $zero, SCheck              # if t0 != zero then
    move    $s2, $zero                      # s2 initialized as zero
    li      $s1, 2                          # s1 <- 1
    li      $s3, 4                          # s3 will store the value of i^2
beginloop:
    slt     $t0, $s0, $s3                   # set t0 = 1, if n < i^2
    bne     $t0, $zero, EndLoop             # loop termination Condition
    div     $s0, $s1                        # Hi = $s0 % $s1
    mfhi    $t0                             # t0 = remainder
    bne     $t0, $zero, elsePart            # if remainder != 0 goto elsePart
    addi    $s2, $s2, 1                     # number of factors++
elsePart:
    add     $t0, $s1, $s1                   # to add 2*(i) + 1 to make i^2 -> (i+1)^2
    addi    $t0, $t0, 1                     # t0 = i + i + 1
    add     $s3, $s3, $t0                   # s3 = (i+1)^2
    addi    $s1, $s1, 1                     # i++
    b       beginloop                       # loop
EndLoop:
    bne     $s2, $zero, IsComposite         # if factors!=0 till  i <= sqtr n excluding i=1,  jump to isComposite
    li      $v0, 4                          # v0 <- 4(print string)
    la      $a0, message2                   # loads the address of message2 on a0
    syscall
    b exit

IsComposite:
    li      $v0, 4                          # v0 <- 4(print string)
    la      $a0, message3                   # loads the address of message3 on a0
    syscall
    b       exit

SCheck:                                     # Sanity Check message
    li      $v0, 4                          # v0 <- 4(print string)
    la      $a0, message1                   # loads the address of message1 on a0
    syscall

exit:
    li      $v0, 10                         # terminate the program
    syscall