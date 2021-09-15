# 
# Assignment 3
# Problem no: 2
# Semester: 5th
# Group: 28
# Members: 
# Aryan Singh (19CS30007)
# Abhinandan De (19CS10069)
# 

# This program computes kth largest element of an array of length 10 
# All the elements of the array and k are entered by the user
#
    .globl  main
    .globl  sortArray

    .data
        array:    .space  40
        size:   .word   10

# program output text constants
prompt1:
    .asciiz "Please enter 10 integers one by one:\n"
prompt2:
    .asciiz "Please enter the value of k[1-10]: "
prompt3:
    .asciiz "The sorted array is:\n"
sanityMesg:
    .asciiz "Invalid k entered!"
newline:
    .asciiz "\n"
result:
    .asciiz "The kth largest element is: "

# main program
#
# program variables
#   k: $s1
#   n: $s0
#   array: (see .data)
#   size: (see .data)

.text
    .ent main
main:

    li          $v0, 4           # print string mode
    la          $a0, prompt1     # Load the appropriate prompt message
    syscall                      # Call the print function

    lw          $s0, size        # s0 -> size fo the array (predefined to be 10)
    li          $t0, 0           # t0 -> index of array to read input
    la          $t1, array         # s1 -> base address of the array

    readInput:
        beq         $t0, $s0, readK              # i < n
        li          $v0, 5                       # read int mode
        syscall
        sw          $v0, 0($t1)                  # Move into appropriate place
        
        addi        $t0, $t0, 1                  # increase counter i++
        addi        $t1, $t1, 4                  # pointer arithmetic
        j           readInput                    # repeat the loop

    readK:
        li          $v0, 4                       # print the required prompt
        la          $a0, prompt2
        syscall

        li          $v0, 5                       # Read int mode
        syscall
        move        $s1, $v0                     # $s1 = k

        bgt         $s1, $s0, sanityCheck        # k > n
        ble         $s1, $zero, sanityCheck      # k <= 0

    callSort:
        la          $a0, array
        lw          $a1, size
        jal         sortArray                    # jump and link, call sort procedure
        j           printOutput

    sanityCheck:                                 # Sanity checks for input
        li          $v0, 4
        la          $a0, sanityMesg
        syscall
        j           exit

    printOutput:                                 # Prints the array
        la          $t1, array                   # base address of the array
        li          $t2, 0                       # i = 0

        li          $v0, 4                       # Print string mode
        la          $a0, prompt3
        syscall

    printLoop: 
        beq         $t2, $s0, printKth           # compare if i < n
        sll		    $t3, $t2, 2			         # $t3 = $t2 << 2
        add         $t3, $t1, $t3                # add to base address   

        li	    	$v0, 1                       # print int mode
        lw          $a0, 0($t3)
        syscall

        li          $v0, 4                       # print string mode
        la          $a0, newline                 # for newline
        syscall    

        addi        $t2, 1                       # i++
        j printLoop
        
    printKth:
        li          $v0, 4                       # print string mode
        la          $a0, result
        syscall

        sub         $s1, $s0, $s1                # k = n - k since kth largest element is present at index n - k
        sll         $s1, $s1, 2
        add         $s1, $t1, $s1

        lw          $t1, 0($s1)                  # load word for printing
        li          $v0, 1                       # print int mode
        move        $a0, $t1                     # printing A[k]
        syscall

    exit:
        li          $v0, 10                      # terminate the program
        syscall
    .end main


# beginning of the sortArray procedure
    .ent sortArray
sortArray:
    # $a0 -> base address
    # $a1 -> n

    addi        $sp, $sp, -8
    sw          $s0, 0($sp)
    sw          $s1, 4($sp)
    
    move        $s0, $a0                     # s0 contains the base address
    li          $t0, 1                       # j (index for the outer loop)
    
    outerLoopP1:
        beq         $t0, $a1, sorted         # j < 10
        sll         $t1, $t0, 2
        add         $t1, $s0, $t1            # t1 <- &A[j]
        lw          $t2, 0($t1)              # t2 <- A[j] (temp)
        move        $t3, $t0                 # t3 = i <- j
        addi        $t3, -1                
        
    innerLoop:
        blt         $t3, $zero, outerLoopP2  # if i < 0
        sll         $t4, $t3, 2
        add         $t4, $s0, $t4            # t4 <- &A[i]
        
        lw          $t5, 0($t4)              # t5 <- A[i]
        blt         $t5, $t2, outerLoopP2    # A[i] < temp

        sw          $t5, 4($t4)              # $t4 + 4 is the address of A[i+1] , so A[i+1] = A[i]
        addi        $t3, -1                  # i--
        j           innerLoop
        
    outerLoopP2:
        addi        $t3, 1                   # i + 1
        sll         $t7, $t3, 2              # 4*(i + 1)
        add         $t7, $s0, $t7            # t7 = &A[i+1]

        sw          $t2, 0($t7)              # A[i+1] = temp
        addi        $t0, 1                   # increment index in for loop
        j           outerLoopP1

    sorted:                                  # end of the function
        lw          $s0, 0($sp)              # restore ra from stack
        lw          $s1, 4($sp)
        addi        $sp, $sp, 8              # restore stack pointer
        jr          $ra                      # return from function

    .end sortArray
    
