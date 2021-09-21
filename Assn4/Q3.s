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
    .globl  initStack
    .globl  pushToStack
    .globl  printArray
    .globl  popFromStack
    .globl  SWAP

    .data
        array:    .space  40
        size:   .word   10

# program output text constants
prompt:
    .asciiz "Enter 2 numbers: "
prompt1:
    .asciiz "Please enter 10 integers one by one:\n"
prompt2:
    .asciiz "Read input\n"
prompt3:
    .asciiz "Printing current array:\n"
prompt4:
    .asciiz "Enter n, then integer to be searched for: "
sanityMesg:
    .asciiz "Inside sort!\n"
newline:
    .asciiz "\n"
result:
    .asciiz "The sorted array is: \n"
result1:
    .asciiz " is found in the array at index "
result2:
    .asciiz " NOT FOUND in the array!\n"

# main program
#
# program variables

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
        beq         $t0, $s0, Sort # i < n
        li          $v0, 5                       # read int mode
        syscall
        sw          $v0, 0($t1)                  # Move into appropriate place
        
        addi        $t0, $t0, 1                  # increase counter i++
        addi        $t1, $t1, 4                  # pointer arithmetic
        j           readInput                    # repeat the loop

    Sort:
        la          $a0, array                  # a0 <- base address
        move        $a1, $zero                  # a1 <- 0
        lw          $a2, size                   # a2 <- n
        addi        $a2, $a2, -1                # a2 <- n-1
        jal         sortArray                    # jump and link, call sort procedure

        li          $v0, 4           # print string mode
        la          $a0, result     # Load the appropriate prompt message
        syscall                      # Call the print function

        la          $a0, array
        move        $a1, $s0
        jal		    printArray				# jump to printArray and save position to $ra

    search:
        la          $a0, prompt4            # load appropriate prompt message
        li          $v0, 4                  # print string mode
        syscall

        li          $v0, 5                  # read int mode
        syscall
        move        $a3, $v0                # a3 <- key   
        move        $s1, $a3                # key saved in s1
        la          $a0, array              # A = addr(array)
        li          $a1, 0                  # start = 0
        addi        $a2, $s0, -1            # end = size - 1
        jal         recurse_search          # jump and link, to recurse_search sub routine
        move        $s2, $v0                # return value saved
        li          $t1, -1                 # t1 = -1
        bne         $v0, $t1,search_found          # index != -1
        li          $v0, 1                  # print int mode
        move        $a0, $s1                # a0 = key
        syscall
        la          $a0, result2
        li          $v0, 4
        syscall
        j           exit

    search_found:
        li          $v0, 1                  # print int mode
        move        $a0, $s1                # a0 = key
        syscall
        la          $a0, result1
        li          $v0, 4
        syscall
        li          $v0, 1                  # print int mode
        move        $a0, $s2                # return value
        syscall
        la          $a0, newline
        li          $v0, 4
        syscall
        j           exit
    exit:
        li          $v0, 10                      # terminate the program
        syscall
    .end main


# beginning of the sortArray procedure
    .ent sortArray
