.pos 0x1000
                    #instantiate variables
                    ld $s, r0                   #r0 = address of s
                    ld (r0), r0                 #r0 = base address of array
                    ld $n, r1                   #r1 = address of n
                    ld (r1), r1                 #r1 = number of students

                    #going through the loop
main_loop:          beq r1, start               #if r1==0, end
                    ld $1, r2                   #r2 = 1
                    ld $2, r3                   #r3 = 2
                    ld $3, r4                   #r4 = 3
                    ld $4, r5                   #r5 = 4
                    
                    #Compute average
compute_average:    ld (r0, r2, 4), r2          #r2 = base[1]
                    ld (r0, r3, 4), r3          #r3 = base[2]
                    ld (r0, r4, 4), r4          #r4 = base[3]
                    ld (r0, r5, 4), r5          #r5 = base[4]
                    add r2, r3                  #r3 = r2+r3
                    add r3, r4                  #r4 = r3+r4
                    add r4, r5                  #r5 = r4+r5
                    shr $2, r5                  #r5 = r5/4
                    ld $5, r2                   #r2 = 5
                    st r5, (r0, r2, 4)          #base[5] = r5

                    #incrementing
                    inca r0                     #increment base address of array
                    inca r0                     
                    inca r0
                    inca r0
                    inca r0
                    inca r0 
                    dec r1                      #decrement r1
                    br main_loop                #goto main_loop

start:              ld $n, r1                   
                    ld (r1), r1                 #r1 = n
                    dec r1                      #r1--   

outer_loop:         beq r1, compute_median      #when i==0, end


inner_loop:         #if j > i, outer_next, otherwise, try to swap 
                    mov r1, r6                  #r6 = J 
                    not r6
                    inc r6
                    add r7, r6
                    bgt r6, outer_next

                    #intialize r0 as student[j-1]
                    ld $s, r0                   #r0 = address of s
                    ld (r0), r0                 #r0 = base address of array
                    mov r7, r6                  #r6 = r7
                    dec r6                      #r6 = J-1
                    mov r6, r3
                    shl $4, r3                  #r3 = (j-1)*16
                    shl $3, r6                  #r6 = (j-1)*8
                    add r3, r6                  #r6 = (j-1)*24
                    add r6, r0                  #r0 = r6+r0
                    
                    #swaps arguments at r0 and r0+1 if r0+1 > r0
swap:               ld $temp, r2                #r2 = address at temp
                    ld (r2), r2                 #r2 = temp[0]
                    
                    #check if average is higher 
                    ld $5, r3                   #r5 = 5
                    ld (r0, r3, 4), r4          #r4 = student1 average
                    mov r0, r6
                    inca r6
                    inca r6
                    inca r6
                    inca r6
                    inca r6
                    inca r6
                    ld (r6, r3, 4), r5          #r5 = student2 average
                    not r4                   
                    inc r4
                    add r5, r4
                    bgt r4, inner_next          #if student 1 average > student 2 average, swap


                    #save student  ID
                    ld $0, r3                   #r3 = 0
                    ld (r0, r3, 4), r4          #r4 = student1 ID
                    st r4, (r2, r3, 4)          #temp[0] = student1 ID
                    ld $1, r3                   #r3 = 1
                    ld (r0, r3, 4), r4          #r4 = student1 Grade1
                    st r4, (r2, r3, 4)          #temp[1] = student1 grade1
                    ld $2, r3                   #r3 = 2
                    ld (r0, r3, 4), r4
                    st r4, (r2, r3, 4)
                    ld $3, r3                   #r3 = 3
                    ld (r0, r3, 4), r4
                    st r4, (r2, r3, 4)
                    ld $4, r3                   #r3 = 4
                    ld (r0, r3, 4), r4
                    st r4, (r2, r3, 4)
                    ld $5, r3                   #r3 = 5
                    ld (r0, r3, 4), r4
                    st r4, (r2, r3, 4)
                    
                    #r0 = pointer to student 1, r3 = pointer to student 2
                    mov r0, r3                  #r3 = r2
                    inca r3                     #increment base address of array
                    inca r3                     
                    inca r3
                    inca r3
                    inca r3
                    inca r3                     #r3 points to student 2

                    #store student 2 into student 1 and student 1 into student 2
                    ld $0, r4                   #r4 = 0
                    ld (r3, r4, 4), r5          #r5 = student2 ID
                    ld (r2, r4, 4), r6          #r6 = student1 ID
                    st r5, (r0, r4, 4)          #student1 ID = student2 ID
                    st r6, (r3, r4, 4)          #student2 ID = student1 ID

                    ld $1, r4                   #r4 = 1
                    ld (r3, r4, 4), r5          #r5 = student2 Grade0
                    ld (r2, r4, 4), r6          #r6 = student1 Grade0
                    st r5, (r0, r4, 4)          #student1 grade0 = student2 grade0
                    st r6, (r3, r4, 4)          #student2 grade0 = student1 grade0

                    ld $2, r4                   #r4 = 2
                    ld (r3, r4, 4), r5          #r5 = student2 Grade1
                    ld (r2, r4, 4), r6          #r6 = student1 Grade1                    
                    st r5, (r0, r4, 4)          #student1 grade1 = student2 grade1
                    st r6, (r3, r4, 4)          #student2 grade1 = student1 Grade1

                    ld $3, r4                   #r4 = 3
                    ld (r3, r4, 4), r5          #r5 = student2 Grade2
                    ld (r2, r4, 4), r6          #r6 = student1 Grade2 
                    st r5, (r0, r4, 4)          #student1 grade2 = student2 grade2
                    st r6, (r3, r4, 4)          #student2 grade2 = student1 Grade2

                    ld $4, r4                   #r4 = 4
                    ld (r3, r4, 4), r5          #r5 = student2 Grade3
                    ld (r2, r4, 4), r6          #r6 = student1 Grade3 
                    st r5, (r0, r4, 4)          #student1 grade3 = student2 grade3
                    st r6, (r3, r4, 4)          #student2 grade3 = student1 Grade3

                    ld $5, r4                   #r4 = 5
                    ld (r3, r4, 4), r5          #r5 = student2 average
                    ld (r2, r4, 4), r6          #r6 = student1 average
                    st r5, (r0, r4, 4)          #student1 average = student2 average
                    st r6, (r3, r4, 4)          #student2 average = student1 average

inner_next:         inc r7                          
                    br inner_loop

outer_next:         dec r1                      #i--
                    ld $1, r7                   #j = 1
                    br outer_loop
               
compute_median:     ld $n, r0                   #address of not
                    ld (r0), r0                 #r0 = value of n 
                    ld $s, r3                   #r3 = address os s 
                    ld (r3), r3                 #r3 = base address of base 
                    ld $m, r4                   #r4 = address of m 
                    shr $1, r0                  #n/2
                    mov r0, r1                  #r1 = n/2 
                    shl $4, r1                  #r1 = r1*16
                    shl $3, r0                  #r0 = r0*8
                    add r1, r0                  #r0 = r0+r1
                    add r0, r3                  #r3 = base + offset
                    ld (r3), r5                 #r5 = ID of median student
                    st r5, (r4)                 #Store median into m
                    





end:                halt




.pos 0x7000
temp:               .long 0
                    .long 0
                    .long 0
                    .long 0
                    .long 0
                    .long 0


.pos 0x8000
n:                  .long 1 # just one student
m:                  .long 0 # put the answer here
s:                  .long base # address of the array
base:               .long 1234 # student ID
                    .long 80 # grade 0
                    .long 60 # grade 1
                    .long 78 # grade 2
                    .long 90 # grade 3
                    .long 0 # computed average