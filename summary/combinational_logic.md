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

