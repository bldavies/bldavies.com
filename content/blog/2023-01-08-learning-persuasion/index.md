---
title: Learning and persuasion
topics: [economics, statistics]
summary: Summary of "Learning from like-minded people" by Meng (2021).
---

People talk for many reasons.
One is to learn: to collect information that helps us make better choices.
Another is to [persuade](/blog/persuading-anecdotes): to convince others to make choices we think are best.

[Meng (2021)](https://doi.org/10.1016/j.geb.2021.01.001) shows how wanting to learn and persuade can lead to [homophily](https://en.wikipedia.org/wiki/Homophily).
He presents a model in which people choose conversation partners before taking actions.
Everyone wants these actions to match an unknown binary state.
But people have different prior beliefs about the state.
They update their beliefs after receiving (i) a [noisy signal](/blog/learning-noisy-signals/) from nature and (ii) a message from their partner.
Priors are public, signals are private, and messages are [designed to be persuasive](https://doi.org/10.1257/aer.101.6.2590).

Meng studies the [matchings](/blog/stable-matchings/) that arise in this setting.
A matching is "stable" if it has no "blocking pairs:" people who want to be partners but aren't.
It is "[assortative](/blog/assortative-mixing/)" if all partners are "like-minded:" their priors are both close to zero or both close to one.

Every assortative matching is stable.
To see why, suppose Alice and Bob are not like-minded.
Alice will only partner with Bob if it's easier to persuade him than be persuaded by him.
But Bob will only partner with Alice if it's easier to persuade her than be persuaded by her.
These two conditions can't hold at the same time, so Alice and Bob can't form a blocking pair.

Likewise, in Meng's model, every stable matching is assortative.
This is especially true if people care more about learning than persuading.
Like-minded partners send truthful messages because they don't need to persuade each other.
But non-like-minded partners send distorted messages hoping to persuade each other.
These distortions make at least one person worse off than they would be if they had a like-minded partner who told them the truth.

Meng then considers a social planner who can choose matchings but not messages.
This planner wants to maximize the sum of everyone's expected payoffs under their priors.
They choose an assortative matching only when the distribution of priors is symmetric.
Otherwise, they choose a matching in which people with extreme priors have non-like-minded partners with moderate priors.
This is because extremists gain more than moderates lose.
It suggests that sorting is socially bad.

Finally, Meng extends his model to allow stable matchings that are *not* assortative.
This can happen when signals or actions are not binary.
He leaves open the extension to settings in which people have more than one partner.
[Jann and Schottmüller (2021)](/blog/echo-chambers-useful/) consider a version of that setting.
But they reach a different normative conclusion than Meng: sorting can be good because it stops people from sending distorted messages.
