---
title: Decomposing matrices of pairwise minima
topics: [mathematics, statistics]
loadMathJax: yes
---

Let `\(A\)` be the `\(n\times n\)` matrix with `\({ij}^\text{th}\)` entry `\(A_{ij}=\min\{i,j\}\)`.
From [a previous post](/blog/inverting-matrices-pairwise-minima/), we know `\(A\)` has a tridiagonal inverse `\(A^{-1}\)` with `\({ij}^\text{th}\)` entry[^verify]
`$$\left[A^{-1}\right]_{ij}=\begin{cases}
2 & \text{if}\ i=j<n \\
1 & \text{if}\ i=j=n \\
-1 & \text{if}\ \lvert i-j\rvert=1 \\
0 & \text{otherwise}.
\end{cases}$$`
For example, if `\(n=4\)` then
`$$A=\begin{bmatrix}
1 & 1 & 1 & 1 \\
1 & 2 & 2 & 2 \\
1 & 2 & 3 & 3 \\
1 & 2 & 3 & 4
\end{bmatrix}$$`
has inverse
`$$A^{-1}=\begin{bmatrix}
2 & -1 & 0 & 0 \\
-1 & 2 & -1 & 0 \\
0 & -1 & 2 & -1 \\
0 & 0 & -1 & 1
\end{bmatrix}$$`

[^verify]: One can verify this claim by showing `\(AA^{-1}\)` equals the identity matrix.

We can use our knowledge of `\(A^{-1}\)` to [eigendecompose](https://en.wikipedia.org/wiki/Eigendecomposition_of_a_matrix) `\(A\)`.
To see how, let `\(\{(\lambda_j,v_j)\}_{j=1}^n\)` be the eigenpairs of `\(A^{-1}\)`.
[Yueh (2005, Theorem 1)](https://scholar.google.com/scholar?cluster=3799141027630354794) shows that the eigenvector `\(v_j\in\mathbb{R}^n\)` corresponding to the `\(j^\text{th}\)` eigenvalue
`$$\lambda_j=2\left(1+\cos\left(\frac{2j\pi}{2n+1}\right)\right)$$`
has `\(i^\text{th}\)` component
`$$[v_j]_i=\alpha\sin\left(\frac{2ij\pi}{2n+1}\right),$$`
where `\(\alpha\in\mathbb{R}\)` is an arbitrary scalar.
This vector has length
`$$\begin{align}
\lvert\vert v_j\rvert\rvert
&\equiv \sqrt{\sum_{i=1}^n\left([v_j]_i\right)^2} \\
&= \sqrt{\sum_{i=1}^n\alpha^2\sin^2\left(\frac{2ij\pi}{2n+1}\right)} \\
&= \lvert\alpha\rvert\sqrt{\frac{2n+1}{4}},
\end{align}$$`
where the last equality can be verified using Wolfram Alpha and proved using complex analysis.
So choosing `\(\alpha=2/\sqrt{2n+1}\)` ensures that the eigenvectors `\(v_1,v_2,\ldots,v_n\)` of `\(A^{-1}\)` have unit length.
Then, by the [spectral theorem](https://en.wikipedia.org/wiki/Spectral_theorem), these vectors form an [orthonormal basis](https://en.wikipedia.org/wiki/Orthonormal_basis) for `\(\mathbb{R}^n\)`.
As a result, the `\(n\times n\)` matrix
`$$V=\begin{bmatrix} v_1 & v_2 & \cdots & v_n\end{bmatrix}$$`
with `\({ij}^\text{th}\)` entry `\(V_{ij}=[v_j]_i\)` is [orthogonal](https://en.wikipedia.org/wiki/Orthogonal_matrix).
Moreover, letting `\(\Lambda\)` be the `\(n\times n\)` diagonal matrix with `\({ii}^\text{th}\)` entry `\(\Lambda_{ii}=\lambda_i\)` yields the eigendecomposition
`$$\begin{align}
A^{-1}
&= V\Lambda V^T \\
&= \sum_{j=1}^n\lambda_jv_jv_j^T
\end{align}$$`
of `\(A^{-1}\)`.
It follows from the orthogonality of `\(V\)` that
`$$\begin{align}
A
&= \left(V\Lambda V^T\right)^{-1} \\
&= V\Lambda^{-1} V^T \\
&= \sum_{j=1}^n\frac{1}{\lambda_j}v_jv_j^T
\end{align}$$`
is the eigendecomposition of `\(A\)`.
Thus `\(A\)` and `\(A^{-1}\)` have the same eigenvectors, but the eigenvalues of `\(A\)` are the reciprocated eigenvalues of `\(A^{-1}\)`.

Here's one scenario in which this decomposition is useful:
Suppose I observe data `\(\mathcal{D}=\{(x_i,y_i)\}_{i=1}^n\)` generated by the process
`$$\DeclareMathOperator{\Cov}{Cov}
\DeclareMathOperator{\E}{E}
\DeclareMathOperator{\Var}{Var}
\newcommand{\veps}{\sigma_\epsilon^2}
\newcommand{\R}{\mathbb{R}}
\renewcommand{\epsilon}{\varepsilon}
\begin{align}
y_i
&= f(x_i)+\epsilon_i \\
\epsilon_i
&\overset{\text{iid}}{\sim} \mathcal{N}(0,\veps),
\end{align}$$`
where `\(\{f(x)\}_{x\ge0}\)` is a sample path of a standard [Wiener process](/blog/simulating-wiener-ornstein-uhlenbeck-processes/) and where the errors `\(\epsilon_i\)` are iid normally distributed with variance `\(\veps\)`.
I use these data to estimate `\(f(x)\)` for some `\(x\ge0\)`.[^noisy-gm]
My estimator `\(\hat{f}(x)\equiv\E[f(x)\mid\mathcal{D}]\)` has conditional variance
`$$\Var\left(\hat{f}(x)\mid\mathcal{D}\right)=\Var(f(x))-w^T\Sigma^{-1} w,$$`
where `\(w\in\R^n\)` is the vector with `\(i^\text{th}\)` component `\(w_i=\Cov(y_i,f(x))\)` and where `\(\Sigma\in\R^{n\times n}\)` is the covariance matrix with `\({ij}^\text{th}\)` entry `\(\Sigma_{ij}=\Cov(y_i,y_j)\)`.
If `\(x_i=i\)` for each `\(i\in\{1,2,\ldots,n\}\)`, then we can express this matrix as the sum
`$$\Sigma=A+\veps I,$$`
where `\(A\)` is the `\(n\times n\)` matrix defined above and where `\(I\)` is the `\(n\times n\)` identity matrix.
But we know `\(A=V\Lambda^{-1}V^T\)`.
We also know `\(I=VV^T\)`, since `\(V\)` is orthogonal.
It follows that
`$$\begin{align*}
\Sigma^{-1}
&= \left(V\Lambda^{-1}V^T+\veps VV^T\right)^{-1} \\
&= V\left(\Lambda+\frac{1}{\veps}I\right)V^T,
\end{align*}$$`
from which we can derive a (relatively) closed-form expression for the conditional variance of `\(\hat{f}(x)\)` given `\(\mathcal{D}\)`.

[^noisy-gm]: I discuss this estimation problem in [a recent paper](https://arxiv.org/abs/2404.00784).