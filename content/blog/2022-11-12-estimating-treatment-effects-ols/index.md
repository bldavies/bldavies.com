---
title: Estimating treatment effects with OLS
topics: [statistics]
summary: |
  The treatment effects estimated using ordinary least squares depend on how the regression model is specified.
linkSource: yes
loadMathJax: yes
---

A crop farmer wonders if he should use a new fertilizer.
He asks his peers what fertilizer they use and what are their annual yields.
He notices that some have different soil.
"That's annoying," the farmer thinks.
"If we all had the same soil, then I could estimate the benefit of using the new fertilizer by comparing the mean yields among farmers who do and don't use it.
But now I have to control for soil too!"

Thankfully the farmer learned about [ordinary least squares](https://en.wikipedia.org/wiki/Ordinary_least_squares) in his youth.
He remembers that he can control for variables by including them in a regression equation.
He posits a linear model
`$$\text{yield}=\beta_1\text{fert}+\beta_2\text{soil}+\epsilon,$$`
where

* `\(\text{fert}\)` indicates using the new fertilizer,
* `\(\text{soil}\)` indicates having a different soil,
* `\(\beta_1\)` and `\(\beta_2\)` are the average marginal effects of changing fertilizers and soils, and
* `\(\epsilon\)` is an iid random error.

The farmer estimates `\(\beta_1\)` and `\(\beta_2\)` using OLS, and gets the following results:

| Coefficient | Estimate | Std. error |
|:-----------:|:--------:|:----------:|
|  `\(\beta_1\)`  |  0.787   |   0.210    |
|  `\(\beta_2\)`  |  1.013   |   0.211    |

The farmer's daughter enters his office.
She looks at his estimates and asks, "why don't you just compare the mean yields among farmers with the same soil as you?
That seems less complicated than OLS."
The farmer agrees.
He computes the conditional means
`$$\mu_{10}\equiv\mathrm{E}[\text{yield}\mid\text{fert}=1\ \text{and}\ \text{soil}=0]$$`
and
`$$\mu_{00}\equiv\mathrm{E}[\text{yield}\mid\text{fert}=0\ \text{and}\ \text{soil}=0]$$`
in his data, and finds that `\(\mu_{10}-\mu_{00}=0.965\)`.
This surprises the farmer:
"I thought OLS controlled for variation in soil.
I expected it to give me the same result as computing the difference in conditional means.
But it doesn't.
Why not?"

The farmer has an idea:
"What if I include an interaction term?"
He posits an extended model
`$$\text{yield}=\gamma_1\text{fert}+\gamma_2\text{soil}+\gamma_3(\text{fert}\cdot\text{soil})+\epsilon,$$`
estimates it via OLS, and gets the following results:

| Coefficient | Estimate | Std. error |
|:-----------:|:--------:|:----------:|
| `\(\gamma_1\)`  |  0.965   |   0.290    |
| `\(\gamma_2\)`  |  1.208   |   0.303    |
| `\(\gamma_3\)`  |  -0.377  |   0.422    |

"Interesting," he thinks.
"OLS gives me the difference in conditional means if I include an interaction term, but not if I don't.
I wonder what's going on?"

What's going on is that `\(\beta_1\)` and `\(\gamma_1\)` measure different things.
The latter measures the average effect of using the new fertilizer *without changing* soils.
Thus `\(\gamma_1=\mu_{10}-\mu_{00}\)` by definition.
Whereas `\(\beta_1\)` measures the average effect of using the new fertilizer *across all* soils.
Thus
`$$\beta_1=(1-p)\left(\mu_{10}-\mu_{00}\right)+p\left(\mu_{11}-\mu_{01}\right),$$`
where `\(p=\Pr(\text{soil}=1)\)` is the share of the farmer's peers who have a different soil, and
`$$\mu_{fs}\equiv\mathrm{E}[\text{yield}\mid\text{fert}=f\ \text{and}\ \text{soil}=s]$$`
is the mean yield among peers with `\(\text{fert}=f\in\{0,1\}\)` and `\(\text{soil}=s\in\{0,1\}\)`.
The farmer's data has `\(p=0.47\)` and `\(\mu_{11}-\mu_{01}=0.587\)`, giving
`$$\beta_1=(1-0.47)\times0.965+0.47\times0.587=0.787$$`
as in the first table above.

The OLS estimates of `\(\beta_1\)` and `\(\gamma_1\)` differ whenever the effect of using the new fertilizer varies across soils; that is, whenever `\(\gamma_3\not=0\)` in the true model.
But they can also differ when `\(\gamma_3=0\)` due to sampling variation.
For example, suppose the true model is
`$$\text{yield}=\text{fert}+\text{soil}+\epsilon,$$`
where `\(\text{fert}\)` and `\(\text{soil}\)` are independent, and where `\(\epsilon\)` is iid normally distributed.
The differences `\((\mu_{10}-\mu_{00})\)` and `\((\mu_{11}-\mu_{01})\)` in conditional means can differ in small samples because `\(\text{soil}\)` and `\(\epsilon\)` can be correlated by chance.
But this [spurious correlation](https://en.wikipedia.org/wiki/Spurious_relationship) disappears as the sample grows, making `\(\beta_1\)` and `\(\gamma_1\)` converge.
I demonstrate this convergence in the table below.
It shows the mean absolute difference between `\(\beta_1\)` and `\(\gamma_1\)` across many samples of increasing size `\(n\)`:

|  `\(n\)`   | `\(\mathrm{E}\left[\lvert\beta_1-\gamma_1\rvert\right]\)` |
|:------:|:-----------------------------------------------------:|
|  100   |                         0.160                         |
| 1,000  |                         0.050                         |
| 10,000 |                         0.014                         |

---

*Thanks to Anirudh Sankar for reading a draft version of this post.*

