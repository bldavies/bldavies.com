---
title: Learning from opinions
topics: [economics, statistics]
summary: Summary of "Communication with Unknown Perspectives" by Sethi and Yildiz (2016)
---

We often use others' opinions to guide our choices.
For example, we use movie and Yelp reviews to decide what to watch and where to eat.
But opinions can be hard to interpret because they depend on objective facts (e.g., movie/food quality) and subjective perspectives (e.g., reviewers' tastes).
So, when seeking opinions, we face a trade-off between

1. "well-informed" sources who know a lot and
2. "well-understood" sources with known perspectives.

[Sethi and Yildiz (2016)](https://doi.org/10.3982/ECTA13320) study this trade-off and its consequences.
They consider a group of people who receive [noisy signals](/blog/learning-noisy-signals/) about a sequence of states.
These people form posterior beliefs ("opinions") about each state based on their signal precisions ("expertise") and prior beliefs ("perspectives").
Expertise is public, and varies across people and states.
Perspectives are private, and vary across people but not states.
Everyone observes their own opinion and the opinion of a chosen "target."
They always choose the target whose opinion reveals the most information about the current state.

Initially, no-one knows anyone else's perspective, so everyone chooses the target with the most expertise (i.e., the most precise signal).
But people learn others' perspectives over time by comparing the signals they receive to the opinions they observe.
Eventually, everyone attaches to a set of "long-run experts" and never considers opinions outside that set, even if those opinions are better informed.

This set of long-run experts can vary across people.
To see why, suppose Alice and Bob observe Charlie's opinion about a given state.
Alice and Charlie receive precise signals about that state, but Bob doesn't.
Alice knows that her opinion can only differ from Charlie's if they have different perspectives.
In contrast, Bob can't tell if his opinion differs from Charlie's because they have different perspectives or because Bob's signal is imprecise.
So Alice learns more about Charlie's perspective than Bob does.
She's more likely to include Charlie in her set of long-run experts.

Sethi and Yildiz's model explains why people gravitate to like-minded opinion sources.
We learn more about the perspectives of people who know about the same things, making us more likely to attach to them.
This contrasts with the [trust](/blog/ideological-bias-trust-information-sources/)- and [persuasion](/blog/persuading-anecdotes/)-based explanations discussed in previous posts.
It leads people to ask experts for opinions on topics beyond their expertise.
It may also lead people to [befriend fellow ideologues](/blog/truth-seekers-ideologues/) who see the world the same (possibly incorrect) way.
