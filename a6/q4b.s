.pos 0x100
start:
    ld $sb, r5                      #r5 = address of stack
    inca    r5                      #r5 = address after stack
    gpc $6, r6                      #r6 = return address for halt
    j main                          #jump to main
    halt

f:  
    deca r5                         #add more space to stack
    ld $0, r0                       #r0 = 0
    ld 4(r5), r1                    #r1 = second element from top of stack
    ld $0x80000000, r2              #r2 = number
f_loop:
    beq r1, f_end                   #if r1 = 0, go to f_end
    mov r1, r3                      #r3 = r1
    and r2, r3                      #r2 && r3
    beq r3, f_if1                   #if r3 == 0, go to f_if1
    inc r0                          #r0++
f_if1:
    shl $1, r1                      #r1 << 1 = r1/2
    br f_loop                       #go to f_loop
f_end:
    inca r5                         #delete one element from top of stack
    j(r6)                           #jump back to main_loop

main:
    deca r5                         #r5 = allocate space on stack 1
    deca r5                         #r5 = allocate space on stack 2
    st r6, 4(r5)                    #store return address into bottom of stack
    ld $8, r4                       #r4 = 8 (int i = 8)
main_loop:
    beq r4, main_end                #if r4 = 0, goto main_end
    dec r4                          #r4-- (i--)
    ld $x, r0                       #r0 = address of x
    ld (r0,r4,4), r0                #r0 = x[r4] (x[i])
    deca r5                         #add more space 1 more space to stack (2+i) 
    st r0, (r5)                     #store x[i] into top of stack
    gpc $6, r6                      #get address of next next line
    j f                             #jump to f
    inca r5                         #delete 1 elemnt from stack
    ld $y, r1                       #r1 = address of y
    st r0, (r1,r4,4)                #r0 = y[r4] = y[i]
    br main_loop                    #go to main_loop
main_end:
    ld 4(r5), r6                    #r6 = second from top element on stack = return address for halt
    inca r5                         #delete 1 element from stack
    inca r5                         #delete 1 element from stack
    j (r6)                          #jump to halt

.pos 0x2000
x:
    .long 1
    .long 2
    .long 3
    .long 0xffffffff
    .long 0xfffffffe
    .long 0
    .long 184
    .long 340057058

y:
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0

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

