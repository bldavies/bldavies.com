---
title: Hypothesis tests and Bayesian reasoning
topics: [statistics]
---

Most empirical research relies on [hypothesis testing](https://en.wikipedia.org/wiki/Statistical_hypothesis_testing).
We form null and alternative hypotheses (e.g., a regression coefficient equals zero or doesn't), collect some data, and reject the null if it implies those data are rare enough.
How rare is "enough" depends on the context, but a common rule is to reject the null if the [p-value](https://en.wikipedia.org/wiki/P-value)---that is, the probability of observing the same or rarer data *given the null is true*---is smaller than 0.05.
However, this rule can lead to very different conclusions than [Bayesian](https://en.wikipedia.org/wiki/Bayes%27_theorem) reasoning.

For example, suppose I'm the government trying to collect taxes.
I know 1% of taxpayers cheat (e.g., by under-reporting their income), so I hire an auditor to detect cheating.
The auditor makes occasional mistakes: they incorrectly detect cheating among 2% of non-cheaters.
But the auditor never fails to detect cheating when it happens.

Suppose the auditor tells me Joe cheated on his taxes.
Should I prosecute him for fraud?
Letting "Joe is innocent" be the null hypothesis and "Joe is guilty" be the alternative, the p-value of the auditor's message is simply their [false positive](https://en.wikipedia.org/wiki/False_positives_and_false_negatives) rate: 0.02.
This p-value is smaller than the 0.05 "critical value" below which I reject nulls, so I take the auditor's message as strong evidence of guilt.

Now consider a random sample of a thousand taxpayers.
The auditor accuses all ten cheaters in this sample of cheating.
But the auditor also accuses 20 of the 990 *non-cheaters* of cheating.
So only one in three accusees actually cheated---if I thought everyone like Joe was guilty, I would be wrong two thirds of the time!
That's hardly evidence of guilt "beyond reasonable doubt."

What's going on?
Why does the hypothesis test suggest Joe is guilty, when simply counting true and false accusations suggests he's innocent?

The suggestions differ because they are based on different probabilities.
The hypothesis test uses the probability that the auditor detects Joe cheating *given he is innocent*: 0.02.
But the counting argument uses the probability that Joe is innocent *given the auditor detects him cheating*: 0.66.
(Notice the swap in what comes before and after "given.")

But which probability should I use?
Should I follow my hypothesis test and prosecute Joe, or should I follow my counting argument and let him walk free?

One problem with the hypothesis test is that it ignores the [base rate](https://en.wikipedia.org/wiki/Base_rate): most taxpayers are innocent.
Sure, false accusations are rare, but there are lots of non-cheaters to falsely accuse!
These false accusations crowd out the true accusations, which are relatively rare because cheating is rare.

In contrast, counting accusees effectively takes the base rate as a [prior belief](https://en.wikipedia.org/wiki/Prior_probability) in Joe's innocence and updates this belief in response to the evidence provided by the auditor.
My belief updates a lot---from 0.99 to 0.66---but not enough to indict Joe beyond reasonable doubt.
The auditor's [signal is too noisy](/blog/learning-noisy-signals/) to establish guilt on its own.
(One way to combat this noise is to hire a *second* auditor, identical to but independent of the first.
If *both* auditors told me Joe cheated then my belief in his innocence would fall to 0.04, which would be much stronger grounds for prosecution.)

However, things can change if my prior belief is incorrect.
For example, suppose I think 10% of taxpayers cheat, ten times as many as *actually* cheat.
When the auditor tells me Joe cheated, [Bayes' formula](https://en.wikipedia.org/wiki/Bayes%27_theorem) tells me to update my belief in Joe's innocence from 0.9 to 0.15, which is plausible grounds for prosecution.
Now accusee-counting *agrees* with my hypothesis test, even though my evidence didn't change.
This sensitivity to prior beliefs---which may be incorrect, or may not even exist---is a common criticism of [Bayesian inference](https://en.wikipedia.org/wiki/Bayesian_inference).

But I like the Bayesian approach.
It forces me to remember that data are noisy: the auditor makes mistakes, as do the tools I use to observe and catch data in the wild.
This noisiness affects how I should interpret data as evidence of how the world works.
Bayesian reasoning also forces me to specify my priors---[they're probably wrong](/blog/lessons-dave-mare/#have-weak-priors-and-strong-nulls), but specifying them encourages me to think about *why* they're wrong (and, hopefully, work to make them *less* wrong).

I won't go decrying hypothesis tests any time soon: they're well-established as the dominant tool in empirical economics, not least because they're easier to describe and interpret than Bayesian arguments.
But I'll try to "be more Bayesian" generally: to think more carefully about my beliefs, about evidence, and how my beliefs respond to evidence.

---

*Thanks to Anirudh Sankar for reading a draft version of this post.
It was inspired by the tenth chapter of Jordan Ellenberg's [*How Not to Be Wrong*](http://www.jordanellenberg.com/book/how-not-to-be-wrong/).*
