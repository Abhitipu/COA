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
    .asciiz "Enter n(positive integer): "
prompt2:
    .asciiz "Enter a(positive integer): "
prompt3:
    .asciiz "Enter r(positive integer): "
message1:
    .asciiz "The Array A:\n"
message2:
    .asciiz "The Array B = (A)' : \n"
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
# s1            : n the row and column size of the matrix
# s2            : a the start of GP
# s3            : r the common ratio of GP
# s4            : base Address of Array A
main:
    jal         initStack                           # initializing stack
   
    li          $v0, 4                              # print string mode
    la          $a0, prompt1                        # loading the address of prompt 1
    syscall

    li          $v0, 5                              # read int mode
    syscall                                         # scans int into $v0
    add         $s1, $zero, $v0                     # saves n in $s1

    li          $v0, 4                              # print string mode
    la          $a0, prompt2                        # loading the address of prompt 2
    syscall

    li          $v0, 5                              # read int mode
    syscall                                         # scans int into $v0
    add         $s2, $zero, $v0                     # saves a in $s2

    li          $v0, 4                              # print string mode
    la          $a0, prompt3                        # loading the address of prompt 3
    syscall

    li          $v0, 5                              # read int mode
    syscall                                         # scans int into $v0
    add         $s3, $zero, $v0                     # saves r in $s3

    
    la          $a1, sanityMessage                  # prepare arguments for sanity check of $s1
    add         $a0, $zero, $s1                      
    jal		    sanityCheck				            # jump to sanityCheck and save position to $ra

    la          $a1, sanityMessage                  # prepare arguments for sanity check of $s2
    add         $a0, $zero, $s2                      
    jal		    sanityCheck				            # jump to sanityCheck and save position to $ra

    la          $a1, sanityMessage                  # prepare arguments for sanity check of $s3
    add         $a0, $zero, $s3                      
    jal		    sanityCheck				            # jump to sanityCheck and save position to $ra

    mult	    $s1, $s1			                # $s1 * $s1 = Hi and Lo registers
    mflo	    $a0					                # copy Lo to $a0 = n*n
    jal         mallocInStack                       # malloc(n*m)

    move        $s4, $v0                            # s4 = base address
    
    move        $a0, $s4                            # base address - Arg 1
    move        $a1, $s1                            # n no of row/col - Arg 2
    move        $a2, $s2                            # a - Arg 3
    move        $a3, $s3                            # r - Arg 4
    jal         fillMatrix                          # fillMatrix(A, n, a, r);

    li          $v0, 4                              # print string mode
    la          $a0, message1                       # prints "the array A"
    syscall
    
    move        $a0, $s1                            
    move        $a1, $s1
    move        $a2, $s4
    jal         printMatrix                         # call print matrix with argument m, n, Addr(A)

    move        $a0, $s1
    move        $a1, $s4
    jal         recursive_Det
    move        $a0, $v0
    li          $v0, 1
    syscall

    move        $sp, $fp                            # start restoring stack and freeing memory
    lw          $fp, ($fp)                          # restore fp
    addi        $sp, $sp, 4                         # deallocate 4
    j           endProg






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

fillMatrix:
# fillMatrix a0-Array Base address, a1 - n(rows and col), a2(gp a0 element), a3(r ratio)
    mult        $a1, $a1                            # HI,LO = n*n
    mflo        $t1                                 # t1 = n*n
    li          $t0, 0                              # i 1D equivalent index
    move        $t2, $a2                            # load gp first element
fillMatrix_loop_begin:
    beq         $t0, $t1, fillMatrix_loop_end       # if i == n*n break
    sll         $t3, $t0, 2                         # i changed into bytes
    add         $t3, $t3, $a0                       # t3 = (A + 4*i)
    sw          $t2, ($t3)                          # *(A+4*i) = gpElement
    mult        $t2, $a3                            # gpElement * ratio
    mflo        $t2                                 # t2 updated
    add         $t2, $t2, $t0                       # additional constraint
    addi        $t0, $t0, 1                         # ++i
    j		    fillMatrix_loop_begin				# jump to fillMatrix_loop_begin
fillMatrix_loop_end:
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

recursive_Det:
    # parameters a0 - n', a1 - Adderess Of n'xn' matrix/array , n'>0 by sanityCheck in main
recursive_Det_Base:
    li          $t0, 1                              # t0 = 1
    bne         $a0, $t0, recursive_Det_Recurse     # if n' != 1, go to recurse
    lw          $v0, ($a1)                          # load A[0][0]
    jr          $ra                                 # return
