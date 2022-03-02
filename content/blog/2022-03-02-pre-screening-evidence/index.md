---
title: Pre-screening evidence
topics: [economics, statistics]
---

[Cheng and Hsiaw (2022)](https://doi.org/10.1016/j.jet.2021.105401) study an agent who wants to learn about a binary state (e.g., whether a vaccine is safe).
An information source (e.g., Fauci or a Twitter thread) sends [noisy signals](/blog/learning-noisy-signals/) about the state.
But the agent doesn't know whether the source is "credible."
They have to infer credibility from the signals received.

The authors compare two types of agents: Bayesians and "pre-screeners."
Both types respond to new evidence in two steps:

1. Update beliefs about whether the source is credible.
2. Update beliefs about the state, weighing the evidence by its credibility.

The two types differ in the second step.
Whereas Bayesians use their *prior* beliefs about credibility, pre-screeners use their *updated* beliefs.
Pre-screeners "double-dip" the evidence: once to evaluate its credibility, and again to evaluate its likelihood *given* its credibility.
Bayesians never double-dip: they evaluate credibility and likelihood independently.

Bayesians and pre-screeners can have different responses to the same evidence.
For example, suppose an agent thinks (i) they have COVID-19 and (ii) their testing procedure is accurate (i.e., credible).
The procedure  *is* accurate, but they actually *don't* have the virus.
They take a test; it returns "negative."
Surprised, they take another test; "negative."
They keep taking tests; the tests keep returning "negative."

Suppose the agent is Bayesian.
The first result makes them think the testing procedure is inaccurate.
But they evaluate the first result using their *prior* belief about accuracy, which is that the procedure *is* accurate.
Consequently, they weaken their belief in having the virus.
This makes the second result less surprising than the first.
That result weakens the agent's belief further.
Eventually, the agent stops being surprised: they gradually learn the procedure is accurate and they don't have the virus.

Now suppose the agent pre-screens.
The first result makes them think the testing procedure is inaccurate.
They evaluate the first result using their *updated* belief about accuracy.
Consequently, they *strengthen* their belief in having the virus.
This makes the second result less surprising than the first: the agent expects an inaccurate result and, from their perspective, gets one.
They strengthen their belief further.
Eventually, the agent wonders, "if the procedure was inaccurate then it wouldn't keep returning the same result.
Perhaps it *is* accurate after all?"
The agent then evaluates *all* the results as though the procedure is accurate, weakening their belief in having the virus sharply.
Suddenly, the agent learns the procedure is accurate and they don't have the virus.

The Bayesian and pre-screener reach the same conclusion in different ways.
The Bayesian learns gradually because they evaluate each result independently.
The pre-screener learns suddenly because they evaluate *the entire history of results* as though they knew the testing procedure was accurate all along.
Cheng and Hsiaw show generally that, so long as signals tend to agree with the state, pre-screeners learn the truth eventually if Bayesians do too.

But "eventually" can mean "after an unhelpfully long time."
In the meantime, pre-screeners and Bayesians can disagree about the state.
They do so because they disagree about credibility.
Pre-screeners either "over-trust" or "under-trust" the source relative to Bayesians.
Over-trust leads pre-screeners to think the state favored by the evidence is more likely than Bayesians think.
Under-trust has the opposite effect.

Cheng and Hsiaw call this pattern "correlated disagreement:" pre-screeners' beliefs tend to agree with whether they think sources supporting those beliefs are credible.
For example, imagine collecting peoples' opinions on (i) whether vaccines are safe and (ii) the credibility of sources saying vaccines are safe.
If people pre-screen then their opinions on (i) and (ii) should be positively correlated.

Correlated disagreement is one testable prediction of Cheng and Hsiaw's model.
Another prediction is "first impression bias:" pre-screeners are more likely to think a source is credible if its first few signals agree with each other.
Bayesians have no such bias because their final beliefs don't depend on which signals they see first.

A third prediction concerns how pre-screeners react to new evidence.
They over-react if the evidence confirms their priors and think the source is credible.
They under-react if the evidence contradicts their priors *or* think the source is *not* credible.

Cheng and Hsiaw also discuss how such reactions influence asset prices.
Disagreements over credibility (e.g., of financial reports) lead to disagreements over fundamental values.
These disagreements lead to speculation: people buy assets hoping to cash-in on others' over-confidence.
Speculation raises asset prices.
Eventually, disagreements over credibility disappear, investors wise up, and prices come crashing down.

Cheng and Hsiaw treat credibility as something the agent *learns*.
Alternatively, one could treat credibility as something the agent *chooses*.
[Gentzkow, Wong and Zhang (2021)](https://web.stanford.edu/~gentzkow/research/trust.pdf) explore this alternative---I'll discuss their findings in my next post.
