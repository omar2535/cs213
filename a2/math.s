.pos 0x100
                    ld $a, r0                   #r0 = address at a
                    ld $b, r1                   #r1 = address at b
                    ld (r0), r2                 #r2 = value of a          
                    ld (r1), r3                 #r3 = value of b
                    inc r3                      #r3 = r3 add one
                    ld $4, r4                   #r4 = 4
                    add r4, r3                  #r3 = r4 + r3
                    shr $1, r3                  #<<r3
                    ld (r1), r4                 #r4 = value of b
                    and r4, r3                  #r3 = r3 & r4
                    shl $2, r3                  #r3 = r3 * 4
                    st  r3, (r0)                #a = r3


                    halt                        #stop



.pos 0x1000
a:                  .long 0x00000001            #a=1

.pos 0x2000
b:                  .long 0x00000007            #b=7
