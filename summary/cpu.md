# CPU implemention

## The von Neumann Model

Almost all modern computers are based on the von Neumann model.

* Main memory holds programs and their data.
* Central processing unit(cpu) accesses and processes memory values.
* Input/Output devices to communicate with the outside world.

## Key Idea:Stored-Program Computer

Express program as a sequence of coded instructions.  
Memory holds both data and instructions.  
CPU fetches,interprets,and execute successive instructions of the program.  

## Central Processing Unit(CPU)

* Datapath:

    contains the hardware necessary to perform operations required by the processor.  

* Control:

    decides what each piece of the datapath should do.

## Instructions

Instructions are the fundamental unit of work.  
Each instruction specifies an operation or opcode to be performed and source operands and destination for the result.  

CPU logically implements : Fetch -> Decode -> Read src ->Execute ->Write dst -> compute next PC and go back for next loop.  

For every instruction,the first two steps are identical:

1. Sent the *program counter* to the memory that contains the code and fetch the instruction from that memory.
2. Read one or two registers, using fields of the instruction to select the registers to read.

All instruction classes use the arithmetic-logic unit after reading the registers.The memory-reference instructions use the ALU for an address calculation,the arithmetic-logical instructions for the operation execution, and condition branches for the equality test.

### R type instrucions

* R type instructions compose:
  * opcode (7 bits)
  * funct3 (3 bits)
  * funct7 (7 bits)
  * rd (5 bits)
  * rs1 (5 bits)
  * rs2 (5 bits)