recursive_Det_Recurse:
    # Basic Frame structure
    # | a0  |12  a0 or n'
    # | a1  |8   a1 or Base Addr of array
    # | ra  |4   The return address
    # | fp' |0   <- fp M[fp] = old fp pointer
    # | i   |-4  i = row index                                      (register t1)
    # | j   |-8  j = col index                                      (register t2)
    # | Ans |-12 This stores the return value                       (register t3)
    # | fla |-16 Flag to tell if we need to add(=0) or subtract(=1) (register t4)
    # | k   |-20 k = n*i + j, k goes from 0 to n*n -1               (register t5)
    # | A'  | -24 address of intermediate array         
    # therefore we use 11*4 bytes thus we will decrease the stack by 44 bytes
    addi        $sp, $sp, -16                       # allocate space on the stack
    sw          $fp, ($sp)                          # M[sp] = fp
    move        $fp, $sp                            # fp = sp
    sw          $a0, 12($fp)                        # fp[12] = a0 = n
    sw          $a1, 8($fp)                         # fp[8] = a1 = A
    sw          $ra, 4($fp)                         # fp[4] = ra
    addi        $sp, $sp , -24                      # local variables
    move        $t1, $zero                          # $t1 initialized
    sw          $t1, -4($fp)                        # fp[-4] = 0 = i
    move        $t2, $zero                          # $t2 initialized
    sw          $t2, -8($fp)                        # fp[-8] = 0 = j
    move        $t3, $zero                          # $t3 initialized
    sw          $t3, -12($fp)                       # fp[-12] = 0 = ans
    move        $t4, $zero                          # $t4 initialized
    sw          $t4, -16($fp)                       # f[-16] = 0 = flag
    move        $t5, $zero                          # $t5 initialized
    sw          $t5, -20($fp)                       # f[-20] = 0 = k

recursive_Det_Recurse_loop_begin:
    # get the intermediate array
    lw          $t5, -20($fp)                       # load k
    lw          $a0, 12($fp)                        # load n
    beq         $a0, $t5, recursive_Det_Recurse_loop_end    # loop termination , k==n
    addi        $t5, $t5, 1                         # t5++
    sw          $t5, -20($fp)                       # k updated and stored

    lw          $t6, 8($fp)                         # t6 = fp[8] = baseAddress
    move        $a0, $t6                            # a0 = base Address

    lw          $t6, -4($fp)                        # t6 = fp[-4] = i
    move        $a1, $t6                            # a1 = i

    lw          $t6, -8($fp)                         # t6 = fp[-8] = j
    move        $a2, $t6                            # a2 = j
    
    lw          $t6, 12($fp)                        # t6 = fp[12] = n
    move        $a3, $t6                            # a3 = n
    jal         getIntermediateMatrix               # getIntermediateMatrix(A, i, j, n)
    sw          $v0, -24($fp)
    move        $a2, $v0                            
    lw          $a1, 12($fp)
    addi        $a1, $a1, -1
    move        $a0, $a1
    jal         printMatrix

    lw          $t6, 12($fp)                        # t6 = n
    addi        $t6, $t6, -1                        # t6 = n' = n-1
    move        $a0, $t6                            # argument 1
    
    lw        $a1, -24($fp)                            # argument 2 base address of An'xn'
    jal         recursive_Det                       # recursive call

    lw          $t6, -16($fp)                       # flag
    bne         $t6, $zero, recursive_Det_Recurse_loop_sub  # flag to corresponding (-1)^(i+j)
recursive_Det_Recurse_loop_add:
    addi        $t6, $t6, 1                         # t6 = 0 + 1 = 1
    sw          $t6, -16($fp)                       # flag updated and stored        
    lw          $t3, -12($fp)                       # ans loaded
    lw          $t5, -20($fp)                       # k+1 loaded
    addi        $t5, $t5, -1                        # k
    sll         $t5, $t5, 2                         # 4*k number of bytes
    lw          $a1, 8($fp)                         # a1 = base address = fp[8]
    add         $t5, $t5, $a1                       # t5 += a1 => t5 = addr of kth element
    lw          $t5, ($t5)                          # t5 = kth element
    mult        $t5, $v0                            # a[i][j] * v0
    mflo        $v0                                 # v0 = Mij *Aij
    add         $t3, $t3, $v0                       # ans += v0
    sw          $t3, -12($fp)                       # ans stored
    j           recursive_Det_Recurse_loop_continue # skip sub part
recursive_Det_Recurse_loop_sub:
    move        $t6, $zero                          # t6 = 0
    sw          $t6, -16($fp)                       # flag updated and stored 
    lw          $t3, -12($fp)                       # ans loaded
    lw          $t5, -20($fp)                       # k+1 loaded
    addi        $t5, $t5, -1                        # k
    sll         $t5, $t5, 2                         # 4*k number of bytes
    lw          $a1, 8($fp)                         # a1 = base address = fp[8]
    add         $t5, $t5, $a1                       # t5 += a1 => t5 = addr of kth element
    lw          $t5, ($t5)                          # t5 = kth element
    mult        $t5, $v0                            # a[i][j] * v0
    mflo        $v0                                 # v0 = Mij *Aij
    sub         $t3, $t3, $v0                       # ans -= v0
    sw          $t3, -12($fp)                       # ans stored
recursive_Det_Recurse_loop_continue:
    lw          $t1, -4($fp)                        # t1 = i
    lw          $t2, -8($fp)                        # t2 = j
    lw          $a0, 12($fp)                        # a0 = n
    addi        $t2, $t2, 1                         # j++
    bne         $t2, $a0, recursive_Det_Recurse_loop_endif  # if j == n need to update i,and j
    move        $t2, $zero                          # j = 0
    addi        $t1, $t1, 1                         # i++
