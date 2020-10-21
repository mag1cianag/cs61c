# Pipelining Overview

pipelining is an implementation technique in which multiple instructions are overlapped in execution.

as long as we have separate resources for each stage ,we can pipeline the tasks.

pipelining improves the throughput of the system.

pipelining would not decrease the time to complete one load of task,but when we have many tasks,the improvement in throughput decreases the total time to complete the work.

**RISC-V instructions classically take five steps :**

1. Fetch instruction from memory.
2. Read registers and decode the instruction.
3. Execute the operation or calculate an address.
4. Access an operand in data memory(if necessary).
5. Write the result into a register(if necessary).

RISC-V pipeline can have five stages.

In the single-cycle model,every instruction takes exactly one clock cycle,so the clock cycle must be stretched to accommodate the slowest instruction.

All the pipeline stages take a single clock cycle,so the clock cycle must be long enough to accommodate the slowest operation.

*assuming ideal conditions*
$$
Time\ between\ instructions_{pipelined} = \frac{Time\ between\ instructions_{nonpipelined}}{Number\ of\ pipe\ stages}
$$

#### Pipeline Hazards

there are situations in pipelining when the next instruction cannot execute in the following clock cycle.

**Structural Hazard**

the hardware cannot support the combination of instructions that we want to execute in the same clock cycle.

**Data Hazards**

it occur when the pipeline must be stalled because one step must wait for another to complete.In a computer pipeline,data hazards arise from the dependence of one instruction on an earlier one that is still in the pipeline.

The primary solution is adding extra hardware to retrieve the missing item early from the inernal resources which is  called forwarding or bypassing.

**forwarding ,bypassing**

a method of resolving a data hazard by retrieving the missing data element from internal buffers rather than waiting for it to arrive from programmer visible registers or memory.

##### load-use data hazard

a specific form of data hazard in which the data being loaded by a load instruction have not yet become available when they ar needed by another instruction.

using either hardware detection and stalls or software that reorders code to try to avoid load-use pipeline stalls.

pipeline stall(bubble)

**Control Hazards**

it arise from the need to make a decision based on the results of one instruction while others are executing.When the proper instruction cannot execute in the proper pipeline clock cycle because the instruction that was fetched is not the one that is needed;that is,the flow of instruction address is not what the pipeline expected.

Stall immediately after we fetch a branch,waiting until the pipeline determines the outcome of the branch and knows what instruction address to fetch from.

**branch prediction**

A method of resolving a branch hazard that assumes a given outcome for the conditional branch and proceeds from that assumption rather than waiting to ascertain the actual outcome.

## Pipelined Datapath and Control

the instruction memory is used during only one of the five stages of an instruction,allowing it to be shared by following instructions during the other four stages. To retain the value of an individual instruciton for its other four stages,the value read from instruction memory must be saved in a register.Simrlarly,we must place registers wherever there are dividing lines between stages.