sortArray:
    # $a0 -> base address (same for each function call)
    # $a1 -> left   (only these two arguments change)
    # $a2 -> right

    # Inside the function we will have:
    # $s0 -> l
    # $s1 -> r
    # $s2 -> pivot
    # $s3 -> base address
    # $s4 -> left
    # $s5 -> right

    addi        $sp, $sp, -28       # backing up calee saved register contents along with ra
    sw          $s5, 24($sp)
    sw          $s4, 20($sp)
    sw          $s3, 16($sp)
    sw          $s2, 12($sp)
    sw          $s0, 8($sp)
    sw          $s1, 4($sp)
    sw          $ra, 0($sp)

    move        $s3, $a0        # s3 -> base address
    move        $s4, $a1        # will store left!
    move        $s5, $a2        # will store right

    move 	    $s0, $a1		# s0(l) <- left
    move        $s1, $a2	    # s1(r) <- right
    move        $s2, $a1        # s2(pivot) <- left

    sortLoop:
       bge		$s0, $s1, sorted    # l >= r -> done

    leftMovement:
        bge     $s0, $s5, rightMovement         # l >= right            

        move    $t0, $s0            # t0 <- l
        sll     $t0, $t0, 2         # t0 <- 4*l
        add     $t0, $s3, $t0       # t0 <- arr + 4*l

        move    $t1, $s2            # t1 <- pivot
        sll     $t1, $t1, 2         # t1 <- 4*pivot
        add     $t1, $s3, $t1       # t1 <- arr + 4*pivot

        lw      $t2, 0($t0)         # t2 <- arr[l]
        lw      $t3, 0($t1)         # t3 <- arr[p]

        bgt     $t2, $t3, rightMovement         # if arr[l] > arr[p]
        addi    $s0, $s0, 1                     # l++
        j		leftMovement				# continue with loop

    rightMovement: 
        ble     $s1, $s4, checkRecurse      # r <= left
        move    $t0, $s1            # t0 <- r
        sll     $t0, $t0, 2         # t0 <- 4*r
        add     $t0, $s3, $t0       # t0 <- arr + 4*r

        move    $t1, $s2            # t1 <- pivot
        sll     $t1, $t1, 2         # t1 <- 4*pivot
        add     $t1, $s3, $t1       # t1 <- arr + 4*pivot

        lw      $t2, 0($t0)         # t2 <- arr[r]
        lw      $t3, 0($t1)         # t3 <- arr[p]

        blt     $t2, $t3, checkRecurse      # if arr[r] < arr[p]
        addi    $s1, $s1, -1                # r--
        j		rightMovement                   # jump to leftMovement
    
    checkRecurse:
        blt      $s0, $s1, continueLoop     # if l < r 

        move    $a0, $s2                    # a0 <- pivot
        sll     $a0, $a0, 2                 # a0 <- 4*pivot
        add     $a0, $s3, $a0               # a0 <- arr + 4*pivot

        move    $a1, $s1                    # a1 <- l
        sll     $a1, $a1, 2                 # a1 <- 4*l
        add     $a1, $s3, $a1               # a1 <- arr + 4*l

        jal     SWAP

        move    $a0, $s3                    # a0 <- base address
        move    $a1, $s4                    # a1 <- left
        move    $a2, $s1                    # a2 <- r
        addi    $a2, $a2, -1                # a2 <- r - 1
        jal     sortArray

        move    $a0, $s3                    # a0 <- base address
        move    $a1, $s1                    # a1 <- r
        addi    $a1, $a1, 1                 # a1 <- r + 1
        move    $a2, $s5                    # a2 <- right
        jal     sortArray

        j       sorted
       
    continueLoop:
        #swap and continue
        move    $a0, $s0                    # a0 <- l
        sll     $a0, $a0, 2                 # a0 <- 4*l
        add     $a0, $s3, $a0               # a0 <- arr + 4*l

        move    $a1, $s1                    # a1 <- r
        sll     $a1, $a1, 2                 # a1 <- 4*r
        add     $a1, $s3, $a1               # a1 <- arr + 4*r

        jal     SWAP

        j		sortLoop				# jump to sortLoop

    sorted:
        lw          $ra, 0($sp)
        lw          $s1, 4($sp)
        lw          $s0, 8($sp)
        lw          $s2, 12($sp)
        lw          $s3, 16($sp)
        lw          $s4, 20($sp)
        lw          $s5, 24($sp)
        addi        $sp, $sp, 28
        jr          $ra
    .end sortArray
    
    .ent initStack    
initStack:
    # need to save current fp
    addi        $sp, $sp, -4                        # allocating 4 bytes
    sw          $fp, ($sp)                          # saving fp on stack
    move        $fp, $sp                            # initiating new frame pointor
    jr          $ra                                 # return to ra
    .end initStack    

    .ent pushToStack
pushToStack:
    addi        $sp, $sp, -4                        # allocating 4 bytes, sp-=4
    sw          $a0, ($sp)                          # saves a0 to M[sp]
    jr          $ra                                 # return to ra
    .end pushToStack

    .ent popFromStack
popFromStack:                                       # pops last integer from the stack, and returns the v0
    lw          $v0, ($sp)                          # loads M[sp] on v0
    addi        $sp, $sp, 4                         # deallocate 4 bytes
    jr          $ra                                 # return to ra
    .end popFromStack

# the swap procedure
    .ent SWAP
SWAP:                                               
    # arg1 in $a0 
    # arg2 in $a1

    addi    $sp, $sp, -8        # save the contents of s0 and s1 in the stack
    sw      $s0, 4($sp)
    sw      $s1, 0($sp)

    lw      $s0, 0($a0)         # load the numbers into s0 and s1
    lw      $s1, 0($a1)    

    sw      $s1, 0($a0)         # store contents after swapping
    sw      $s0, 0($a1)    

    lw      $s1, 0($sp)         # restore the values in s0 and s1 from stack
    lw      $s0, 4($sp)
    addi    $sp, $sp, 8         # restore  stack pointer

    jr      $ra
    .end SWAP

# procedure for printing an array
    .ent printArray
printArray:

    addi    $sp, $sp, -8        # save the contents of s0 and s1 in the stack
    sw      $s0, 4($sp)
    sw      $s1, 0($sp)

    move 	$s0, $a0                        # $s0 <- base address
    move    $s1, $a1                        # s1 <- n
    move    $t2, $zero                      # t2(i) <- 0

    printLoop: 
        bge         $t2, $s1, printed           # compare if i < n
        sll		    $t3, $t2, 2			         # $t3 = $t2 << 2
        add         $t3, $s0, $t3                # add to base address   

        li	    	$v0, 1                       # print int mode
        lw          $a0, 0($t3)
        syscall

        li          $v0, 4                       # print string mode
        la          $a0, newline                 # for newline
        syscall    

        addi        $t2, $t2, 1                       # i++
        j printLoop

    printed:
        lw      $s1, 0($sp)         # restore the values in s0 and s1 from stack
        lw      $s0, 4($sp)
        addi    $sp, $sp, 8         # restore  stack pointer
        jr		$ra					# jump to $ra
        
    .end printArray


