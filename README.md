# cs61c

ucb cs61c

Unconditional Control Instructions:
  
    jal: Unconditional jump and link
    ex: jal x3 ,label
    jump target specified as label
    label is encoded as an offset from current instruction
    link the return address

    jalr: Unconditional jump via register and link
    ex: jalr x3,4(x1)
    Jump targt specified as register value plus constant offset
    can jump to any 32 bit address - supports long jumps

Pseudoinstruction:

    mv x2, x1
    li x2, 3
    ble x1, x2, label
    beqz x1, label
    bnez x1, label
    j label
Equivalent Assembly Instruction:

    addi x2, x1, 0
    addi x2, x0, 3
    bge x2, x1, label
    beq x1, x0, label
    bne x1, x0, label
    jal x0, label

In risc-v, small constants(12-bit) can be handled via register Immediate ALR operations.(addi x1, x2,3)

Largest 12 bit 2's complement constant is 2^11-1 = 2047(0x7FF)
so use li pseudoinstruction to set register to large constant  
ex: li x4,0x123456
(equals lui x4,0x123  
addi x4,x4,0x456)  
can also use li pseudoinstruction for small constants

if statement can be compiled using branches:  
  
    C code               RISC-V Assembly
    if(expr) {           (compile expr into xN)
      if-body            beqz xN, endif
    }                     (compile if-body)
                        endif:

ex:  
  
    int x,y;
    if(x<y){
        y = y - x;
    }
    as //x: x10,y:x11

    slt x12,x10,x11
    beqz x12 ,endif
    sub x11, x11 ,x10
    endif:

    combine expr and the branch

    bge x10,x11,endif
    sub x11,x11,x10
    endif:

Loops can be compiled using backward branches:  

    C
    while(expr){
        while-body
    }

    RISC-V
    while:
      (compile expr into xN)
      beqz xN,endwhile
      (compile while-body)
      j while
    endwhile:

    With one branch or jump per iteration
    j compare
    loop:
        (compile while-body)
    compare:
        (compile expr into xN)
        benz xN, loop

    ex:
    while(x!=y){
        if(x>y){
            x = x-y;
        }else {
            y = y-x;
        }
    }

    //x: x10 ,y: x11
    j compare
    loop:
        ble x10,x11,else
        sub x10,x10,x11
        j endif
    else:
        sub x11,x11,x10
    endif:
    compare:
        bne x10,x11,loop

proc_call:jal ra,label  
    1.stores address of proc_call + 4 in register ra(return address register)  
 2.Jumps to instruction at address label where label is the name of the procedure  
3.After excuting procedure,jr ra to return to caller and continue execution

pesudo return from subroutine

Each procedure call has its own instance of all this data known as the procedure's activation record.

RISC-V calling convention gives symbolic names to registers x0-x31  

    a0 to a7   function arguments caller
    a0 and a1 function return values caller
    ra x1 return address caller
    t0 to t6 temporaries caller
    s0 to s11 saved registers callee 
    sp x2 stack pointer callee
    gp x3 global pointer
    tp x4 thread pointer
    zero x0 hardwired zero
