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

### R type instrucions

* R type instructions compose:
  * opcode (7 bits)
  * funct3 (3 bits)
  * funct7 (7 bits)
  * rd (5 bits)
  * rs1 (5 bits)
  * rs2 (5 bits)