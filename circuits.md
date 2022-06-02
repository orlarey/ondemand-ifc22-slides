

<!------------------------------------------------------------------------------------------------------>
# Faust Circuits as Formal Expressions

*Faust circuits* (evaluated Faust programs) are defined recursively by the following grammar:

## Circuits Definition
$$ 
\begin{aligned}
C \in\FC ::=& k ||  u ||  \star||  @ ||  \ ! ||  \_  \\
& || C_1:C_2 || C_1,C_2 \\ 
& || C_1<:C_2 ||C_1:>C_2 \\
& || C_1\sim C_2 || \od{C}
\end{aligned} 
$$

## Primitives

- $k$ numbers (integer or real);
- $u$ user interface elements (sliders, buttons, etc.);
- $\star$ any numerical operation;
- $@$ the delay operation;
- $\_$ underscore, the identity circuit (a _perfect_ cable);
- $\ !$ cut, the termination circuit.

<!------------------------------------------------------------------------------------------------------>
# Faust Circuits as Formal Expressions

## Circuits Composition

- $C_1<:C_2$ _split composition_, the outputs of $C_1$ are distributed over the inputs of $C_2$ ;
- $C_1:>C_2$ _merge composition_, the outputs of $C_1$ are summed to form the inputs of $C_2$ ;
- $C_1:C_2$ _sequential composition_, the outputs of $C_1$ are propagated to the inputs of $C_2$ ;
- $C_1,C_2$ _parallel composition_, the inputs are those of $C_1$ and $C_2$ and so are the outputs;
- $C_1\sim C_2$ _recursive composition_, the outputs of $C_1$ are fed back to the inputs of $C_2$ and vice versa;
- $\od{C}$ _ondemand_ version of $C$.

<!------------------------------------------------------------------------------------------------------>
# Well Formed Circuits

## Number of Inputs and Outputs

$$
\begin{aligned}
\inference[(seq)]{\io{C_1}:m\rightarrow n\ \;\; \io{C_2}:n\rightarrow p}{\io{C_1:C_2}:m \rightarrow p} \\
\inference[(par)]{\io{C_1}:m\rightarrow n\ \;\; \io{C_2}:p\rightarrow q}{\io{C_1,C_2}:m+p \rightarrow n+q} \\
\inference[(split)]{\io{C_1}:m\rightarrow n\ \;\; \io{C_2}:n.k\rightarrow p}{\io{C_1<:C_2}:m \rightarrow p} \\
\inference[(merge)]{\io{C_1}:m\rightarrow k.n\ \;\; \io{C_2}:n\rightarrow p}{\io{C_1:>C_2}:m \rightarrow p} \\
\inference[(rec)]{\io{C_1}:r+n\rightarrow q+m\ \;\; \io{C_2}:q\rightarrow r}{\io{C_1\sim C_2}:n \rightarrow q+m} \\
\inference[(od)]{\io{C}:m\rightarrow n}{\io{\od{C}}:m+1 \rightarrow n} 
\end{aligned}
$$ 


<!------------------------------------------------------------------------------------------------------>
# Semantics of Well Formed Circuits

## Signal Processor Semantics

An audio circuit $C\in\FC$ denotes to a signal processor $\semc{C}\in\SP=\FS^n->\FS^m$ that takes input signals and produces output signals.

## Notation

- $(S_1,...,S_n)$ a tuple of signals, 
- $()$ the empty tuple and 
- $(S_1,...,S_n,**k)$ an $n*k$ tuple $(S_1,...,S_n,S_1,...,S_n,...)$ obtained by concatenating $k$ times the tuple $(S_1,...,S_n)$.


<!------------------------------------------------------------------------------------------------------>
# Primitives Semantics (1)

## Constant
A number $k$ denotes an elementary circuit with no input, that produces a constant signal $k$.
$$
\inference[(num)]{}{\semc{k}()=(k)} 
$$ 

## Control

A user interface element $u$ denotes an elementary circuit with no input and one output, the signal $u$ produced by the user interface element.
$$
\inference[(ctrl)]{}{\semc{u}()=(u)} 
$$ 


