# Exceptions

Events other than branches that change the normal flow of instruction execution.they were initially created to handle unexpected events from within the processor,like an undefined instruction.

term ***exception*** to refer to any unexpected change in control flow without distinguishing whether the cause is internal or external

term ***interrupt*** only when the event is externally caused

the basic action that the processor must perform when an exception occurs is to save the address of the unfortunate instruction in the *supervior exception cause register* and then transfer control to the operating system at some specified address

for reason,there is a register (called the *Supervisor Exception Cause Register*),which holds a field that indicates the reason for exception.

**vectored interrupt** : an interrupt for which the address to which control is transferred is determined by the cause of the exception.

the handware and the operating system must ork in conjunction .the handware contract is to stop the offending instruction in midstream,let all prior instrucitons complete,flush all follwing instructions,set a register to show the cause of the exception,save the address of the offending instruction,and then branch to prearranged address.the operating system contract is to look at the cause of the exception and act apporpriately.