---
title: Transitivity in positive correlations
topics: [mathematics]
loadMathJax: yes
---

Let `\(X\)`, `\(Y\)` and `\(Z\)` be random variables.
Suppose that both `\(X\)` and `\(Y\)` are positively correlated with `\(Z\)`.
Are `\(X\)` and `\(Y\)` positively correlated?

The answer to this question is "not necessarily."
To see why, let `\(\rho\in[-1,1]\)` be a constant, and define the random variables
`$$X=\rho Z+W \tag{1}$$`
and
`$$Y=\rho Z-W \tag{2}$$`
with `\(Z\sim N(0,1)\)` and `\(W\sim N(0,1-\rho^2)\)`.[^normal]
Then `\(W\)`, `\(X\)`, `\(Y\)` and `\(Z\)` have zero means, while `\(X\)`, `\(Y\)` and `\(Z\)` have unit variances.
It follows that
`$$\begin{align}
\newcommand{\E}{\mathrm{E}}
\newcommand{\Corr}{\mathrm{Corr}}
\newcommand{\Cov}{\mathrm{Cov}}
\newcommand{\Var}{\mathrm{Var}}
\Corr(X,Y)
&= \frac{\Cov(X,Y)}{\sqrt{\Var(X)}\sqrt{\Var(Y)}} \\
&= \Cov(X,Y) \\
&= \E[XY]-\E[X]\E[Y] \\
&= \E[XY],
\end{align}$$`
and similarly `\(\Corr(X,Z)=\E[XZ]\)` and `\(\Corr(Y,Z)=\E[YZ]\)`.
Now
`$$\begin{align}
\E[XZ]
&= \E[(\rho Z+W)Z] \\
&= \rho\E[Z^2]+\E[WZ] \\
&= \rho\Var(Z)+\rho\E[Z]^2+\Cov(W,Z)+\E[W]\E[Y] \\
&= \rho
\end{align}$$`
because `\(W\)` and `\(Z\)` are independent.
A similar argument yields `\(\E[YZ]=\rho\)`.
Finally, substituting `\((1)\)` into `\((2)\)` so as to eliminate `\(W\)` gives
`$$Y=2\rho Z-X,$$`
from which we obtain
`$$\begin{align}
\Corr(X,Y)
&= \E[XY] \\
&= \E[X(2\rho Z-X)] \\
&= 2\rho\E[XZ]-\E[X^2] \\
&= 2\rho\E[XZ]-\Var(X)+\E[X]^2 \\
&= 2\rho^2-1.
\end{align}$$`
Thus, if `\(\rho\in(0,1/\sqrt{2})\)` then `\(X\)` and `\(Y\)` share a negative correlation even though both are correlated positively with `\(Z\)`.
Intuitively, if `\(\rho\)` is sufficiently small then the negative correlation between the error terms `\(W\)` and `\(-W\)` dominates the positive correlations between `\(X\)` and `\(Z\)`, and `\(Y\)` and `\(Z\)`.

[^normal]: Here `\(N(\mu,\sigma^2)\)` denotes the normal distribution with mean `\(\mu\)` and variance `\(\sigma^2\)`.
