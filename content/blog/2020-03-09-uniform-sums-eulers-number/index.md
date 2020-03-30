---
title: Uniform sums and Euler's number
tags: [math, simulation]
linkSource: yes
loadMathJax: yes
---

Suppose I sample values uniformly at random from the unit interval.
How many samples should I expect to take before the sum of my sampled values exceeds unity?[^numberphile]

[^numberphile]: [Grant Sanderson](https://www.3blue1brown.com) mentions this problem in [this Numberphile video](https://www.youtube.com/watch?v=6_yU9eJ0NxA&t=28m7s).

Let `\(N\)` be the (random) number of samples taken when the sum first exceeds unity.
Then `\(N\)` has expected value `\(E[N]\)` equal to [Euler's number](https://en.wikipedia.org/wiki/E_(mathematical_constant)) `\(e\approx2.718282\)`.
This can be verified approximately via simulation:

```r
simulate <- function(run) {
  tot <- 0
  N <- 0
  while (tot < 1) {
    tot <- tot + runif(1)
    N <- N + 1
  }
  N
}

set.seed(0)
mean(sapply(1:1e5, simulate))
```

```
## [1] 2.7183
```

To see why `\(E[N]=e\)`, let `\((X_i)_{i=1}^\infty\)` be an infinite sequence of random variables with uniform distributions over the unit interval.
Then the probability that `\(N\)` exceeds any non-negative integer `\(n\)` is
`$$\Pr(N>n)=\Pr(X_1+X_2+\cdots+X_n<1).$$`
Consider the unit (hyper)cube in `\(\mathbb{R}^n\)`.
Its vertices comprise the origin, the standard basis vectors `\(e_1,e_2,\ldots,e_n\)`, and the sums of two or more of these basis vectors.
The convex hull of `\(\{0,e_1,e_2,\ldots,e_n\}\)` forms an `\(n\)`-simplex with volume `\(1/n!\)`.
The interior of this simplex is precisely the set
`$$\{X_1,X_2,\ldots,X_n\in[0,1]:X_1+X_2+\cdots+X_n<1\}.$$`
It follows that `\(\Pr(X_1+X_2+\cdots+X_n<1)=1/n!\)` and therefore `\(\Pr(N>n)=1/n!\)` from above.
Now
`$$\Pr(N=n)=\Pr(N>n-1)-\Pr(N>n)$$`
for each `\(n\ge1\)`.
Thus, since `\(\Pr(N>0)=1\)` (and, by convention, `\(0!=1\)`), we have
`$$\begin{align}
E[N]
&= \sum_{n=1}^\infty n\Pr(N=n) \\
&= \sum_{n=1}^\infty n\left(\Pr(N>n-1)-\Pr(N>n)\right) \\
&= \Pr(N>0)+\sum_{n=1}^\infty\Pr(N>n) \\
&= 1+\sum_{n=1}^\infty\frac{1}{n!} \\
&= \sum_{n=0}^\infty\frac{1}{n!} \\
&= e.
\end{align}$$`
The final equality comes from evaluating the Maclaurin series expansion of `\(e^x\)` at `\(x=1\)`.

