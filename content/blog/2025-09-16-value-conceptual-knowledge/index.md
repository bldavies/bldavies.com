---
title: The value of conceptual knowledge
topics: [economics, statistics]
---

[Anirudh](https://sites.google.com/view/anirudh-sankar) and I have [a new paper][arxiv].
It explores the role that conceptual knowledge plays in human learning and decision-making.

## A motivating example

Suppose a farmer wants to learn which fertilizers are most effective.
He views them as [black boxes](https://en.wikipedia.org/wiki/Black_box): he knows *that* they help plants grow, but doesn't know *why*.
He doesn't know how fertilizers' effects relate and can't extrapolate one from another.
So when he tries different fertilizers to learn their effects, he has to try them one at a time.

Now suppose the farmer knows about nitrogen, a nutrient that helps plants grow.
This tells him how fertilizers' effects relate: they share a common "nitrogen component."
It allows him to extrapolate one fertilizer's effect from another's.
So when he tries different fertilizers to learn their effects, he can combine them to isolate the nitrogen component.
This is better than trying each fertilizer separately: it allows him to learn their effects from one trial rather than many.

The farmer's knowledge of nitrogen is conceptual: it's in his mind, rather than his data.
Nonetheless it allows him to collect better data.
*How much better*?
That's the question [our paper][arxiv] answers!

## What we do

We generalize the farming example as follows:
Imagine you want to learn some unknown "states" (e.g., fertilizer effects).
Conceptual knowledge tells you how the states relate.
It allows you to represent them as combinations of structural "features" (e.g., nutrient effects).
If you know about these features, then you can collect data on them; if you don't, then you have to collect data on the states instead.

It's better to collect data on features because it makes use of states' structural relationships.
*How much better* is a quantity we define in our paper.
We call it "the value of conceptual knowledge."
It equals the welfare gain from knowing how states relate and using that knowledge to collect better data.

[Our paper][arxiv] offers three main insights:

1. **Conceptual knowledge is more valuable when states are more "reducible."**
   If only one feature matters, then collecting data on it helps you learn about many states at once.
   But if many features matter, then you can't do much better than learn about each state on its own.
2. **The value of conceptual knowledge depends on how much data you can collect.**
   If you can't collect much, then it's valuable to know which features matter most.
   But if you can collect lots of data, then you don't need to know which features matter because you can "let the data speak."
3. **People with deeper knowledge are better off and need less data.**
   The more you know about which features matter, the more you can learn from a given amount of data, and so the less you need to reach a given welfare goal.

## Implications

Our paper highlights how humans and machines differ.
Humans know how to "ask the right questions" and can learn a lot from limited data.
In contrast, machines rely on pattern recognition and need lots of data.
So the less data are available, the better it is to have humans collect and interpret them.

Our paper also speaks to interventions that give people data.
They won't work if people don't have the conceptual tools to interpret data.
So we should give people those tools too.
Anirudh and I did that with farmers in Uganda (see [here](https://drive.google.com/file/d/11ZYBbbUYx-K0eJmqU4_jaIJIe7F8DdM0/view)): we gave some both knowledge and data, and others data only.
Farmers with deeper knowledge made more profitable decisions and more accurate predictions.

Finally, our paper positions knowledge as an economic good.
It is valuable but scarce, just like data.
So we can study the trade-off between knowledge and data using the same tools economists use to study other goods.
Are knowledge and data complements or substitutes?
Are they normal or inferior?
How do their values depend on how states relate?
These are questions [our paper][arxiv] helps answer.

[arxiv]: https://arxiv.org/abs/2509.09170
