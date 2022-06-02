## Faust Circuits as formal expressions

$$ 
\begin{aligned}
C \in\FC ::=& k ||  u ||  \star||  @ ||  \ ! ||  \_  \\
& || C_1:C_2 || C_1,C_2 \\ 
& || C_1<:C_2 ||C_1:>C_2 \\
& || C_1\sim C_2 || \od{C}
\end{aligned} 
$$

- $k$ numbers (integer or real);
- $u$ user interface elements (sliders, buttons, etc.);
- $\star$ any numerical operation;
- $@$ the delay operation;
- $\_$ underscore, the identity circuit (a _perfect_ cable);
- $\ !$ cut, the termination circuit.

## Faust Circuits as formal expressions

- $C_1<:C_2$ _split composition_, the outputs of $C_1$ are distributed over the inputs of $C_2$ ;
- $C_1:>C_2$ _merge composition_, the outputs of $C_1$ are summed to form the inputs of $C_2$ ;
- $C_1:C_2$ _sequential composition_, the outputs of $C_1$ are propagated to the inputs of $C_2$ ;
- $C_1,C_2$ _parallel composition_, the inputs are those of $C_1$ and $C_2$ and so are the outputs;
- $C_1\sim C_2$ _recursive composition_, the outputs of $C_1$ are fed back to the inputs of $C_2$ and vice versa;
- $\od{C}$ _ondemand_ version of $C$.

## Well formed circuits

$$
\inference[(seq)]{\io{C_1}:m\rightarrow n\ \;\; \io{C_2}:n\rightarrow p}{\io{C_1:C_2}:m \rightarrow p} 
\inference[(par)]{\io{C_1}:m\rightarrow n\ \;\; \io{C_2}:p\rightarrow q}{\io{C_1,C_2}:m+p \rightarrow n+q} 
\inference[(split)]{\io{C_1}:m\rightarrow n\ \;\; \io{C_2}:n.k\rightarrow p}{\io{C_1<:C_2}:m \rightarrow p} 
\inference[(merge)]{\io{C_1}:m\rightarrow k.n\ \;\; \io{C_2}:n\rightarrow p}{\io{C_1:>C_2}:m \rightarrow p} 
\inference[(rec)]{\io{C_1}:r+n\rightarrow q+m\ \;\; \io{C_2}:q\rightarrow r}{\io{C_1\sim C_2}:n \rightarrow q+m} 
\inference[(od)]{\io{C}:m\rightarrow n}{\io{\od{C}}:m+1 \rightarrow n} 
$$ 
