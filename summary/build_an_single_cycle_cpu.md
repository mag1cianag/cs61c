# CPU Implemention

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

**register file** : A state element that consists of a set of registers that can be read and written by supplying a register number to be accessed.

### R type instrucions

R-format instructions have three register operands ,so we wiill need to read two data words from the register file and write one data word into the register file for each instruction.

We need a total of three inputs(two for register numbers and one for data) and two outputs (both for data).

* R type instructions compose:
  * opcode (7 bits)
  * funct3 (3 bits)
  * funct7 (7 bits)
  * rd (5 bits)
  * rs1 (5 bits)
  * rs2 (5 bits)

**branch target address** : The address specified in a branch,which becomes the new program counter(PC) if the branch is taken.In the RISC-V architecture,the branch target is given by the sum of the offset field of the instruction and the address of the branch.

The data memory must be written on store instructions;hence, data memory has read and write control signals,an address input,and an input for the data to be written into memory.

two details in the definition of branch instructions:

* the instruction set architecture specifies that the base for the branch address calculation is the address of the branch instruction.
* the architecture also states that the offset field is shifted left 1 bit so that it is a half word offset;this shift increases the effective range of the offset field by a factor of 2.