recursive_Det_Recurse_loop_endif:
    sw          $t1, -4($fp)                        # i updated and stored
    sw          $t2, -8($fp)                        # j updated and stored
    j           recursive_Det_Recurse_loop_begin    # loop
recursive_Det_Recurse_loop_end:

    lw          $v0, -12($fp)                       # ans loaded
    lw          $ra, 4($fp)                         # ra restored
    # move        $sp, $fp                            
    lw          $fp, ($fp)                          # fp restored
    # addi        $sp, $sp, 16                        # stack poped
    jr          $ra                                 # return to ra with answer in v0

getIntermediateMatrix:
    # getIntermediateMatrix(A, i, j, n)
    # a0 = Base Address original
    # a1 = i th row to skip
    # a2 = j th col to skip
    # a3 = n size of original matrix
    
    # frame structure
    # a0 20
    # a1 16
    # a2 12
    # a3 8
    # ra 4
    # fp 0<-fp
    addi        $sp, $sp, -24                       # allocated 24 bytes
    sw          $fp, ($sp)                          # fp stored
    move        $fp, $sp                            # fp = sp
    sw          $ra, 4($fp)                         # fp[4] = ra
    sw          $a0, 20($fp)                        # fp[20] = a0                     
    sw          $a1, 16($fp)                        # fp[16] = a1                 
    sw          $a2, 12($fp)                        # fp[12] = a2                 
    sw          $a3, 8($fp)                         # fp[8] = a3
    addi        $a3, $a3, -1                        # n--           
    mult        $a3, $a3                            # Hi, Lo = (n-1) * (n-1)
    mflo        $a0                                 # a0 = (n') * (n')
    jal         mallocInStack                       # call malloc and allocate a0 integer space
    lw          $a3, 8($fp)                         # a3 loaded (n loaded)
    mult        $a3, $a3                            # Hi, Lo = (n) * (n)
    mflo        $t3                                 # t3 = n*n          
    lw          $a0, 20($fp)                        # a0 loaded Base Address                     
    lw          $a1, 16($fp)                        # a1 loaded i to skip                 
    lw          $a2, 12($fp)                        # a2 loaded j to skip                
    move        $t0, $zero                          # t0 = k  0 -> n*n 
    move        $t1, $zero                          # t1 = k' 0 -> n'*n'
    move        $t4, $zero                          # i of old matrix
    move        $t5, $zero                          # j of old matrix
getIntermediateMatrix_loop:
    beq         $t0, $t3, getIntermediateMatrix_loop_end    # loop termination condition
    bne         $t5, $a3, getIntermediateMatrix_loop_endIf1 # if j != n, then ok , skip if part
    addi        $t4, $t4, 1                         # i++
    move        $t5, $zero                          # j = 0 new row
getIntermediateMatrix_loop_endIf1:
    # see if i == iskip 
    bne         $t4, $a1, getIntermediateMatrix_loop_endIf2 # if i != iskip then ok
    # then k += n i++ and continue
    add         $t0, $t0, $a3                       # k+= n
    addi        $t4, $t4, 1                         # i++
    j           getIntermediateMatrix_loop          # continue loop
getIntermediateMatrix_loop_endIf2:
    # see if j == jskip
    bne         $t5, $a2, getIntermediateMatrix_loop_endIf3 # if j != jskip then ok
    # then j++, k++ and continue
    addi        $t0, $t0, 1                         # k+= n
    addi        $t5, $t5, 1                         # j++
    j           getIntermediateMatrix_loop          # continue loop 
    
getIntermediateMatrix_loop_endIf3:
    sll         $t6, $t0, 2
    add         $t6, $a0, $t6
    lw          $t6, ($t6)
    sll         $t7, $t1, 2
    add         $t7, $v0, $t7
    sw          $t6, ($t7)
    addi        $t5, $t5, 1                         # j++
    addi        $t1, $t1, 1
    addi        $t0, $t0, 1
    # lw k and place to k''
    # k++
    # k''++
    # lopp

    j           getIntermediateMatrix_loop
getIntermediateMatrix_loop_end:
    lw          $ra, 4($fp)
    lw          $fp, ($fp)
    jr          $ra




sanityCheck:                                        # Takes the number in $a0, invalid message address in $a1.
                                                    # and performs sanity check, if falied shows error message
                                                    # goes to end Program
    lw          $t0, sanitymin                    
    slt         $t1, $a0, $t0                       # t1 = num<sanityMin ? 1:0
    add		    $a0, $zero, $a1		                # $a0 = $zero + $a1 to call Invalid message
    bne         $t1, $zero, InvalidMessage          # if num<sanityMin jump to Invalid message
    jr		    $ra					                # jump to $ra

InvalidMessage:                                     # print invalid message passed as argument and exits
    li          $v0, 4
    syscall
    j           endProg

endProg:
    li          $v0, 10
    syscall
    