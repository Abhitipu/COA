# This program computes and displays whether a given Number n is PERFECT or NOT
# A perfect number is an number whose sum of proper divisor is equal to that number itself
# here n is entered by user

    .globl main
    .data

# program output text constants

question:
    .asciiz "Please enter a positive integer : "
message1:
    .asciiz "Entered Number is Not Positive."
message2:
    .asciiz "Entered Number is a Perfect Number."
message3:
    .asciiz "Entered Number is not a Perfect Number."
    .text

# main program
# 
# program variables
# n:                $s0
# i:                $s1
# sumOfFactors:  $s2
main:
    li      $v0, 4                          # v0 <- 4(print string)
    la      $a0, question                   # loads the address of question on a0
    syscall

    li      $v0, 5                          # get n from user
    syscall
    move    $s0, $v0                        # s0=n <- v0

    slti    $t0, $s0, 1                     # t0 = (s0<1)? 1: 0
    bne     $t0, $zero, SCheck              # if t0 != zero then
    move    $s2, $zero                      # s2 initialized as zero
    li      $s1, 1                          # s1 <- 1

beginloop:
    beq     $s0, $s1, EndLoop               # loop termination Condition
    div     $s0, $s1                        # Hi = $s0 % $s1
    mfhi    $t0                             # t0 = remainder
    bne     $t0, $zero, elsePart            # if remainder != 0 goto elsePart
    addi    $s2, $s2, $s1                   # s2 += i if i is a divisor of n
elsePart:
    addi    $s1, $s1, 1                     # i++
    b       beginloop                       # loop
EndLoop:
    bne     $s2, $s0, NotPerfect         # if Sumoffactors!=n, including 1 and excluding n
    li      $v0, 4                          # v0 <- 4(print string)
    la      $a0, message2                   # loads the address of message2 on a0
    syscall
    b exit

NotPerfect:
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