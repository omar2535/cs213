.pos 0x100
                ld $tmp, r0             #r0 = address of tmp
                ld $tos, r1             #r1 = address of tos
                ld $0x0, r2             #r2 = 0
                st r2, 0x0(r0)          #tmp = 0
                st r2, 0x0(r1)          #tos = 0
                ld $s, r3               #r3 = address of s
                ld $a, r4               #r4 = address of a 

                ld (r4,r2, 4), r5       #a[0] = r5
                ld (r1), r6             #r6 = value of tos
                st r5, (r3, r6, 4)      #s[tos] = a[0]
                inc r6                  #value of tos ++
                st r6, (r1)             #tos = r6


                ld $0x1, r2             #r2 = 1
                ld (r4, r2, 4), r5      #a[1] = r5
                st r5, (r3, r6, 4)      #s[tos] = a[1]
                inc r6                  #value of tos ++
                st r6, (r1)             #r6 = value of r1

                ld $0x2, r2             #r2 = 2
                ld (r4, r2, 4), r5      #a[1] = r5
                st r5, (r3, r6, 4)      #s[tos] = a[1]
                inc r6                  #value of tos ++
                st r6, (r1)             #r6 = value of r1

                dec r6                  #value of tos--
                st r6, (r1)             #tos = r6

                ld (r3, r6, 4), r7      #r7 = s[tos]
                st r7, (r0)             #tmp = s[tos]

                dec r6                  #value of tos--
                st r6, (r1)             #tos = r6
                ld (r3, r6, 4), r7      #r7 = s[tos]

                ld (r0), r2             #r2 = value of tmp
                add r7, r2              #r2 = tmp + s[tos]
                st r2, (r0)             #tmp =tmp + s[tos]

                dec r6                  #value of tos--
                st r6, (r1)             #tos = r6
                ld (r3, r6, 4), r7      #r7 = s[tos]

                ld (r0), r2             #r2 = value of tmp
                add r7, r2              #tmp + s[tos]
                st r2, (r0)             #tmp = tmp+s[tos]

                halt


.pos 0x1000
a:              .long 0x00000001
                .long 0x00000002
                .long 0x00000003

.pos 0x2000
s:              .long 0x00000004
                .long 0x00000005
                .long 0x00000006
                .long 0x00000007
                .long 0x00000008

.pos 0x3000
tmp:            .long 0x00000005

.pos 0x3004
tos:            .long 0x00000005