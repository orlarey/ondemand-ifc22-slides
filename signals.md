# Faust Signals as Formal Expressions

Faust signals are defined by the following grammar:
$$ 
S \in\FS ::= k ||  u ||   \ain{c} ||   X_i ||   \star(S_1,S_2,...) || S_1@S_2 ||   S_1<*S_2 ||   S_1*>S_2
$$

- $k$ is a number (integer or real)
- $u$ is a user interface element (slider, button, etc.)
- $\ain{c}$ is the input channel $c$
- $\star(S_1,S_2,...)$ is a numerical operation on signals
- $X_i$: is the i-th signal of a group of mutually recursive signals associated to symbol $X$
- $S_1@S_2$ is $S_1$ delayed by $S_2$
- $S_1\downarrow S_2$ is $S_1$ downsampled by $S_2$
- $S_1\uparrow S_2$  is $S_1$ up-sampled by $S_2$.


# The semantics of Faust Signals as a function of time

A Faust signal $S\in\FS$ denotes a function of time, notated $\sems{S}:\Z->\R$. The value of this function at time $t$ is notated $\sems{S}(t)$. 

By definition in Faust, the value of any signal before time $0$ is always $0$. Therefore we have:
$$\forall S\in\FS, \forall t<0, \sems{S}(t)=0$$ 


# The semantics of Faust Signals as a function of time

For $t\ge0$ we have:

- $\sems{k}(t)=k$
- $\sems{u}(t)=$ value of the user interface controller $u$ at time $t$
- $\sems{\ain{c}}(t)=$ value of the audio input channel $c$ at time $t$
- $\sems{X_i}(t)=\sems{S_i}(t)$ with definitions $\rdef{X} = (S_1,..,S_i,..,S_n)$
- $\sems{\star(S_1,S_2,...)}(t)=\star(\sems{S_1}(t),\sems{S_2}(t),...)$
- $\sems{S_1@S_2}(t)= \sems{S_1}(t-\sems{S_2}(t))$
- $\sems{S_1<*S_2}(t)= \sems{S_1}(\down{S_2}(t))$
- $\sems{S_1*>S_2}(t)= \sems{S_1}(\up{S_2}(t))$


# Signal Downsampling

$S_1<*S_2$ is the downsampling of $S_1$, based on the clock signal $S_2$. 

\begin{table}[!ht]
\centering
\begin{tabular}{cccc}
\hline
$S_1$ & $S_2$ & $S_1<*S_2$  & $\down{S_2}$\\ \hline
a     & 1     & a        & 0 \\
b     & 0     &          &   \\
c     & 0     &          &   \\
d     & 1     & d        & 3 \\
f     & 1     & f        & 4 \\
g     & 0     &          &   \\ \hline
\end{tabular}
\caption{Example of downsampling}
\label{tab:downsampling}
\end{table}

$$
\inference[(down)]{
\down{S_2} = \{n\in\N <> \sems{S_2}(n)=1\}
}{
\sems{S_1<*S_2}(t) = \sems{S_1}(\down{S_2}(t)
}
$$


# Signal Upsampling

$S_1*>S_2$ is the upsampling of $S_1$ according to clock signal $S_2$. 

\begin{table}[!ht]
\centering 
\begin{tabular}{ccc}
\hline
$S_1$ & $S_2$ & $S_1*>S_2$ \\ \hline
a     & 1     & a          \\
d     & 0     & a          \\
f     & 0     & a          \\
      & 1     & d          \\
      & 1     & f          \\
      & 0     & f          \\ \hline
\end{tabular}
\caption{Example of upsampling}
\label{tab:upsampling}
\end{table}

$$
\inference[(up)]{
\up{S_2}(t) = \sum_{i=0}^t \sems{S_2}(i) - 1
}{
\sems{S_1*>S_2}(t) = \sems{S_1}(\up{S_2}(t))
}
$$

