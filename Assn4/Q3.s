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


    