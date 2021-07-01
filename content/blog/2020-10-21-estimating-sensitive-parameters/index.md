---
title: Estimating sensitive parameters
topics: [statistics]
hidden: true
loadMathJax: yes
---

Suppose some proportion `\(\theta\)` of the population engages in a socially undesirable activity---say, evading taxes.
We want to estimate `\(\theta\)`, but can't ask people directly because they may fear penalities from incriminating themselves.

One solution to this problem is as follows.
Choose another characteristic that people don't mind reporting and for which we know the population prevalence---say, whether they are right-handed.
Let `\(\alpha\)` be the (assumedly known) proportion of the population with this characteristic.
Sample `\(n\)` people, and give them the following instructions:

> Flip a fair coin, but *don't tell me what you get*.
> If you get heads, answer the question "do you evade taxes?"
> If you get tails, answer the question "are you right-handed?"

The coin toss outcome's unobservability shields respondents' revelation of tax evasion---they could be responding "Yes" to the question of whether they are right-handed.
This shield, hopefully, elicits truthful reporting.
Then, by the [Law of Total Probability](https://en.wikipedia.org/wiki/Law_of_total_probability), the probability that someone responds "Yes" is
`$$p=\frac{\theta+\alpha}{2}.$$`
Let `\(X\)` be the number of people who respond "Yes."
Then `\(X\)` is Binomially distributed with `\(n\)` trials and success rate `\(p\)`, and so has mean `\(\mathrm{E}[X]=np\)` and variance `\(\mathrm{Var}(X)=np(1-p)\)`.
Consequently, the estimator
`$$\hat\theta_n=2\frac{X}{n}-\alpha$$`
of `\(\theta\)` has mean `\(\mathrm{E}[\hat\theta_n]=\theta\)` and variance
`$$\begin{align*}
\mathrm{Var}(\hat\theta_n)
&= \frac{4}{n^2}\mathrm{Var}(X) \\
&= \frac{4p(1-p)}{n} \\
&\le \frac{1}{n}
\end{align*}$$`
since `\(4p(1-p)\le1\)` for any `\(p\in[0,1]\)`.
Thus, `\(\hat\theta_n\)` is an unbiased estimator of `\(\theta\)` and becomes more precise as the sample size `\(n\)` grows.
We can quantify this precision using [Chebyshev's inequality](https://en.wikipedia.org/wiki/Chebyshev%27s_inequality): for any `\(\varepsilon>0\)`, we have
`$$\Pr(\lvert\hat\theta_n-\theta\rvert\ge\varepsilon)\le\frac{\mathrm{Var}(\hat\theta_n)}{\varepsilon^2}$$`
and therefore
`$$\Pr(\lvert\hat\theta_n-\theta\rvert<\varepsilon)\ge1-\frac{1}{n\varepsilon^2}.$$`
Thus, for example, choosing `\(n\ge4000\)` guarantees that `\(\hat\theta_n\)` differs from `\(\theta\)` by no more than `\(\varepsilon=0.05\)` with probability 0.9.
