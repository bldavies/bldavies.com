---
title: Grids, modular arithmetic, and the binomial theorem
topics: [probability]
linkSource: yes
loadMathJax: yes
---

[The latest Riddler Express](https://fivethirtyeight.com/features/can-you-connect-the-dots/) asks about driving on grids (paraphrased):

> Consider an infinite grid of roads running north-south and east-west.
> You are driving north in that grid.
> Suppose that, at each intersection, you turn left or right with equal probability.
> What is the probability that you will be driving north after ten intersections?

If we make as many left turns as right turns then they cancel each other out and we remain due north.
Similarly, if we make exactly four more left turns than right turns then the four extra left turns complete a loop and return us to our initial direction.
In general, if we make `\(L\)` left turns and `\(R\)` right turns, we remain due north if and only if `\((L-R)\)` is a multiple of four.
Thus, we want to compute the probability
`$$\renewcommand{\mod}{\ \mathrm{mod}\ }p\equiv\Pr\left((L-R)\mod4=0\right),$$`
where the [modulo operation](https://en.wikipedia.org/wiki/Modulo_operation) `\(x\mod y\)` returns the remainder of the integer division of `\(x\)` by `\(y\)`.
Since there are ten intersections, each of which require a left or right turn, we have `\(L+R=10\)` and therefore `\(L-R=2L-10\)`.
We can turn left up to ten times, and each left turn occurs independently with probability `\(0.5\)`.
Thus, `\(L\)` is binomially distributed with
`$$\Pr(L=l)=\binom{10}{l}(0.5)^l(1-0.5)^{10-l}$$`
for each `\(l\in\{0,1,2,\ldots,10\}\)`, where
`$$\binom{n}{k}=\frac{n!}{k!\,(n-k)!}$$`
is the binomial coefficient.
From here, we can compute `\(p\)` directly:

```r
l <- 0:10
p <- choose(10, l) * 0.5 ^ l * (1 - 0.5) ^ (10 - l)
sum(p[which((2 * l - 10) %% 4 == 0)])
```

```
## [1] 0.5
```
The analytical solution is more involved.
First, notice that
`$$\begin{align}
p
&= \Pr((L-R)\ \mathrm{mod}\ 4=0) \\
&= \Pr((2L-10)\ \mathrm{mod}\ 4=0) \\
&= \Pr((L-5)\ \mathrm{mod}\ 2=0) \\
&= \Pr((L-1)\ \mathrm{mod}\ 2=0) \\
&= \Pr(L\ \mathrm{mod}\ 2=1) \\
&= \Pr(L\ \text{is odd}) \\
&= \sum_{l\in O_{10}}\Pr(L=l),
\end{align}$$`
where
`$$O_n=\{k\in\{1,2,\ldots,n\}:k\ \text{is odd}\}$$`
is the set of odd positive integers less than or equal to `\(n\)`.
We can sum `\(\Pr(L=l)\)` over `\(l\in O_{10}\)` using the [binomial theorem](https://en.wikipedia.org/wiki/Binomial_theorem), which states that
`$$(x+y)^n=\sum_{k=0}^n\binom{n}{k}x^{n-k}y^k$$`
for all `\(x,y\in\mathbb{R}\)` and integers `\(n\ge0\)`.
In particular, we have
`$$\begin{align}
(x+y)^n-(x-y)^n
&= \sum_{k=0}^n\binom{n}{k}x^{n-k}y^k-\sum_{k=0}^n\binom{n}{k}x^{n-k}(-1)^ky^k \\
&= \sum_{k=0}^n\binom{n}{k}x^{n-k}\left(1-(-1)^k\right)y^k \\
&= 2\sum_{k\in O_n}\binom{n}{k}x^{n-k}y^k
\end{align}$$`
because `\((1-(-1)^k)\)` equals zero when `\(k\)` is even and two when `\(k\)` is odd.
Thus, choosing `\((n,x,y)=(10,1-0.5,0.5)\)` gives
`$$\begin{align}
p
&= \sum_{l\in O_{10}}\Pr(L=l) \\
&= \sum_{l\in O_{10}}\binom{10}{l}(1-0.5)^{10-l}(0.5)^l \\
&= \frac{\left((1-0.5)+0.5\right)^{10}-\left((1-0.5)-0.5\right)^{10}}{2} \\
&= \frac{1^{10}-0^{10}}{2} \\
&= 0.5.
\end{align}$$`
This longer, analytical approach works for any even value of `\(n\)`, which corresponds to the number of intersections.
If this number is odd then exactly one of `\(L\)` and `\(R\)` must be odd, and so four cannot divide `\((L-R)\)`.
Thus, if we drive through `\(n\)` intersections then the probability that we remain due north is `\(0.5\)` if `\(n\)` is even and zero if `\(n\)` is odd.