<!------------------------------------------------------------------------------------------------------>
# Primitives Semantics (2)

## Numeric operation
The $\star$ symbol denotes a *generic* numerical operation on signals. It represents a circuit with $n$ inputs (typically 1 or 2 depending on the nature of the operation) and one output. 
$$
\inference[(nop)]{}{\semc{\star}(S_1,S_2,...)=(\star(S_1,S_2,...))} 
$$ 

## Delay
A delay primitive $@$ denotes a circuit with two inputs and one output.

$$
\inference[(delay)]{}{\semc{@}(S_1,S_2)=(S_1@S_2)} 
$$ 

<!------------------------------------------------------------------------------------------------------>
# Primitives Semantics (3)

## Cable
The cable has one input and one output.
$$
\inference[(cable)]{}{\semc{\_}(S)=(S)} 
$$ 

## Cut
The cut has one input and no output.
$$
\inference[(cut)]{}{\semc{!}(S)=()} 
$$ 

<!------------------------------------------------------------------------------------------------------>
# Circuit Compositions Semantics (1)

## Sequential Composition Semantics

$$
\inference[(seq)]{
	\semc{C_1}(S_1,...,S_n) = (Y_1,...,Y_m)\\
	\semc{C_2}(Y_1,...,Y_m) = (Z_1,...,Z_p)
}{
	\semc{C_1:C_2}(S_1,...,S_n) = (Z_1,...,Z_p)
} 
$$ 


## Parallel Composition Semantics

$$
\inference[(par)]{
	\semc{C_1}(S_1,...,S_n) = (U_1,...,U_m)\\
	\semc{C_2}(Y_1,...,Y_p) = (V_1,...,V_q)
}{
	\semc{C_1,C_2}(S_1,...,S_n,Y_1,...,Y_p) = (U_1,...,U_m,V_1,...,V_q)
} 
$$ 

<!------------------------------------------------------------------------------------------------------>
# Circuit Compositions Semantics (2)

## Split Composition Semantics

$$
\inference[(split)]{
	\semc{C_1}(S_1,...,S_n) = (Y_1,...,Y_m)\\
	\semc{C_2}(Y_1,...,Y_m,**k) = (Z_1,...,Z_p)
}{
	\semc{C_1<:C_2}(S_1,...,S_n) = (Z_1,...,Z_p)
} 
$$ 


## Merge Composition Semantics

$$
\inference[(merge)]{
	\semc{C_1}(S_1,...,S_n) = (Y_{1,1},...,Y_{1,m},...,Y_{k,1,},...,Y_{k,m})\\
	\semc{C_2}(Y_{1,1}+...+Y_{k,1},...,Y_{1,m}+...+Y_{k,m}) = (Z_1,...,Z_p)
}{
	\semc{C_1:>C_2}(S_1,...,S_n) = (Z_1,...,Z_p)
} 
$$ 


<!------------------------------------------------------------------------------------------------------>
# Circuit Compositions Semantics (3)

## Recursive Composition Semantics

$$
\inference[(rec)]{
	W = \mathrm{fresh\ recursive\ symbol} \\
	\semc{C_2}(W_1@1,...,W_q@1) = (Z_1,...,Z_r) \\
	\semc{C_1}(Z_1,...,Z_r,S_1,...,S_n) = (Y_1,...,Y_q,Y_{q+1},...,Y_{q+m})
}{
	\semc{C_1\sim C_2}(S_1,...,S_n) = (Y_1,...,Y_q,Y_{q+1},...,Y_{q+m})
} 
$$ 
with $\rdef{W}=(Y_1,...,Y_q)$.


<!------------------------------------------------------------------------------------------------------>
# Ondemand Semantics

## Ondemand

$$
\inference[(od)]{
	\semc{C}(S_1<*H,...,S_n<*H) = (Y_1,...,Y_m)\\
}{
	\semc{\od{C}}(H,S_1,...,S_n) = (Y_1*>H,...,Y_m*>H)
} 
$$ 
