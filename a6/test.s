.pos 0x000
                ld $0, r1
                ld $1, r2
                ld $0x100, r3
                br omar                         #testing branch
                ld $100, r0

omar:
                ld $5, r1
                ld $2, r2
                ld $0, r3
                beq r3, ifzero                  #testing branch if equals 0
                ld $5, r6                       #should not load 5 into r6

ifzero:         gpc $5, r5                      #testing program counter
                j jumpwhenzero                  #testing jump

jumpwhenzero:
                ld $0, r1                       
                bgt r2, jumpgreaterzero         #testing if greater
                ld $6, r6                       #should not load 6 into r6

jumpgreaterzero:
                ld $5000, r2                    
                j 0(r3)                         #testing indirect jump