---
title: Communicating science
topics: [economics, research, statistics]
---

Science is hard, and communicating it to a broad audience is even harder.
I don't envy Anthony Fauci or his colleagues, who must summarize the science on vaccines to a range of parties with a range of prior beliefs.

What does it mean to communicate science "optimally?"
[Andrews and Shapiro (2021)](https://doi.org/10.3982/ECTA18155) offer some guidance.
They consider an analyst who sends an audience a report about some data.
Audience members vary in their beliefs and objectives, and so vary in their reactions to a given report.
The analyst chooses a report that maximizes audience members' welfare given their reactions.

Andrews and Shapiro compare two models:

1. In the "communication model," the analyst provides information and lets audience members take their preferred decision *given* that information.
2. In the "decision model," the analyst takes a decision on audience members' behalf.

These two models generally have different optimal reporting rules.
For example, suppose the analyst has experimental data on a new drug.
Their audience is a range of governments, who want to subsidize the drug if its effect is positive and tax it if its effect is negative.
Everyone knows the true effect is non-negative, so taxing is never optimal.
But the analyst may estimate a negative effect due to sampling error in the experiment.
Under the decision model, the analyst optimally censors negative estimates because imposing a tax is worse than doing nothing.
Conversely, under the communication model, censoring is *never* optimal because it throws away information about effect size.

In this example, the analyst optimally reports a [sufficient statistic](https://en.wikipedia.org/wiki/Sufficient_statistic) for the effect size (e.g., the mean outcomes within the experiment's treatment and control groups).
In fact, reporting a sufficient statistic is *always* optimal under the communication model.

The communication and decision models can even have different [admissible](https://en.wikipedia.org/wiki/Admissible_decision_rule) reporting rules.
For example, suppose the analyst has data on (true) treatment effects for many drugs.
Their audience is a range of physicians, who want to give the best drug to their patients.
Every physician believes that any drug is better than none (e.g., because patients can't self-prescribe).
The analyst considers two reporting rules:

1. Choose randomly among the drugs with the largest effect.
2. If all drugs have the same effect then do nothing; otherwise, use rule 1.

Every physician prefers *some* drug to none, so doing nothing is never optimal.
Consequently, the first rule always dominates the second under the decision model.
But physicians can reconstruct the first rule from the second, so the second rule is (weakly) more informative.
Consequently, it always dominates the first rule under the communication model.

Andrews and Shapiro discuss more features of the two models, such as what happens when the analyst puts different weights on different audience members' welfare.
The authors also discuss implications of their analysis for research practice, such as for reporting estimates of structural economic models.

One thing Andrews and Shapiro *don't* discuss is what happens when the audience is [boundedly rational](https://en.wikipedia.org/wiki/Bounded_rationality).
Audience members may find it hard to process information---hence getting the analyst to process it for them---due to cognitive or emotional costs.
Such costs make the audience [rationally inattentive](https://en.wikipedia.org/wiki/Rational_inattention).
[Bloedel and Segal (2021)](https://scholar.google.com/scholar?cluster=10141712202393797072) study optimal communication to a rationally inattentive audience, but use the language of Bayesian persuasion ([Kamenica and Gentzkow, 2011](https://doi.org/10.1257/aer.101.6.2590)) rather than statistical decision theory.

Another missing discussion is what happens when the audience don't trust the analyst.
Suppose some audience members believe the analyst lies or suppresses truths for conspiratorial reasons.
How should the analyst respond to this belief?
How should they trade off the cognitive costs induced by providing information with the conspiracy theories induced by suppressing it?
This trade-off is both deliciously complicated and faced by real-world science communicators.
Again, I do not envy them!
