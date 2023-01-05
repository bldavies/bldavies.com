---
title: Persuading with anecdotes
topics: [economics, statistics]
---

My [previous post](/blog/ideological-bias-trust-information-sources/) explained why rational people can prefer like-minded information sources.
This preference leads media outlets to compete by targeting biased audiences.
Such targeting can take (at least) two forms:

1. presenting content in a way some people like and others don't;
2. only sharing content that some people like and others don't.

[Haghtalab et al. (2021)](https://www.nber.org/papers/w28661) study the second form.
They consider a pair of Bayesian agents called Sender (he) and Receiver (she).
Both agents take actions (e.g., get vaccinated) based on their beliefs about an unknown state (e.g., whether vaccines are effective) and their "moral stance."
Sender observes some noisy signals about the state before taking his action.
He sends one of those signals to Receiver before she takes her action.
Sender's "communication scheme" determines which signal he sends.
He chooses this scheme knowing his and Receiver's moral stances, but before observing any signals.

Sender wants Receiver to take the same action as him.
He chooses the scheme that minimizes the mean distance (across signal realizations) between his and Receiver's actions.
This distance has three components:

1. A "signalling loss" from sending one signal rather than many;
2. A "persuasion temptation" from wanting Receiver to take the same action;
3. An unavoidable loss from differences in moral stances.

If Receiver knows the communication scheme then Sender just minimizes the signalling loss.
This is because Receiver can "undo" any bias in the scheme, so persuasion is impossible.
But if Receiver *doesn't* know the scheme then Sender trades off the signalling loss and the persuasion temptation.
This makes both agents worse off because the signal sent is less informative.

Suppose the signal distribution is "well-behaved" (e.g., single-peaked) and Receiver knows the communication scheme.
If Sender observes enough signals then he always prefers unbiased schemes.
Intuitively, Sender wants to send all the signals he observes but can only send one.
He sends the "most representative" signal: the one closest to the mean.
But this logic breaks down when Sender observes too few signals.
In that case, the mean signal is noisy and extreme signals can be more informative.
This can make Receiver prefer biased schemes.

Now suppose Receiver *doesn't* know the communication scheme.
Then Sender chooses more biased schemes when he observes more signals.
He does so because of his persuasion temptation.
Again, this makes both agents worse off.
So Receiver prefers when Sender shares her moral stance because then their incentives are aligned.

This preference for like-mindedness also depends on the number and distribution of signals Sender observes.
For example, suppose Receiver chooses between 

1. an expert with many signals but a different moral stance, and 
2. a layperson with one signal but the same moral stance.

Receiver prefers the layperson when the signal distribution is [thick-tailed](https://en.wikipedia.org/wiki/Fat-tailed_distribution).
This is because the expert observes more signals "in the tail," so they send a more extreme (and, thus, less informative) signal due to their persuasion temptation.

It may seem restrictive that Sender shares a raw signal rather than, say, his posterior estimate of the state.
But such sharing reflects how real people talk to each other.
Real people don't trade summary statistics on vaccination outcomes.
Instead, they trade anecdotes like "I felt tired and achy after my booster shot."
News outlets do the same: they typically report on individual events rather than aggregate patterns.
(When was the last time you saw a [base rate](https://en.wikipedia.org/wiki/Base_rate) in the news?)
These anecdotes in conversation and events in the news correspond to signals in the authors' model.
