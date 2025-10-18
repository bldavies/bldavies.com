---
title: Research incentives and artificial intelligence
topics: [economics, research, technology]
summary: I discuss Carnehl and Schneider (2025) and Gans (2025), who study the evolution of knowledge and the impact of AI.
---

In one of my favorite papers (summarized [here](/blog/research-incentives-evolution-knowledge/)), [Carnehl and Schneider (2025)](https://doi.org/10.3982/ECTA22144) study the choice between two types of research:

1. research that "deepens" our knowledge by filling gaps between answered questions;
2. research that "expands" our knowledge by answering questions beyond the frontier.

[Gans (2025)](https://www.nber.org/papers/w33566) considers how this choice is impacted by artificial intelligence.
He argues that AI helps researchers fill gaps:

> "AI tools ... excel at interpolation, precisely answering queries located within a defined operational range around known data points.
> ...
> [Their] primary strength [is the] efficient recombination of existing information, rather than extending the domain of knowledge itself."

How might we [model](/blog/what-economic-model/) the impact of AI on researchers' choices?
One approach is to assume AI lowers the cost of research that deepens.
This has two effects:
a [substitution effect](https://en.wikipedia.org/wiki/Substitution_effect) that leads to more research that deepens, and
an [income effect](https://en.wikipedia.org/wiki/Consumer_choice#Income_effect) that leads to more research overall.
The net impact on researchers' choices---i.e., how much they try to fill gaps vis-à-vis push boundaries---depends on the two effects' relative sizes.

Gans takes a different modeling approach.
He assumes that when researchers answer a question, AI answers similar questions for free.
What counts as "similar" depends on AI's operational range.
Gans treats this range as an exogenous parameter.
He offers an example from biology:

> "With AI tools like [AlphaFold](https://en.wikipedia.org/wiki/AlphaFold), if we know the structures of two somewhat related proteins (separated by a [sufficiently small distance] in the space of amino acid sequences), the AI can accurately predict the structure of any protein between them without requiring additional experimental data. However, for proteins that are too distant from known structures (beyond the frontier), the AI’s predictions become unreliable, and new experiments are needed."

Carnehl and Schneider's model is the special case of Gans' in which AI has an operational range of zero.
Extending this range changes researchers' incentives and leads to different choices.

For example, in Carnehl and Schneider's model, researchers tend to do incremental work that pushes the frontier in small steps.
This is because small steps are less risky than large steps.
The step size depends on researchers' private incentives, which change over time as the set of answered questions changes.

In contrast, in Gans' model, researchers always take steps equal to AI's operational range.
This makes the most of AI's ability to fill gaps.
It means they push the frontier at a steady pace, which gets faster as AI improves.

This difference in dynamics leads to different policy recommendations.
Carnehl and Schneider recommend subsidies for "moonshots:" research on questions more novel than is privately optimal.
These subsidies correct the market failure that arises from researchers not internalizing the positive externalities their work has on future researchers.

Gans shows that AI makes moonshots more valuable.
He also recommends another policy: make AI better by raising its operational range.
This allows researchers to create knowledge at a faster pace.
It empowers them to pursue their comparative advantage---to ask novel questions---rather than do the incremental work at which AI excels.

One thing missing from Carnehl, Schneider, and Gans' models is competition among researchers.[^bing]
The authors assume researchers work one-at-a-time.
In reality, researchers work many-at-a-time.
They fight for [priority](https://en.wikipedia.org/wiki/Scientific_priority) by answering questions no-one else can.
This discourages them from filling obvious gaps.
AI discourages them even more: if anyone can use it to fill gaps for free, then researchers can't bank on being the first ones to do so.
They have to keep pushing the frontier.
So AI could boost the pace of innovation more than Gans suggests!

[^bing]: Thanks to [Bing Liu](https://bingliu723.github.io) for pointing this out.
