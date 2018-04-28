.pos 0x1000
start:              ld $src, r3             # r3 = address of src
                    ld $stackBtm, r5        # r5 = address of stack on bottom
                    gpc $6, r6              # store return address into r6
                    j copy                  # jump to copy
                    halt                    # halt

copy:               st r6, (r5)             # store return address into stack
                    ld $0xfffffff8, r0      # -8 to allocate space on stack
                    add r0, r5              # added 2 spaces on stack     
                    ld $0, r1               # r1 = counter i 

loop:               ld (r3, r1, 4), r4      # r4 = src[i]
                    beq r4, end_loop        # if src[i] == 0, break out of loop
                    st r4, (r5)             # store src[i] into stack[3]= dst[0]
                    inca r5                 # r5 = r5+4
                    inc r1                  # i++
                    br loop                 # keep looping

end_loop:           ld $0, r1               # r1 = 0
                    st r1, (r5)             # dst[i] = 0
                    inca r5                 # r5+=4
                    ld (r5), r6             # load return value into r6
                    inca r5                 # stack +=4
                    j (r6)                  # jump back to caller function







.pos 0x7000
stackTop:           .long 0x00000000
                    .long 0x00000000         
                    .long 0x00000000         
                    .long 0x00000000         
                    .long 0x00000000         
                    .long 0x00000000         
                    .long 0x00000000         
                    .long 0x00000000         
                    .long 0x00000000         
stackBtm:           .long 0x00000000

src:                .long 1
                    .long 1
                    .long 0x7028
                    .long 0x7028
                    .long 0x7028
                    .long 0x7028
                    .long 0x7028
                    .long 0
                    ld $-1, r0
                    ld $-1, r1
                    ld $-1, r2
                    ld $-1, r3
                    ld $-1, r4
                    ld $-1, r5
                    ld $-1, r6
                    ld $-1, r7
                    ld $-1, r0
                    halt