# Arguments 
# A - Basr Address of the array
# start - start index
# end - end index
# key - Value to search

# local variables
# mid1
# mid2

# frame structure
# variable                  offset          register(that may be used to access)
# A                         20              $a0
# start                     16              $a1
# end                       12              $a2
# key                       8               $a3

# ra  ( return address)     4               $ra
# fp' (old frame pointer)   0               $fp

# mid1                      -4              $t1
# mid2                      -8              $t2
recurse_search:
    slt             $t0, $a2, $a1           # if a2<a1 set t0 = 1 else t0 = 0;
    beq             $t0, $zero, recurse_search_continue  # if a1<=a2 then go to recurse, else proceed to search
    li              $v0, -1                 # reuturn -1
    jr              $ra                     # jump to ra
recurse_search_continue:
    addi            $sp, $sp, -24           # Allocating some space for Arguments, return address and frame pointor
    sw              $fp, ($sp)              # M[sp] = fp
    move            $fp, $sp                # fp = sp
    addi            $sp, $sp, -8             # 2 int space allocated for mid1 and mid2
    sw              $a0, 20($fp)            # fp[20] = a0
    sw              $a1, 16($fp)            # fp[16] = a1
    sw              $a2, 12($fp)            # fp[12] = a2
    sw              $a3, 8($fp)             # fp[8] = a3
    sw              $ra, 4($fp)             # fp40] = ra

    sub             $t0, $a2, $a1           # t0 = end - start
    li              $t1, 3
    div             $t0, $t1                # LO = floor((end -start)/3)
    mflo            $t0                     # t0 = (end - start) // 3
    add             $t1, $a1, $t0           # mid1= start + (end - start)/3
    sw              $t1, -4($fp)            # fp[-4] = mid1
    sub             $t2, $a2, $t0           # mid2= end - (end - start)/3
    sw              $t2, -8($fp)            # fp[-8] = mid2

    # Base Cases
    sll             $t0, $t1, 2             # t0 = mid1*4
    add             $t0, $t0, $a0           # t0 = A + mid1 * 4
    lw              $t0, ($t0)              # t0 = A[mid1]
    bne             $t0, $a3, recurse_search_continue1  # if key != A[mid1] search continues
    move            $v0, $t1                # v0 = mid1
    j               recurse_search_return   # jump to recurse_search_return and restore fp & sp and return

recurse_search_continue1:
    sll             $t0, $t2, 2             # t0 = mid2*4
    add             $t0, $t0, $a0           # t0 = A + mid2 * 4
    lw              $t0, ($t0)              # t0 = A[mid2]
    bne             $t0, $a3, recurse_search_continue2  # if key != A[mid2] search continues
    move            $v0, $t2                # v0 = mid2
    j               recurse_search_return   # jump to recurse_search_return and restore fp & sp and return

    # recursive cases    
recurse_search_continue2:
    sll             $t0, $t1, 2             # t0 = mid1*4
    add             $t0, $t0, $a0           # t0 = A + mid1 * 4
    lw              $t0, ($t0)              # t0 = A[mid1]
    slt             $t0, $a3, $t0           # t0 = (key < A[mid1]) ? 1 : 0
    beq             $t0, $zero, recurse_search_continue3    # if key>=A[mid1] search continues
    addi            $a2, $t1, -1            # a2 = mid1 - 1
    jal             recurse_search          # recursive call, v0 stores the ans
    j               recurse_search_return   # jump to recurse_search_return and restore fp & sp & ra and return

recurse_search_continue3:
    sll             $t0, $t2, 2             # t0 = mid2*4
    add             $t0, $t0, $a0           # t0 = A + mid2 * 4
    lw              $t0, ($t0)              # t0 = A[mid2]
    slt             $t0, $t0, $a3           # t0 = (A[mid2] < key) ? 1 : 0
    beq             $t0, $zero, recurse_search_continue4    # if key<=A[mid2] search continues
    addi            $a1, $t2, 1             # a1 = mid2 + 1
    jal             recurse_search          # recursive call, v0 stores the ans
    j               recurse_search_return   # jump to recurse_search_return and restore fp & sp & ra and return
               
recurse_search_continue4:
    addi            $a1, $t1, 1             # a1 = mid1 + 1
    addi            $a2, $t2, -1            # a2 = mid2 - 1
    jal             recurse_search          # recursive call, v0 stores the ans
    j               recurse_search_return   # jump to recurse_search_return and restore fp & sp & ra and return

recurse_search_return:
    lw              $ra, 4($fp)             # ra restored
    move            $sp, $fp                
    lw              $fp, ($fp)              # fp restored
    addi            $sp, $sp, 24            # sp restored
    jr              $ra                     # jump to ra

    