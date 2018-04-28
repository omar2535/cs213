.pos 0x100
                 ld   $0x0, r0            # r0 = 0
                 ld   $t, r1              # r1 = address of t
				 ld   $array,r2			  # r2 = address of array
				 ld   0x0(r2), r3	      # r3 = pointer to array
				 st   r3, (r1,r0,4)       # store r3 at position 0 into r1. t = array[0]
				 ld   $0x0, r0            # r0 = 1
                 ld   $0x2004, r4         #address of array[1]
                 ld   0x0(r4), r4         #pointer of array[1]
                 st   r4, (r2,r0,4)       #stores array[1] into array[0]
                 ld   $0x2004, r5         #stores address of array[1] = r5
                 ld   0x0(r1), r1         #r1 = pointer of t
                 st   r1, (r5,r0,4)       
                 
                 halt                     # halt
.pos 0x1000
t:               .long 0x00000000         # t
.pos 0x2000
array:           .long 0x00000003         # array[0]
                 .long 0x00000002         # array[1]