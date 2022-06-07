
# Instructions
An *instruction* is an intermediate representation, of type SSA, for signals.

## Definition
$$
\begin{aligned}
	I\in\FI ::=&  \hspace{0.25cm}\instr{T}{d}{M}\\ 
	||& \hspace{0.25cm}\instr{T}{v[M_1,M_2]}{M_3}\\ 
	||& \hspace{0.25cm}\instr{T}{t}{t+1} 
	\end{aligned}
$$

## Where

- $T$ is a time reference indicates when this instruction must be executed  ;
- $d$ and $v$ are memory references ;
- $M$ is a signal in memory that is computed ; 
- $t$ is a memory reference for the current value of the time reference.

# Time reference

A _time reference_ is a non empty list of clock signals that indicates when an instruction should be executed.

## Definition
$$ 
\begin{aligned}
T\in\FT ::= 1 ||  S.T
\end{aligned} 
$$

## Where

- $S\in\MS$ is a clock signal $S:\Z\rightarrow \{0,1\}$
- $1$ is the top level clock signal (execution every sample)

# Memory Destinations

A _memory destination_ indicates where the writing of the result should take place. This can be an output buffer, a scalar variable, or a vector in the case of delay lines for example.

## Definition
$$
	D\in\DS ::= \aout{n} || t || m || v[M,M]
$$

where $\aout{n}$ represents the audio buffer of the nth output channel, `t`, `m` and `v` are identifiers allocated at compile time.

