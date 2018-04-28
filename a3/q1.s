
.pos 0x100
                ld $i, r0               #r0 = address of i
                ld $j, r1               #r1 = address of j
                ld $a, r2               #r2 = address of a

                ld $0x3, r4             #r4 = 3
                ld (r2,r4,4), r3        #r3 = value of a[3]
                st r3, (r0)             #i = value of a[3]

                ld (r0), r4             #r5 = i
                ld (r2,r4,4), r3        #r3 = value of a[i]
                st r3, (r0)             #i = value of a[i]
                
                ld $p, r5               #r5 = address of p
                st r1, (r5)             #p = address of j

                ld $p, r6               #r6 = address of p
                ld (r6), r6             #r6 = value of p (currently address of j)
                ld $0x4, r7             #r7 = 4
                st r7, (r6)             # *p = 4

                #All registers after r2 are available after this point

                ld $p, r6               #r6 = address of p
                ld $0x2, r4             #r4 = 2
                ld (r2, r4, 4), r3      #r3 = a[2] = 3

                shl $2, r3              # r3 = 4 * 3 = 12
                add r2, r3              # r3 = address of a + 12
                st r3, (r6)             # m(r6 is address of p) is now address of a[a[2]] which has value 16396

                ld (r6), r6             #r6 = value of p (currently address of a[a[2]])
                ld (r6), r7             #r7 = vlaue of a[a[2]], r6 is still address of a[a[2]]
                ld $0x4, r5
                ld (r2,r5,4), r3        #r3 = value of a[4]
                add r3, r7              # r7 = a[a[2]] + a[4]
                st r7, (r6)             # *p = *p + a[4] = 4 + 5


                halt                    #halt




.pos 0x1000
i:              .long 0x00000001
.pos 0x2000
j:              .long 0x00000002
.pos 0x3000
p:              .long 0
.pos 0x4000
a:              .long 0x00000001
                .long 0x00000002
                .long 0x00000003
                .long 0x00000004
                .long 0x00000005
                .long 0x00000006
                .long 0x00000007
                .long 0x00000008
                .long 0x00000009
                .long 0x0000000a

