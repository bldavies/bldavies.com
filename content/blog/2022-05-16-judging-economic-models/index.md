---
title: Judging economic models
topics: [economics, research]
summary: |
  We shouldn't judge models by their realism.
  We should them by their predictions and clarity.
---

Lots of people criticize economic models for being unrealistic.
"Humans are irrational," they cry; "financial markets are inefficient."
These criticisms are valid, but they miss the point.
Models aren't *meant* to be realistic.
They're meant to simplify reality: to focus our attention on what's relevant and abstract from what isn't.
[All models are wrong](https://en.wikipedia.org/wiki/All_models_are_wrong)---we shouldn't judge them for their realism.

How *should* we judge a model?
Here are two criteria:

1. it makes predictions that agree with data;
2. it helps us think clearly about how the world works.

Economists use models to generate predictions, such as "people buy less when prices rise."
We test these predictions using data from the real world.
When the predictions and data disagree, we reject the model and search for something better.
This search leads to new models with new predictions.
Under the first criterion, "better" models make more true predictions.

Model predictions come in different forms.
"Within-sample" predictions tell us about data we've seen; "out-of-sample" predictions tell us what to expect in data we *haven't* seen.

We test within-sample predictions by asking if the model "fits" the data it was designed to explain.
Bad models fail this test.
But useless models can pass it.
For example, suppose I have a list of quantity-price pairs.
I use the list as my "model" of demand.
My model fits the data because the data fit the data.
But my model says nothing about *why* people buy a given quantity at a given price.
It also says nothing about how much people buy at *other* prices.

Hence, we also test out-of-sample predictions.
We ask if the model fits relevant data it *wasn't* designed to explain.
This helps us learn whether the model captures general principles rather than contextual quirks.
It also helps us be logically consistent.
For example, suppose I want to explain some pattern Y.
I write down a model in which I assume behavior X, which implies Y.
But X *also* implies pattern Z.
Do I think Z is reasonable?
Do I observe it empirically?
If not, then I should revise my model and not assume X.
Writing down the model makes my assumptions explicit and easier to correct.

The second criterion makes room for some models with false predictions.
The [efficient market hypothesis](https://en.wikipedia.org/wiki/Efficient-market_hypothesis) is a good example.
It predicts that you can't use public information to "beat the market."
This prediction is false---[RenTech](https://en.wikipedia.org/wiki/Renaissance_Technologies) offers one counter-example.
But the EMH helps us organize our thoughts about how, when, and why prices incorporate information.
It guides our intuitions.
It also provides a benchmark against which to compare models of *in*efficient markets.

Another benchmark model is that of [DeGroot learning](/blog/degroot-learning-social-networks/).
Its main prediction---"under some conditions, society reaches a consensus eventually"---is hard to test because "eventually" never arrives.
But the model offers a tractable (and [surprisingly realistic](https://doi.org/10.3982/ECTA14407)) way to study how people learn.
We can enrich the model by adding [homophily](https://doi.org/10.1093/qje/qjs021) or [misinformation](https://doi.org/10.1287/mnsc.2022.4340).
These additions make the model more realistic but more complex.
Having a benchmark helps us assess whether the extra realism is "worth" the extra complexity (e.g., by adding explanatory power).

Sometimes the realism *is* worth the complexity.
This is especially true when we use models to help us design new systems.
As [Jackson (2019)](https://doi.org/10.1007/978-3-030-18050-8_72) notes,

> One would never design a large airliner without carefully modeling its aeronautic properties, and testing it thoroughly via simulations and test flights of prototypes, before loading it with passengers.
> Why should designing a market for health insurance be any different?
> Models have the virtue of offering us insight in to what should we expect in scenarios that have never been tried before.

Models give us prototypes to test.
They let us run theoretical experiments when "real" experiments are expensive or infeasible.
They guide our search for better designs.
The "best" design might be complicated because reality is complicated.
Ignoring some complications in the model may lead us astray.
But we don't need *all* the complications: health insurance markets don't depend critically on whether I buy blue jeans or black.

Moreover, when designing new systems, the object of interest is the design rather than the model of it.
The model is just a tool.
We use it to focus on relevant factors and abstract from irrelevant factors.
Different models arise from making different choices about which factors are relevant.
Our job as economic modelers is to make those choices well.
