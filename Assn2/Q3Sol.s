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

beginloop:
    beq     $s0, $s1, EndLoop               # loop termination Condition
    div     $s0, $s1                        # Hi = $s0 % $s1
    mfhi    $t0                             # t0 = remainder
    bne     $t0, $zero, elsePart            # if remainder != 0 goto elsePart
    addi    $s2, $s2, 1                     # number of factors++
elsePart:
    addi    $s1, $s1, 1                     # i++
    b       beginloop                       # loop
EndLoop:
    bne     $s2, $zero, IsComposite         # if factors!=0, excluding 1 and n
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