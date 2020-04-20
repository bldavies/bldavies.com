---
title: Triadic closure at the NBER
topics: [networks]
linkSource: yes
---

[Fafchamps et al. (2010)](https://academic.oup.com/jeea/article-abstract/8/1/203/2295936) describe a model of team formation in which people learn about potential collaborators via existing collaborators.
These "referrals" provide information about potential collaborators' match qualities, allowing people to [screen](https://en.wikipedia.org/wiki/Screening_(economics)) each other and sort into more productive teams.
Fafchamps et al. argue, and demonstrate empirically, that this referral mechanism leads to more teams being formed among people who are closer in the collaboration network.

Fafchamps et al.'s referral model implies that triads in collaboration networks should tend to [close](https://en.wikipedia.org/wiki/Triadic_closure) over time; that is, people should tend to collaborate with others with whom they share common collaborators.
One way to measure such closure is via the (global) [clustering coefficient](https://en.wikipedia.org/wiki/Clustering_coefficient), which measures the rate at which pairs of nodes with a common neighbour are also adjacent.
For example, in the [NBER working paper co-authorship network](/blog/nber-co-authorships/), about 15% of the pairs of authors who share common co-authors are co-authors themselves.
In contrast, we would expect this to happen 0.27% of the time in a [random network with the same degree distribution](/blog/degree-preserving-randomisation/), and 0.04% of the time in a random network with the same number of nodes and edges.
Thus, the NBER co-authorship network is much more clustered than would be expected if authors chose co-authors randomly.

Another way to measure triadic closure is by computing the rate at which pairs of nodes with common neighbours *become* adjacent.
This method makes sense whenever the network's density grows over time.
Such growth occurs in the NBER co-authorship network through co-authorships of new working papers.
The network contains 32,034 pairs of eventual co-authors, 1,861 of whom share common co-authors at an earlier stage of the network's evolution.
However, 340,235 of the 342,096 pairs of authors with common co-authors never become co-authors themselves.
Thus, only 0.54% of the unclosed triads in the NBER co-authorship network ever become closed.

How can we reconcile the NBER co-authorship network's high clustering coefficient with its low triad closure rate?[^unobserved]
One explanation could be that referrals primarily attract collaborators on current projects rather than potential future projects.
Suppose I'm writing a paper with Alice, who suggests that Bob may have some valuable insights on our research, and that Bob and I might work well together.
It turns out that Bob does have valuable insights and that we do work well together, and Alice and I decide to make him a co-author on our paper.[^compensation]
We publish our research as an NBER working paper, and Alice, Bob and I appear as a closed triad in the NBER co-authorship network (but never as an unclosed triad).

[^unobserved]: Researchers in the NBER co-authorship network may collaborate in ways not captured by the network. For example, working papers published in the NBER series must have at least one NBER-affiliated author, so papers written exclusively by non-affiliates are not observed in my data. If co-author referrals primarily lead non-affiliates to collaborate, and if such collaboration does not culminate in NBER working paper publications, then we would expect to observe a low triad closure rate. However, we would also expect a low (perhaps lower than 0.15) clustering coefficient because the triads containing non-affiliates would remain mostly open.

[^compensation]: [Barnett et al. (1988)](https://doi.org/10.2307/1926798) and [Hamermesh (2013)](https://doi.org/10.1257/jel.51.1.162) suggest that co-authorship is increasingly used as compensation for colleagues' research assistance.

If intra-project closure is common then we would expect a high clustering coefficient and low triad closure rate in the NBER co-authorship network.
The open triads in the network would be the triads for which successful referrals did not occur during co-authorship, and the factors that prevented such referrals may persist after the paper is published.

