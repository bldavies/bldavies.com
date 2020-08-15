---
title: Lessons from Dave Maré
topics: [research, statistics]
---

Last week I finished up at [Motu](https://motu.nz), an economic research institute where I worked for two and half years.
During that time I learned a lot from [Dave Maré](https://motu.nz/about-us/people/dave-mare/), who taught me several techniques for conducting rigorous, intellectually honest empirical research.
This post describes three such techniques:
[stating your predictions](#state-your-predictions),
[having weak priors and strong nulls](#have-weak-priors-and-strong-nulls),
and [killing off the variation](#kill-off-the-variation).

## State your predictions

The scientific method involves stating hypotheses *before* testing them.
Dave encourages this practice at a smaller scale: before plotting figures or printing regression tables, write down what you expect to see.

Stating your predictions forces you to think about how and why variables might be related.
For example, if I regressed workers’ wages on their years of education, I would expect to estimate a positive coefficient because education provides knowledge and skills that make people more employable.
Likewise, if I could control for natural ability then I would expect the coefficient on education to decrease because I would remove some endogeneity bias.
Forming these expectations (and their justifications) in advance makes my [priors](#have-weak-priors-and-strong-nulls) explicit, making them easier to revise when confronted with new evidence.
It also insures against *ex post* rationalisations of the empirical patterns.

Stating your predictions also means you have two independent data sources—your predictions and your figures/tables—that you can compare to identify and correct mistakes.
For example, if I estimated a negative relationship between education and wages, I would want to make sure the disagreement between my intuition and my estimate was not due to errant definitions of the variables in my data.

## Have weak priors and strong nulls

Priors are beliefs held before gathering new evidence.
In empirical research, we usually derive priors from intuitive or logical reasoning (e.g., "education provides knowledge and skills that make people more employable").
However, the world is more complicated than can be described by intuition and logic; people behave in unexpected and unpredictable ways.
Consequently, our priors can be incorrect or incomplete.
To have "weak priors" is to acknowledge such ignorance and to let your beliefs be guided by empirical evidence rather than by fallible reasoning.

However, empirical evidence comes in varying strengths.
To have "strong nulls" is to graduate from "ignorant" to "informed" only when supplied with strong evidence.
For example, if significant relationships persist after controlling for potentially confounding factors then those relationships are likely to reflect the true data-generating process.

## Kill off the variation

Empirical models describe relationships between variables.
These relationships may not be first-order: the mechanisms that we think operate, and that our models aim to capture, may not be central to the stories playing out in our data.
To determine the centrality of our hypothesised mechanisms, Dave suggests trying to "kill off the variation:" add explanatory variables until the coefficients on our covariates of interest become insignificant.

For example, in "[Relatedness, Complexity and Local Growth](/research/relatedness-complexity-local-growth)," Dave and I analyse the relationship between local activity growth rates and several covariates that capture the prevalence of local employee interactions.
In theory, such interactions foster the growth of "complex" activities that build on existing local strengths.
However, in our data, most of the variation in local activity growth is explained by the growth experienced by the city and activity as a whole, and our chosen covariates provide no additional explanatory power.
Thus, while employee interactions may influence employment dynamics at the margin, such interactions are not central to the story of how New Zealand cities evolved during our period of study.
