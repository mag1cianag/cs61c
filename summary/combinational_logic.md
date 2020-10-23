# Combinational Logic

Digital electronics operate with only two voltage : a high voltage and a low voltage.

**asserted signal** :A signal that is (logically) true,or 1.

**deasserted signal** :A signal that is (logically) false,or 0.

Blocks without memory are called *combinational* and the output of a combinational block depends only on the current input.

Blocks with memory,the outputs can depend on both the inputs and the value stored in memory.

## Boolean Algebra

* **Identity law** : $$A+0=A$$ and $$A\cdot1=A $$
* **Zero and One laws** :$$A+1=1$$ and $$A\cdot0=0$$
* **Inverse laws** : $$A+\overline{A}=1$$ and $$A\cdot\overline{A}=0$$
* **Commutative laws** : $$A+B=B+A$$ and $$A\cdot B=B\cdot A$$
* **Associative laws** :$$A+(B+C)=(A+B)+C$$ and $$A\cdot(B\cdot C)=(A\cdot B)\cdot C$$
* **Distributive laws** : $$A\cdot(B+C)=(A\cdot B)+(A\cdot C)$$ and $$A+(B\cdot C) = (A+B)\cdot(A+C)$$

All logic funcitions can be constructed with only a single gate type,if that gate is inverting.The two common inverting gates are called NOR and NAND .

**decoder**: A logic block that has an *n*-bit input and $$2^{n}$$ outputs,where only one output is asserted for each input combination.

We can represent the logic function computed by a two-input multiplexor,as $$C = (A\cdot S)+(B\cdot S)$$ 

Any logic function can be written in a canonical from,where every input is either a  true or complemented varivable and there are only two levels of gates-one being AND and the other OR-with a possible inversion on the final output.

**sum of products**: A form of logical representation that employs a logical sum(OR) of products (terms joined using the AND operator)

Each truth table entry for which the function is true corresponds to a product term.The product term consists of a logical product of all the inputs or the complements of the inputs,depending on whether the entry in the truth table has a 0 or 1 cooresponding to this variable.

**bus**: In logic design,a collection of data lines that is treated together as a single logical signal;also,a shared collection of lines with multiple sources and uses.