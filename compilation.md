<!------------------------------------------------------------------------------------------------------------>
# Identifiers and Marking

## Fresh identifier representing memory locations

- $\SID{S.T}=m$ unique scalar identifier for $S$ in time context $T$ ;
- $\VID{S.T}=v$ unique vector identifier for $S$ in time context $T$ ;
- $\TID{T}=t$ unique scalar identifier representing the current time in time context $T$.
  
## Marking recursive definitions

- $\vmark{Xi.T}=\emptyset$: not yet marked ; 
- $\vmark{Xi.T}<-v$: mark it with identifier $v$ ;
- $\vmark{Xi.T}= v$: already marked with $v$.


<!------------------------------------------------------------------------------------------------------------>
# Signal Compilation

Function $\cs{.}:\FS\times\FT->\MS\times\IS$

### Number

$$
\inference[(num)]{
}{
    \cs{k.T} = k \times \emptyset
}
$$ 

### User interface

$$
\inference[(ctrl)]{
}{
    \cs{u.T} = u \times \emptyset
}
$$ 

### Inputs

$$
\inference[(input)]{
}{
    \cs{\ain{c}.T} = \ain{c} \times \emptyset
}
$$ 

<!------------------------------------------------------------------------------------------------------------>
# Signal Compilation
### Numerical Operation
$$
\inference[(nop)]{
    \cs{S_1.T}=M_1\times J_1 \\
    \cs{S_2.T}=M_1\times J_2 \\
    \vdots \\
    \VID{\star(M_1,M_2,...)} = m
}{
    \cs{\star(S_1,S_2,...).T}= m\times\{\instr{T}{m}{\star(M_1,M_2,...)} \}\bigcup_i J_i
}
$$ 

<!------------------------------------------------------------------------------------------------------------>
# Signal Compilation
### Downsampling

The downsampling $S_1<*S_2$  appears at the entrance of an ondemand. This means that compiling $S_1<*S_2$ into the $M_2.T$ time environment (where $M_2$ is the compiled version of $S_2$) is like compiling $S_1$ into the $T$ time environment and using a variable to do the downsampling.  

$$
\inference[(down)]{
    \cs{S_1.T}=M_1\times J_1 \\
    \cs{S_2.T}=M_2\times J_2 \\
    \SID{M_1.T} = m\\
    J_3 = \{\instr{T}{m}{M_1}\}
}{
    \cs{(S_1<*S_2).M_2.T}= m\times J_3\cup J_1\cup J_2
}
$$ 

# Signal Compilation
### Upsampling

The $S_1*>S_2$ upsampling appears at the output of an ondemand. It is necessary to compile $S_1$ into the clock time reference $S_2$ (which is added to the current time reference). The signal $S_1$ must also be stored in a variable to do the upsampling.

$$
\inference[(up)]{
    \cs{S_2.T}=M_2\times J_2 \\
    \cs{S_1.M_2.T}=M_1\times J_1 \\
    \SID{M_1.M_2.T} = m\\
    J_3 = \{\instr{M_2.T}{m}{M_1}\}
}{
    \cs{(S_1*>S_2).T}= m \times J_1 \cup J_1 \cup J_2
}
$$ 

# Signal Compilation
### Delay

$$
\inference[(up)]{
    \cs{S_1.T}=M_1\times J_1 \\
    \cs{S_2.T}=M_2\times J_2 \\
    \VID{M_1.T} = v\\
    \TID{T} = t\\
    J_3 = \{\instr{T}{v[t,0]}{M_1}\} \cup \{\instr{T}{t}{t+1}\}
}{
    \cs{(S_1@S_2).T}= v[t,M_2]\times J_3 \cup J_1 \cup J_2
}
$$ 

<!------------------------------------------------------------------------------------------------------------>
# Signal Compilation: recursion

#### First visit
If it is the first visit, we have $\vmark{X_i.T}=0$:
$$
\inference[(r1)]{
    \VID{X_i.T} = v\\
    \vmark{X_i.T}<-v\\
    \rdef{X}=(...,S_i,...) \\
    \cs{S_i.T}=M_i\times J_i \\
    \cs{S_d.T}=M_d\times J_d \\
    \TID{T} = t \\
    J_3 = \{\instr{T}{v[t,0]}{M_i}\} \cup \{\instr{T}{t}{t+1}\}
}{
    \cs{(X_i@S_d).T}= v[t,M_d]\times J_3 \cup J_i \cup J_d
}
$$ 

<!------------------------------------------------------------------------------------------------------------>
# Signal Compilation: recursion

#### Next visits
If it is not the first visit, we have $\vmark{X_i.T}=v$:
$$
\inference[(r2)]{
    \cs{S_d.T}=M_d\times J_d \\
    \TID{T} = t \\
}{
    \cs{(X_i@S_d).T}= v[t,M_d]\times J_d
}
$$ 


<!------------------------------------------------------------------------------------------------------------>
# Global compilation

$\cc{.}:\FS^n->\IS$

## Global compilation
$$
\inference[(comp)]{
    \vdots\\
    \cs{S_i.1} = M_i\times J_i\\
    J_i' = \{ \instr{1}{\aout{i}}{M_i} \} \cup J_i\\
    \vdots
}{
    \cc{(...,S_i,...)} = ... \cup J_i' \cup ...
}
$$ 
