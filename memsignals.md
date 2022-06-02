# Memory Signals
Memory signals are simplified signals using memory references to implement delay lines, recursions, and sharing of common subexpressions.

## Definition

$$ 
M \in\FS ::= k 
	||  u 
	||  \ain{c} 
	|| \star(S_1,S_2,...)
	|| t || m || v[M1,M2]
$$

## Where

- $k$ is a number (integer or real)
- $u$ is a user interface element (slider, button, etc.)
- $\ain{c}$ is the input channel $c$
- $\star(S_1,S_2,...)$ is a numerical operation on signals
- $t$: is a scalar memory reference corresponding to the current time
- $m$: is a scalar memory reference corresponding to a signal
- $v[M_1,M_2]$ is a vector memory reference where $M_1$ is the time and $M_2$ the delay.

