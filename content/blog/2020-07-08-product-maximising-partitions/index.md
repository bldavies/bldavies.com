---
title: Product-maximising partitions
topics: [mathematics]
linkSource: yes
loadMathJax: yes
---

Let `\(\newcommand{\N}{\mathbb{N}}\N=\{1,2,\ldots\}\)` be the set of positive integers.
A *partition* of `\(n\in\N\)` is a way of writing `\(n\)` as a sum of positive integers, called *parts*.
For example, `\(1+2+3\)` is a partition of `\(6\)`, with parts `\(1\)`, `\(2\)`, and `\(3\)`.
Partitions are unique up to rearrangement: `\(1+2+3\)` and `\(3+2+1\)` are the same partition, but `\(1+2+3\)` and `\(3+3\)` are different partitions.

This post discusses the following problem:

> Let `\(n\ge2\)` be a positive integer.
> Find a partition of `\(n\)` whose parts have maximum product.

For example, the parts in `\(1+2+3\)` have product `\(1\times2\times3=6\)`, while the parts in `\(3+3\)` have product `\(3\times3=9\)`.
Our goal is to find a product-maximising partition for arbitrary `\(n\)`.

Let `\(x_1+x_2+\cdots+x_k\)` be a partition of `\(n\)`.
If `\(x_1=1\)` then `\(k\ge2\)` (since `\(n\ge2\)`) and
`$$\begin{align}
\prod_{i=1}^kx_i
&= 1\times x_2\times\prod_{i=3}^kx_i \\
&< (1+x_2)\times\prod_{i=3}^kx_i
\end{align}$$`
because the `\(x_i\)` are strictly positive.[^empty-product]
Thus, replacing the partition `\(x_1+x_2+\cdots+x_k\)` with `\((1+x_2)+x_3+\cdots+x_k\)` delivers a greater product.
Since the `\(x_i\)` can be rearranged arbitrarily, it follows that product-maximising partitions contain no parts equal to one.
Similarly, if `\(x_1>4\)` then
`$$\begin{align}
\prod_{i=1}^kx_i
&= x_1\times\prod_{i=2}^kx_i \\
&< 3(x_1-3)\times\prod_{i=2}^kx_i,
\end{align}$$`
so we can obtain a greater product by replacing `\(x_1+x_2+\cdots+x_k\)` with `\(3+(x_1-3)+x_2+\cdots+x_k\)`.
It follows that product-maximising partitions contain no parts greater than four.
But `\(2\times2=4\)` and `\(2+2=4\)`, so we can replace each four with two twos without reducing the parts' product.
Thus, we can obtain a product-maximising partition using only twos and threes.
Finally, if a partition contains three twos then we should replace them with two threes, since `\(2+2+2=3+3\)` but `\(2^3=8<9=3^2\)`.

[^empty-product]: If `\(j>k\)` then `\(\prod_{i=j}^kx_i=1\)` [by convention](https://en.wikipedia.org/wiki/Empty_product).

To summarise, we can obtain a product-maximising partition using only twos and threes, with as many threes as possible.
Letting `\(n=3q+r\)` for some `\(q\in\N\cup\{0\}\)` and `\(r\in\{0,1,2\}\)`, the maximum product we can obtain is
`$$P(n)=\begin{cases}3^q&\text{if}\ r=0\\ 2^2\times3^{q-1}&\text{if}\ r=1\\ 2\times3^q&\text{if}\ r=2.\end{cases}$$`
We can approximate this solution by [relaxing](https://en.wikipedia.org/wiki/Relaxation_(approximation)) the integrality constraint on the `\(x_i\)`.
For any given `\(k\)`, we can find the vector `\(x^*\)` that solves
`$$\newcommand{\R}{\mathbb{R}}\max_{x\in\R_+^k}\prod_{i=1}^kx_i\ \text{subject to}\ \sum_{i=1}^kx_i=n \tag{1},$$`
where `\(\R_+\)` is the set of positive real numbers.
This vector has `\(x_i^*=n/k\)` for each `\(i\in\{1,2,\ldots,k\}\)`, so that `\(\prod_{i=1}^kx_i^*=(n/k)^k\)`.[^lagrange]
If there was no integrality constraint on `\(k\)` then we could maximise `\((n/k)^k\)` by choosing `\(k=n/e\)`, where `\(e\approx2.718\)` is Euler's constant.
But `\(k\)` must be an integer, so we should round it to the nearest integer in whatever direction delivers the greatest value of `\((n/k)^k\)`.
Doing so delivers an estimate
`$$\hat{P}(n)=\max\left\{\left(\frac{n}{\lfloor n/e\rfloor}\right)^{\lfloor n/e\rfloor},\left(\frac{n}{\lceil n/e\rceil}\right)^{\lceil n/e\rceil}\right\}$$`
of `\(P(n)\)`, where `\(x\mapsto\lfloor x\rfloor\)` and `\(x\mapsto\lceil x\rceil\)` are the floor ("round down") and ceiling ("round up") functions.

[^lagrange]: One can derive `\(x_i^*=n/k\)` using the [method of Lagrange multipliers](https://en.wikipedia.org/wiki/Lagrange_multiplier).

The table below compares `\(P(n)\)` and `\(\hat{P}(n)\)` for various `\(n\)`.
Since `\(\{2,3\}\subset\mathbb{R}_+\)`, the partition of `\(n\)` using twos and as many threes as possible is a feasible, but not necessarily optimal, solution to `\((1)\)`.
Thus `\(P(n)\le\hat{P}(n)\)` for each `\(n\ge2\)`.
The multiplicative error `\(\hat{P}(n)/P(n)\)` grows exponentially with `\(n\)` because the exponent `\(k\in\{\lfloor n/e\rfloor,\lceil n/e\rceil\}\)` of `\((n/k)^k\)` grows (increasingly linearly) with `\(n\)`, amplifying the error in the approximation `\(n/k\sim e\)` to each part in the partition underlying `\(P(n)\)`.

|  `\(n\)`  |           `\(P(n)\)`            |        `\(\hat{P}(n)\)`         | `\(\hat{P}(n)/P(n)\)` |
|:-----:|:---------------------------:|:---------------------------:|:-----------------:|
|   2   |              2              |              2              |       1.00        |
|   3   |              3              |              3              |       1.00        |
|   4   |              4              |              4              |       1.00        |
|   5   |              6              |            6.25             |       1.04        |
|  10   |             36              |            39.06            |       1.09        |
|  50   |  8.61&times;10<sup>7</sup>  |  9.70&times;10<sup>7</sup>  |       1.13        |
|  100  | 7.41&times;10<sup>15</sup>  | 9.47&times;10<sup>15</sup>  |       1.28        |
|  500  | 3.19&times;10<sup>79</sup>  | 7.66&times;10<sup>79</sup>  |       2.40        |
| 1,000 | 1.01&times;10<sup>159</sup> | 5.86&times;10<sup>159</sup> |       5.78        |

