.pos 0x1000
code:

                ld $v0, r0              #r0 = address at v0
                ld $i, r2               #r2 = address at i
                ld (r2), r2             #r2 = value at i
                ld $s, r3               #r3 = address at s 

                ld(r3, r2, 4), r4   
                st r4, (r0)
                


                ld $v1, r0
                ld 0x8(r3), r5
                ld (r5, r2, 4), r6  
                st r6, (r0)    
    
                
                ld $v2, r1              
                ld 0xc(r3), r4                    
                ld (r4, r2, 4), r5      
                st r5, (r1) 

                ld $v3, r1              #r1 = address at v3
                ld 0xc(r3), r4          #r4 = s.z 
                ld 0xc(r4), r4          #r4 = s.z.z
                ld 0x8(r4), r4          #r4 = s.z.z.y 
                ld (r4, r2, 4), r5      #r5 = s.z.x[i]
                st r5, (r1) 



                halt

                






.pos 0x2000
static:                                                   
i:              .long 0                 #i
v0:             .long 0                 #v0
v1:             .long 0                 #v1
v2:             .long 0                 #v2
v3:             .long 0                 #v3
s:              .long 5
                .long 0
                .long s_y               #s.y
                .long s_z               #s.z



.pos 0x3000
heap:


s_y:            .long 2                 # s.y[0]
                .long 0                 # s.y[1]

s_z:            .long 9
                .long 0
                .long s_z_y              
                .long s_z_z             

s_z_z:          .long 0
                .long 0
                .long s_z_z_y
                .long 0

s_z_z_y:        .long 3
                .long 0

s_z_y:          .long 0
                .long 0

