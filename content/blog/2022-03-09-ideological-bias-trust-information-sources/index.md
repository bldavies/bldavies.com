---
title: Ideological bias and trust in information sources
topics: [economics, media, politics]
---

If people were [Bayesian](https://en.wikipedia.org/wiki/Bayesian_inference), then giving them more information would help them learn the truth and reach consensus.
But most people *aren't* Bayesian.
They can have, e.g., [confirmation bias](https://en.wikipedia.org/wiki/Confirmation_bias) or limited memory.
These cognitive "errors" can lead people with access to lots of information to disagree.

[Gentzkow, Wong and Zhang (2021)](https://web.stanford.edu/~gentzkow/research/trust.pdf) show that such errors are not necessary for disagreement.
The authors consider Bayesian agents with access to some information sources.
Agents don't know which sources they can trust.
They learn to trust sources that are consistent with their personal experiences.
Variation in experiences can lead agents to disagree, even as the number of sources grows.

In Gentzkow et al.'s model, sources send [noisy signals](/blog/learning-noisy-signals) about many "states."
States represent objective facts about different issues, such as mask effectiveness or the extent of global warming.
States vary in their "ideological valence:" how favorable they are to liberals or conservatives.
Sources vary in their accuracy (i.e., signals' correlation with states) and ideological bias (i.e., signals' correlation with ideological valences).
Agents want to learn sources' accuracies and biases, which are constant across issues.

Agents learn by comparing signals to their personal experience, such as friends' disease outcomes or local weather events.
Experiences, like sources, vary in their accuracy and ideological bias (due to, e.g., [choosing like-minded friends](/blog/polarized-beliefs-social-networks/)).
However, agents believe their experience is *unbiased*.
This belief gives each agent a baseline against which to compare signals.
Different agents have different baselines, leading to different inferences from the signals they receive.

The authors show that biased agents prefer like-minded sources.
When comparing sources with the same accuracy but opposite biases, agents think the source sharing their bias is more accurate.
Agents also under-estimate the bias of like-minded sources and think unbiased sources are opposite-minded.
These patterns stem from agents' dogmatic beliefs that their experiences are unbiased.
Agents learn the truth if and only if their experiences *really are* unbiased.

The authors also show that biases in experiences can lead to disagreements about states.
Suppose the bias in two agents' experiences have equal magnitudes but opposite signs.
As the magnitude grows, the agents become more likely to disagree.
Having more sources doesn't always help.
It can actually lead to *more* disagreement because agents can combine sources to construct a maximally like-minded composite.

This demand for like-minded sources affects media market outcomes.
People devote their attention to media outlets they trust.
Outlets profit from capturing peoples' attention.
The authors show that monopolists maximize profit by offering accurate and unbiased information, whereas competing outlets [differentiate](https://en.wikipedia.org/wiki/Product_differentiation) by targeting biased audiences.

All of these results rely on some technical assumptions.
For example, agents only see normally distributed data.
This makes the math (relatively) easy but limits generality.
I don't mind those assumptions because they lead to clear, testable hypotheses about why people disagree.
What remains is to test them.
