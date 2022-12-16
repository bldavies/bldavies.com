---
title: Echo chambers can be useful
topics: [economics]
summary: Summary of Jann and Schottmüller (2021)
---

Talking to lots of people who know different things helps us learn.
Yet many of us sort into [echo chambers](https://en.wikipedia.org/wiki/Echo_chamber_%28media%29), only talking to a few like-minded people.
Doesn't this hinder learning?

[Jann and Schottmüller (2021)](https://scholar.google.com/scholar?cluster=15025907096771476263) answer: "not always."
Different people know *and want* different things.
These differences give us [persuasion temptations](/blog/communicating-anecdotes): we tell selective stories to influence others' behavior.
We don't share everything we know.
Sorting into echo chambers removes our persuasion temptations.
This leads to more sharing and learning.

The authors formalize this idea as follows:
Each agent has a binary [bit](https://en.wikipedia.org/wiki/Bit) of information.
Summing these bits gives the "state."
Agents take actions based on (i) their individual biases and (ii) their beliefs about the state.
They want other agents to take similar actions.
Biases are [common knowledge](https://en.wikipedia.org/wiki/Common_knowledge_%28logic%29).

Agents learn about the state by talking to each other.
But before they talk, agents sort into "rooms."
Agents only talk to people in their room.
They choose what to say based on how it influences their roommates' actions.
They either

1. share their bit (i.e., tell the truth),
2. share one minus their bit (i.e., lie), or
3. share a zero or one randomly.

Agents can "babble" by sharing a zero or one independently of their bit.
For example, they could flip a coin and share a one if it lands on heads.
Babbling is uninformative.

Jann and Schottmüller first study the [most informative equilibrium](https://en.wikipedia.org/wiki/Cheap_talk#Theorem) of the bit-sharing game played in each room.
In this equilibrium, everyone tells the truth or babbles.
Agents close to the mean bias among their roommates tell the truth.
Agents far from that mean babble.

The authors then study how agents choose rooms.
These choices anticipate how agents talk in each room.
In equilibrium, no agent wants to change rooms on their own.
This equilibrium is "welfare-optimal" if it leads to more truth-telling than any other equilibrium.

Whether the equilibrium room choices are welfare-optimal depends on agents' biases.
For example, suppose agents are polarized: their biases take one of two values with equal probability.
The difference between these values captures the level of polarization.
The authors show that

1. full segregation is welfare-optimal if polarization is *high* enough, and
2. full integration is welfare-optimal if polarization is *low* enough.

If polarization is high enough then having opposite-minded agents in the same room creates persuasion temptations.
These temptations lead to babbling in the most informative equilibrium.
Full segregation prevents babbling.
On the other hand, if polarization is *low* enough then no-one has persuasion temptations and so no-one babbles.
Then having everyone in the same room is welfare-optimal.

More polarization leads to less bit sharing in equilibrium.
This is because polarization creates persuasion temptations.
Segregation actually *removes* some of these temptations.
But it can't restore communication between agents who moved to different rooms.
Thus, polarization lowers welfare *despite* segregation, rather than *because* of it.
The authors summarize this point nicely:

> "One could think of echo chambers as society’s (decentralized) defense mechanism against polarization.
> Like fever in a human body, segregation occurs as the effect of an underlying problem, and its presence hence indicates that polarization is at problematic levels.
> Echo chambers, and segregation more generally, are hence a symptom of polarization.
> And just like artificially lowering fever, treating the symptom without addressing the cause can in fact exacerbate the situation.
> Reducing polarization will weakly improve welfare; reducing segregation may not."

The authors go on to study extensions of their model.
For example, they show that adding public information can [crowd out](https://en.wikipedia.org/wiki/Crowding_out_%28economics%29) incentives to tell the truth.
They also show that their model agrees with data from Twitter.
The authors suggest that social media platforms do more than connect people: they provide infrastructure for efficient segregation.

Jann and Schottmüller close by calling for more nuanced discussion of echo chambers:
Yes, they limit the diversity of whom we meet and talk to.
But

> "there is simply no use in meeting people with a very diverse set of opinions and very useful information, if there is no way to get that information out of them."
