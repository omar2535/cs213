.pos 0x0
                 ld   $0x1028, r5         # r5 = address at 0x1028
                 ld   $0xfffffff4, r0     # r0 = -12
                 add  r0, r5              # r5 = address at 101c
                 ld   $0x200, r0          # r0 = address of 0x200
                 ld   0x0(r0), r0         # r0 = value at 0x200
                 st   r0, 0x0(r5)         # store value at 0x101c = value at 0x200
                 ld   $0x204, r0          # r0 = address of .pos 0x204
                 ld   0x0(r0), r0         # r0 = value of .pos 0x204
                 st   r0, 0x4(r5)         # store value at 0x1020 = value of .pos 0x204
                 ld   $0x208, r0          # r0 = address at 0x208
                 ld   0x0(r0), r0         # r0 = value at 0x208
                 st   r0, 0x8(r5)         # store value at 0x208 into 0x1024
                 gpc  $6, r6              # r6 = address at "ld $0x20c, r1"    
                 j    0x300               # jump to 0x300  
                 ld   $0x20c, r1          # r1 = address at 0x20c
                 st   r0, 0x0(r1)         # store r0 into value of 0x20c
                 halt                     
.pos 0x200
                 .long 0x00000012         # i: 0x200 must be in between (10, 18) 
                 .long 0x00000005         # j: 0x204
                 .long 0x00000005         # k: 0x208
                 .long 0x00000005         # l: 0x20c
.pos 0x300
                 ld   0x0(r5), r0         # r0 = value at 0x101c = value of 0x200
                 ld   0x4(r5), r1         # r1 = value at 0x1020 = value of 0x204
                 ld   0x8(r5), r2         # r2 = value at 0x1024 = value of 0x208
                 ld   $0xfffffff6, r3     # r3 = -10
                 add  r3, r0              # r0 = r0 -10
                 mov  r0, r3              # r3 = r0 
                 not  r3                  # negative of this
                 inc  r3                  # increment r3 = (r3 = 10-value of 0x200)
                 bgt  r3, L6              # If value of 0x200 < 10, GO TO  L6
                 mov  r0, r3              # r3 = r0
                 ld   $0xfffffff8, r4     # r4 = -8
                 add  r4, r3              # r3 = value of 0x200 - 10 - 8 = (value of 0x200 - 18)
                 bgt  r3, L6              # if value of of 0x200 > 18, GO TO L6 
                 ld   $0x400, r3          # r3 = 0x400 = jumptable
                 j    *(r3, r0, 4)        # GO TO jumptable[r0-10] = jmptable[i]  
.pos 0x330
                 add  r1, r2              # r2 = r1 + r2 = value of 0x204 + value of 0x208              0x330
                 br   L7                  # branch to L7                                                
                 not  r2                  #                                                             0x334
                 inc  r2                  # r2 = -r2                                                    
                 add  r1, r2              # r2 = r1-r2                                                  
                 br   L7                  # GOTO L7                                                     
                 not  r2                  #                                                             0x33c
                 inc  r2                  # r2 = -(r1-r2) = r2-r1                                       
                 add  r1, r2              # r2 = r2-r1+r1                                               
                 bgt  r2, L0              # if r2 >0, GOTO l0                                           
                 ld   $0x0, r2            # r2 = 0                                                      
                 br   L1                  # GOTO L1                                                     
L0:              ld   $0x1, r2            # r2 = 1                                                      
L1:              br   L7                  # GOTO L7                                                     
                 not  r1                  #                                                             0x354                                                  
                 inc  r1                  # r1 = -r1                                                    
                 add  r2, r1              # r1 = r2+r1 = (r2-r1)                                        
                 bgt  r1, L2              # if r2>r1, GOTO L2                                           
                 ld   $0x0, r2            # r2 = 0                                                      
                 br   L3                  # GOTO L3                                                     
L2:              ld   $0x1, r2            # r2 = 1                                                      
L3:              br   L7                  # GOTO L7                                                    
                 not  r2                  #                                                             0x36c
                 inc  r2                  # r2 = -r2                                                    
                 add  r1, r2              # r2 = r1+r2 = (r1-r2)                                        
                 beq  r2, L4              # if(r1==r2), GOTO L4                                            
                 ld   $0x0, r2            # r2 = 0
                 br   L5                  # GOTO L5
L4:              ld   $0x1, r2            # r2 = 1
L5:              br   L7                  # GOTO L7                                                     0x384
L6:              ld   $0x0, r2            # r2 = 0 
                 br   L7                  # GO TO L7  
L7:              mov  r2, r0              # r0 = r2 
                 j    0x0(r6)             # jump to line 16
.pos 0x400
                 .long 0x00000330         #if i=10
                 .long 0x00000384         #if i=11
                 .long 0x00000334         #if i=12
                 .long 0x00000384         #if i=13
                 .long 0x0000033c         #if i=14
                 .long 0x00000384         #if i=15
                 .long 0x00000354         #if i=16
                 .long 0x00000384         #if i=17
                 .long 0x0000036c         #if i=18
.pos 0x1000
                 .long 0x00000000         # 0x1000
                 .long 0x00000000         # 0x1004
                 .long 0x00000000         # 0x1008
                 .long 0x00000000         # 0x100c  
                 .long 0x00000000         # 0x1010  
                 .long 0x00000000         # 0x1014
                 .long 0x00000000         # 0x1018
                 .long 0x00000000         # 0x102c
                 .long 0x00000000         # 0x1020
                 .long 0x00000000         # 0x1024
