---
title: Correlation and concatenation
topics: [statistics]
summary: |
  Appending a mirrored version of bivariate data to itself changes the correlation in those data.
linkSource: yes
loadMathJax: yes
---

Suppose I have data `\((a_i,b_i)_{i=1}^n\)` on two random variables `\(A\)` and `\(B\)`.
I store my data as vectors `a` and `b`, and compute their correlation using the `cor` function in R:

```r
cor(a, b)
```

```
## [1] 0.4326075
```

Now suppose I append a mirrored version of my data by defining the vectors

```r
alpha = c(a, b)
beta = c(b, a)
```

so that `alpha` is a concatenation of the `\(a_i\)` and `\(b_i\)` values, and `beta` is a concatenation of the `\(b_i\)` and `\(a_i\)` values.
I compute the correlation of `alpha` and `before` as before:

```r
cor(alpha, beta)
```

```
## [1] 0.4288428
```

Notice that `cor(a, b)` and `cor(alpha, beta)` are not equal.
This surprised me.
How can appending a copy of *the same data* change the correlation within those data?

The answer is that the concatenated data `\((\alpha_i,\beta_i)_{i=1}^{2n}\)` have different marginal distributions than the original data `\((a_i,b_i)_{i=1}^n\)`.
Indeed one can show that
`$$\DeclareMathOperator{\Cor}{Cor}
\DeclareMathOperator{\Cov}{Cov}
\DeclareMathOperator{\E}{E}
\DeclareMathOperator{\Var}{Var}
\begin{align}
\E[\alpha]=\E[\beta]=\frac{\E[a]+\E[b]}{2}
\end{align}$$`
and
`$$\begin{align}
\E[\alpha^2]=\E[\beta^2]=\frac{\E[a^2]+\E[b^2]}{2},
\end{align}$$`
where
`$$\E[\alpha]\equiv\frac{1}{2n}\sum_{i=1}^n\alpha_i$$`
is the empirical mean of the `\(\alpha_i\)` values, and where `\(\E[\beta]\)`, `\(\E[a]\)`, and `\(\E[b]\)` are defined similarly.
It turns out that `\(\E[\alpha\beta]=\E[ab]\)`, but since the marginal distributions are different the empirical correlations are different.
In fact
`$$\Cor(\alpha,\beta)=\frac{\Cov(a,b)-0.25\left(\E[a]+\E[b]\right)^2}{0.5\Var(a)+0.5\Var(b)+0.25\left(\E[a]-\E[b]\right)^2},$$`
where `\(\Cor\)`, `\(\Cov\)`, and `\(\Var\)` are the empirical correlation, covariance, and variance operators.
This expression implies that `cor(alpha, beta)` and `cor(a, b)` will be equal if the `\(a_i\)` and `\(b_i\)` values have the same means and variances.
We can achieve this by scaling `a` and `b` before computing their correlation:

```r
cor(scale(a), scale(b))
```

```
## [1] 0.4326075
```

The `scale` function de-means its argument and scales it to have unit variance.
These operations don't change the correlation of `a` and `b`.
But they *do* change the correlation of `alpha` and `beta`:

```r
alpha = c(scale(a), scale(b))
beta = c(scale(b), scale(a))

cor(alpha, beta)
```

```
## [1] 0.4326075
```

Now the two correlations agree!

I came across this phenomenon while writing [my previous post](/blog/friendship-paradox/), in which I discuss the degree [assortativity](/blog/assortative-mixing/) among nodes in [Zachary's (1977) karate club network](https://en.wikipedia.org/wiki/Zachary's_karate_club).
One way to measure this assortativity is to use the `degree_assortativity` function in [igraph](https://igraph.org/):

```r
library(igraph)

G = graph.famous('Zachary')

assortativity_degree(G)
```

```
## [1] -0.4756131
```

This function returns the correlation of the degrees of adjacent nodes in `G`.
Another way to compute this correlation is to

1. construct a matrix `el` in which rows correspond to edges and columns list incident nodes;
2. define the vectors `d1` and `d2` of degrees among the nodes listed in `el`;
3. compute the correlation of `d1` and `d2` using `cor`.

Here's what I get when I take those three steps:

```r
el = as_edgelist(G)

d = degree(G)
d1 = d[el[, 1]]  # Ego degrees
d2 = d[el[, 2]]  # Alter degrees

cor(d1, d2)
```

```
## [1] -0.4769563
```

Notice that `cor(d1, d2)` disagrees with the value of `assortativity_degree(G)` computed above.
This is because the vectors `d1` and `d2` have different means and variances:

```r
c(mean(d1), mean(d2))
```

```
## [1] 7.487179 8.051282
```

```r
c(var(d1), var(d2))
```

```
## [1] 25.94139 32.23110
```

These differences come from `el` listing each edge only once: it includes a row `c(i, j)` for the edge between nodes `\(i\)` and `\(j\not=i\)`, but not a row `c(j, i)`.
Whereas `assortativity_degree` accounts for edges being undirected by adding the row `c(j, i)` before computing the correlation.
This is analogous to the "append the mirrored data" step I took to create `\((\alpha_i,\beta_i)_{i=1}^{2n}\)` above.
Appending the mirror of `el` to itself before computing `cor(d1, d2)` returns the same value as `assortativity_degree(G)`:

```r
el = rbind(
  el,
  matrix(c(el[, 2], el[, 1]), ncol = 2)  # el's mirror
)

d1 = d[el[, 1]]
d2 = d[el[, 2]]

c(assortativity_degree(G), cor(d1, d2))
```

```
## [1] -0.4756131 -0.4756131
```

