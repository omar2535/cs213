.pos 0x0
                 ld   $sb, r5                               #r5 = address of sb
                 inca r5                                    #r5 = (sb+1) 
                 gpc  $6, r6                                #r6 = sets r6 to 6 + PC
                 j    0x300                                 #jump to 0x300
                 halt                     
.pos 0x100
                 .long 0x00001000                           #sets constant called c which is a pointer
.pos 0x200  
                 ld   0x0(r5), r0                           #r0 = first argument on stack    a   
                 ld   0x4(r5), r1                           #r1 = second argument on stack   b
                 ld   $0x100, r2                            #r2 = address 0x100
                 ld   0x0(r2), r2                           #r2 = value at 0x100 = 4096
                 ld   (r2, r1, 4), r3                       #r3 = c[b]
                 add  r3, r0                                #a = c[b] + a
                 st   r0, (r2, r1, 4)                       #c[b] = a    
                 j    0x0(r6)                               #jump to r6
.pos 0x300
                 ld   $0xfffffff4, r0                       #r0 = space wanted on stack = 3
                 add  r0, r5                                #add space wanted to stack
                 st   r6, 0x8(r5)                           #store r6(program counter = 0x16) into stack bottom of stack
                 ld   $0x1, r0                              #r0 = 1
                 st   r0, 0x0(r5)                           #store 1 into top of stack
                 ld   $0x2, r0                              #r0 = 2
                 st   r0, 0x4(r5)                           #store 2 into middle of stack
                 ld   $0xfffffff8, r0                       #store number into r0
                 add  r0, r5                                #sb[0] = r0 + sb[0]
                 ld   $0x3, r0                              #r0 = 3
                 st   r0, 0x0(r5)                           #sb[0] = r0
                 ld   $0x4, r0                              #r0 = 4
                 st   r0, 0x4(r5)                           #sb[1] = r0
                 gpc  $6, r6                                #r6 = points to next next line
                 j    0x200                                 #jump into function
                 ld   $0x8, r0                              #r0 = 8
                 add  r0, r5                                #sb[0] = r0 + sb[0]
                 ld   0x0(r5), r1                           #r1 = sb[0]
                 ld   0x4(r5), r2                           #r2 = sb[1]
                 ld   $0xfffffff8, r0                       #r0 = number
                 add  r0, r5                                #sb[0] = sb[0] + r0
                 st   r1, 0x0(r5)                           #sb[0] = r1
                 st   r2, 0x4(r5)                           #sb[1] = r2
                 gpc  $6, r6                                #r6 = points to next next line
                 j    0x200                                 #jump to function
                 ld   $0x8, r0                              #r0 = 8
                 add  r0, r5                                #sb[0] = sb[0] + r0
                 ld   0x8(r5), r6                           #r6 = sb[2] = 0x16
                 ld   $0xc, r0                              #r0 = 12
                 add  r0, r5                                #sb[0] = sb[0] + r0
                 j    0x0(r6)                               #jump to halt
.pos 0x1000
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
.pos 0x8000
# These are here so you can see (some of) the stack contents.
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
sb: .long 0
