---
title: Truth-seekers and ideologues
topics: [economics, networks]
summary: |
  If the truth doesn't matter then it's better to be an ideologue with ideological friends.
loadMathJax: yes
---

People learn socially: they get information from their friends.
Research on social learning takes as given that people want to learn the truth.[^failures]
This assumption motivates worries about online misinformation: if your friends see something wrong and share it with you, then you might believe it and be wrong too.

[^failures]: Indeed this assumption motivates the extensive literature on social learning "failures."
These failures arise from, e.g.,
unequal influence ([Acemoglu et al., 2011](https://doi.org/10.1093/restud/rdr004); [Golub and Jackson, 2010](https://doi.org/10.1257/mic.2.1.112)),
network structure ([Chandrasekhar et al., 2020](https://doi.org/10.3982/ECTA14407); [Dasaratha and He, 2021](https://doi.org/10.1145/3505156.3505163)),
herding ([Banerjee, 1992](https://doi.org/10.2307/2118364); [Bikhchandani et al., 1992](https://doi.org/10.1086/261849); [Smith and Sørensen, 2000](https://doi.org/10.1111/1468-0262.00113)),
conformity ([Mohseni and Williams, 2021](https://doi.org/10.1007/s10670-019-00167-6)),
misinformation ([Mostagir and Siderius, 2022](https://doi.org/10.1287/mnsc.2022.4340)),
and misinterpretation ([Frick et al., 2020](https://doi.org/10.3982/ECTA16981)).

But people share for more reasons than learning.
Sometimes we share to feel connected: to let each other know we're not alone in what we see.
We enjoy having [like-minded friends](/blog/polarized-beliefs-social-networks/) who have relatable experiences and validate ours.
But if we *only* talk to like-minded friends then it's hard to learn the truth because no one challenges our subjective experiences of objective reality.

Thus, when forming social networks, we face a trade-off.
We want friends with similar experiences because they help us feel connected.
But we also want friends with *different* experiences because they help us learn the truth.
How we resolve this trade-off depends on how much we care about the truth.
If we care a lot then we should choose friends with unbiased experiences;
if we don't care at all then we should choose friends who share our biases.

Here's a basic model to illustrate.
Imagine reality is chosen by a coin toss: Heads or Tails, each with probability 0.5.
There are two types of people:

1. "Truth-seekers" try to see the world for what it is.
  But they do so noisily: their experience matches reality with probability `\(a>0.5\)`.
2. "Ideologues" always see the world the same way: they always experience Heads.

These types represent two extremes:
truth-seekers have unbiased but noisy experiences, whereas ideologues have biased but precise experiences.
I choose a friend to help me win one of two games:

1. In the "learning" game, I win if my friend's experience matches reality.
2. In the "connecting" game, I win if my friend shares my experience.

I want to maximize my chance of winning the game we play.
But I don't know *which* we'll play until I've chosen my friend.
Which type should I choose?

If I'm a truth-seeker then I'm better off choosing a truth-seeking friend.[^truth-seeker-proof]
They're better in the learning game because they're more likely than ideologues to experience reality.
They're *also* better in the connecting game because we *both* tend to experience reality.
Our pursuit for truth makes our experiences correlated.
In contrast, ideologues' indifference to the truth makes their experience *uncorrelated* with mine.

[^truth-seeker-proof]: Choosing another truth-seeker makes me win the learning game with probability `\(a\)` and the connecting game with probability `\(a^2+(1-a)^2\)`.
Both of these probabilities exceed 0.5, the probability of winning either game if I choose an ideologue.

Things are different if I'm an ideologue.
Then my best choice depends on how likely I am to play each game.
Let `\(p\)` be the probability I play the learning game.
I'm better off choosing a truth-seeking friend if and only if `\(p\)` exceeds[^ideologue-proof]
`$$\overline{p}\equiv \frac{1}{2a}.$$`
Intuitively, I face a trade-off:
Truth-seekers are better in the learning game for the same reason as above.
But now *ideologues* are better in the connecting game because they always share my ideological experience.
This trade-off tilts in favor of truth-seekers as their accuracy `\(a\)` rises, lowering the threshold probability `\(\overline{p}\)`.

[^ideologue-proof]: If I'm an ideologue, then my *ex ante* chance of winning is `\(pa+0.5(1-p)\)` if I choose a truth-seeking friend and `\(0.5p+(1-p)\)` if I choose another ideologue.

Now suppose I can choose my *own* type.
Should I be a truth-seeker or an ideologue?
Again, my choice depends on the probability `\(p\)` that I play the learning game.
It turns out I'm better off seeking truth if and only if `\(p\)` exceeds another threshold `\(\underline{p}\)` that depends on `\(a\)`.[^welfare-proof]
This threshold has two interesting properties:

1. It's positive, so if `\(p\)` is small enough then I'm better off being an ideologue.
2. It's smaller than `\(\overline{p}\)`, so *if* I'm better off being an ideologue then I'm *also* better off choosing an ideologue as my friend.

Intuitively, if the truth doesn't matter then there's no point seeking it.
I might as well be an ideologue and choose ideological friends who always share my experience.

[^welfare-proof]: The exact probability is
`$$\underline{p}\equiv \frac{4a(1-a)}{2a-1+4a(1-a)}.$$`
It comes from comparing the truth-seeker's indirect objective
`$$pa+(1-p)(a^2+(1-a)^2)$$`
and the ideologue's indirect objective
`$$\begin{cases}pa+0.5(1-p)&\text{if}\ p\ge\overline{p}\\0.5p+(1-p)&\text{otherwise}.\end{cases}$$`
These functions coincide when `\(p\in\{\underline{p},1\}\)`.

One can extend this model to choosing many friends with a range of accuracies and biases.
Some people might be more truth-seeking than others.
Some people might have correlated experiences because they get information from the same [like-minded sources](/blog/ideological-bias-trust-information-sources/).
These correlations determine the "experience portfolio" my friends can provide.
But the goal of this portfolio---whether I want it to provide truth or connection---still depends on how much I care about learning the truth.
