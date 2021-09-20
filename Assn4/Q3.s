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
    slti            $t0, $a1, $a2           # if a1<a2 set t0 = 1 else t0 = 0;
    beq             $t0, $zero, recurse_search_continue  # if a1<=a2 then go to recurse, else proceed to search
    li              $v0, -1                 # reuturn -1
    jr              $ra                     # jump to ra
recurse_search_continue:
    addi            $sp, $sp, -24           # Allocating some space for Arguments, return address and frame pointor
    sw              $fp, ($sp)              # M[sp] = fp
    move            $fp, $sp                # fp = sp
    addi            $sp, $sp, 8             # 2 int space allocated for mid1 and mid2
    sw              $a0, 20($fp)            # fp[20] = a0
    sw              $a1, 16($fp)            # fp[16] = a1
    sw              $a2, 12($fp)            # fp[12] = a2
    sw              $a3, 8($fp)             # fp[8] = a3
    sw              $ra, 4($fp)             # fp40] = ra

    sub             $t0, $a2, $a1           # t0 = end - start
    li              $t1, 3
    div             $t0, $t1                # HI = floor((end -start)/3)
    mfhi            $t0                     # t0 = (end - start) // 3
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
    bne             $t0, $zero, recurse_search_continue3    # if key>=A[mid1] search continues
    addi            $a2, $t1, -1            # a2 = mid1 - 1
    jal             recurse_search          # recursive call, v0 stores the ans
    j               recurse_search_return   # jump to recurse_search_return and restore fp & sp & ra and return

recurse_search_continue3:
    sll             $t0, $t2, 2             # t0 = mid2*4
    add             $t0, $t0, $a0           # t0 = A + mid2 * 4
    lw              $t0, ($t0)              # t0 = A[mid2]
    slt             $t0, $t0, $a3           # t0 = (A[mid2] < key) ? 1 : 0
    bne             $t0, $zero, recurse_search_continue4    # if key<=A[mid2] search continues
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

    