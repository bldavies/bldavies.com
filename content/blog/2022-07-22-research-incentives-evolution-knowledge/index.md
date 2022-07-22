---
title: Research incentives and the evolution of knowledge
topics: [economics, research]
summary: Summary of Carnehl and Schneider (2022)
---

Research is a cumulative process.
New discoveries build on previous discoveries: researchers "stand on the shoulders of giants."
[Carnehl and Schneider (2022)][paper] embed this idea in a model of how knowledge evolves.
In their model, knowledge is the set of questions with known answers and research is the process of finding answers.
The model has three main features:

1. Existing knowledge determines the benefits and costs of research.
2. Answering a question sheds light on related questions.
3. Researchers are free to choose which questions to ask and how intensely to seek answers.

The authors first discuss the social benefit of research.
They think of society as an agent who makes policy choices.
These choices appear as questions:
How much should we tax companies?
How much should we subsidize healthcare?
Society knows the answer to some questions but is uncertain about the answer to others.
This uncertainty means society has to guess which policies are best.
Research is beneficial insofar as it leads to better guesses.
It does so through two channels:

1. It reveals the answer to the researched questions.
2. It lowers the uncertainty around answers to other questions.

Society is more certain about answers to questions that are "closer" to existing knowledge.
Intuitively, knowing how much to tax companies tells you more about taxing households than about building rockets.
Research removes more uncertainty for questions closer to those researched.
Carnehl and Schneider measure the benefit of research as the total amount of uncertainty it removes.

Next, the authors compare the benefits of research that "deepens" and "expands" knowledge.
They model questions as points on the real line and the "frontier" as the extremal points of existing knowledge.
Research on questions between these extremal points deepens knowledge; research on questions beyond the frontier expands knowledge.
The relative benefits of deepening and expanding depend on the gaps in existing knowledge.
Deepening is more beneficial when gaps are large.
This is because larger gaps leave more uncertainty to remove.
Splitting a large gap into smaller gaps removes more uncertainty than creating a new gap at the frontier.

Carnehl and Schneider then consider researchers' choices:
What questions do they ask?
How intensely do they seek answers?
These choices depend on the private benefits and costs of research.
The authors assume private benefits equal social benefits.
They also assume private costs rise with search intensity and existing uncertainty.
More intense searches are more likely to succeed.
But, for a given likelihood, more uncertain answers need wider searches.
Carnehl and Schneider characterize researchers' optimal choices in two dimensions:

1. "Novelty:" how far is the chosen question from existing knowledge?
2. "Output:" how likely is the research to succeed?

The relationship between novelty and output depends on whether the research expands or deepens knowledge.
If it expands knowledge, then novelty and output are substitutes: more novel research is always riskier.
If it deepens knowledge, then whether novelty and output are substitutes depends on the size of the gap being filled.
This dependence is intricate---see [the paper][paper] for details.

Finally, the authors use their model to study how researchers' choices affect how knowledge evolves.
Carnehl and Schneider's key insight is that short- and long-run choices differ.
Short-lived researchers choose questions that maximize private benefits less private costs.
But they don't consider the impact their choices have on future researchers' choices.
This impact arises from lowering the uncertainty for some questions but not others.
Long-lived researchers internalize the impact their choices today have on choices tomorrow.
The authors show that rewarding "moonshots"---research on questions more novel than myopically optimal---can raise the present value of future knowledge.

Overall, the paper is impressive.
Its introduction gives a clear summary of the main results.
The model is creative and crisp.
Like all [good models](/blog/judging-economic-models/), it focuses on one issue---the cumulative nature of research---and abstracts from others---e.g., the [priority system](https://en.wikipedia.org/wiki/Scientific_priority) and career concerns.
The paper is also a rare theoretical contribution to the (mostly empirical) literature on the economics of science.

Carnehl and Schneider's model could be extended to acknowledge the [replication crisis](https://en.wikipedia.org/wiki/Replication_crisis).
Their model assumes all research findings are certain and true.
But the crisis exists because some findings are *false*.
We discover false findings via replication studies.
These studies have *zero* novelty, but can still be beneficial: they remove uncertainty around findings we think are true.

Allowing for uncertain findings would then help us think about replication incentives.
Some economists argue they need to be stronger---see, e.g., [Zimmerman (2015)](https://doi.org/10.20955/wp.2015.016).
But whether to incentivize replication studies depends on the benefits they offer relative to original research.
If society is confident a finding is true, then replicating it may be less beneficial than producing novel findings.

[paper]: https://arxiv.org/abs/2102.13434
