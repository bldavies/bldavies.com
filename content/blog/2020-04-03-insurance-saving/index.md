---
title: Insurance and saving
tags: [economics]
loadMathJax: yes
---

The seminal model of insurance demand ([Arrow, 1963](https://www.jstor.org/stable/1812044); [Mossin, 1968](https://www.jstor.org/stable/1830049)) describes a consumer who chooses the level of coverage `\(I^*\)` that maximises their expected utility
`$$\phi(I)=(1-p)u(Y-\pi I)+pu(Y-\pi I-L+I),$$`
where
`\(p\)` is the probability of suffering a binary loss of fixed size `\(L\)`,
`\(Y\)` is the consumer's riskless income,
`\(u\)` is their increasing and concave utility function,
and `\(\pi\)` is the per-unit price of insurance.
In this model, the consumer buys full insurance (i.e., chooses `\(I^*=L\)`) if and only if the premium is actuarially fair (i.e., if `\(\pi=p\)`), and their demand for insurance decreases with income if their [absolute risk aversion](https://en.wikipedia.org/wiki/Risk_aversion#Absolute_risk_aversion) decreases with wealth.

A more realistic model would contain at least two periods:
one in which the consumer buys insurance and
one in which they might suffer an insurable loss.
However, in a two-period model, the consumer suffers a form of [market incompleteness](https://en.wikipedia.org/wiki/Incomplete_markets):
they can buy insurance to shift income into the future, but they cannot do the opposite nor vary their net income in the future no-loss state.

This market incompleteness can be resolved by allowing the consumer to save or borrow at the riskless interest rate.
Then they can save or borrow to smooth income across time, and buy insurance to smooth income across future states of nature.
In particular, they can choose the level of coverage `\(I^*\)` and savings commitment `\(S^*\)` that maximise their expected utility
`$$\begin{align}
\psi(I,S)
&= u(Y_1-\pi I-S) \\
&\quad+\delta[(1-p)u(Y_2+(1+R)S)+pu(Y_2+(1+R)S-L+I)],
\end{align}$$`
where
`\(Y_1\)` and `\(Y_2\)` are the consumer's riskless incomes in the first and second periods,
`\(\delta\in(0,1]\)` is their intertemporal discount factor, and
`\(R\)` is the riskless interest rate.
In this two-period model, the consumer buys full insurance if and only if
`$$\pi=\frac{p}{1+R},$$`
which is the two-period equivalent of the actuarially fair premium rate.
One can also show that
if the consumer cannot save then `\(I^*\)` is increasing in `\(Y_1\)` and decreasing in `\(Y_2\)`, but
if they can save then increases in `\(Y_1\)` and `\(Y_2\)` shift `\(I^*\)` in the same direction as they shift the consumer's absolute risk aversion.
Intuitively, if the consumer cannot save and they want to shift income into the future then the only way to do so is to buy more insurance.
In contrast, if the consumer can save then they can use their savings commitment to smooth increases in income across time, and adjust their insurance demand according to whether such increases make them more or less absolute risk averse.
