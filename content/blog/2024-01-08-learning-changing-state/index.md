---
title: Learning about a changing state
topics: [economics, statistics]
---

I have a [new paper](https://arxiv.org/abs/2401.03607) on Bayesian learning.
It extends my model of [paying for precision](/blog/paying-precision/) to a setting where the unknown state changes over time.
This makes the agent keep buying new information as his existing information becomes out of date.
I show how his demand for information depends on whether he is myopic or forward-looking, and on the [Gaussian process](https://en.wikipedia.org/wiki/Gaussian_process) defining how the state evolves.

The paper stems from my research with [Anirudh Sankar](https://sites.google.com/view/anirudh-sankar) on how people learn across contexts.
Suppose I ask you for advice, and you say "X worked for me."
But will X work for me?
We're different people with different contexts (e.g., physical and social positions).
Our outcomes might be different.

Imagine there's a function mapping contexts to outcomes.
If I know this function then I can invert it, taking information generated in your context and porting it into mine.
But if I don't know the function then I can't invert it, which makes learning from you hard.
Anirudh and my research formalizes this idea: the more I know about the function mapping contexts to outcomes, the easier it is to learn across contexts.

Mathematically, learning across contexts is like learning across time: the function mapping contexts to outcomes is like a stochastic process mapping times to states.
But contexts, unlike time, can have many dimensions and may not be [totally orderable](https://en.wikipedia.org/wiki/Total_order).
Contexts are more general, and so models of learning across them can lead to more general insights.
I hope to share some of those insights in the future.

*Update (2025-09-16): The future has arrived---see [here](/blog/value-conceptual-knowledge/).*
