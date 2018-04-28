.pos 0x10000
                        ld $i, r0           #r0 = address of i
                        ld (r0), r0         #r0 = value of i
                        ld $0, r1           #r1 = 0
                        ld $5, r2           #r2 = 5
                        ld $a, r4           #r4 = address at a
                        ld $s, r5           #r5 = address at s    
                        ld (r5), r6         #r6 = value of s                     
loop:                   mov r1, r3          #r3 = 0            
                        not r3              #
                        inc r3              #convert r1 to negative
                        add r2, r3          #r3 = r2 + r3
                        beq r3, endloop
                        ld (r4, r1, 4), r7  #r7 = a[i]
                        bgt r7, add         #if (r7 > 0)
                        inc r1
                        br loop             #loop back
add:                    add r7, r6
                        inc r1
                        br loop
endloop:                ld $i, r0           #r0 = address of i
                        st r2, (r0)         #i = 5
                        st r6, (r5)         #s = r5
halt






.pos 0x2000
i:                      .long 0xa           #i = 10
.pos 0x3000
a:                      .long 0xa           #a[0]= 10
                        .long -30           #a[1]= 30
                        .long -12           #a[2]= 12
                        .long 0x4           #a[3]= 4
                        .long 0x8           #a[4]= 8
.pos 0x5000             
s:                      .long 0x0           #s = 0
