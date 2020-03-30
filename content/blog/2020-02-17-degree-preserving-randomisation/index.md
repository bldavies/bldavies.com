---
title: Degree-preserving randomisation
tags: [networks, simulation]
linkSource: yes
---

[My previous post](/blog/centrality-rankings-noisy-edge-sets/) used [degree-preserving randomisation](https://en.wikipedia.org/wiki/Degree-preserving_randomization) (DPR) to control for network structure when estimating the effect of edge noise on nodes' centrality rankings.
The idea was that nodes may be connected in ways that amplify or suppress the effects of noise, and randomising nodes' connections helps to balance these effects by averaging over the network's possible structures.

DPR can also be used to test whether a network's structure is significantly different than would be expected for a random network with the same degree distribution.
For example, comparing a network's clustering coefficient to the mean clustering coefficient among a sample of degree-preserving random networks reveals whether the original network is significantly more or less clustered than it would be, on average, if nodes' connections were random.
In contrast to [Erdös-Rényi](https://en.wikipedia.org/wiki/Erd%C5%91s%E2%80%93R%C3%A9nyi_model) randomisation (ERR)---that is, generating a random network with the same number of nodes and edges---DPR separates variation in degree distributions from variation in other properties observed across sampled random networks.

Consider, as an example, the [Motu working paper co-authorship network](/blog/coauthorship-networks-motu/).
The table below presents the network's median node degree, global [clustering coefficient](https://en.wikipedia.org/wiki/Clustering_coefficient), and [mean geodesic distance](https://en.wikipedia.org/wiki/Average_path_length).
The table also presents the sample means and standard deviations of these properties across 50 degree-preserving and Erdös-Rényi randomisations of the co-authorship network.

|Property               | Actual value | DPR sample mean (sd) | ERR sample mean (sd) |
|:----------------------|:------------:|:--------------------:|:--------------------:|
|Median degree          |     3.00     |     3.00 (0.00)      |     7.88 (0.33)      |
|Clustering coefficient |     0.52     |     0.16 (0.01)      |     0.04 (0.00)      |
|Mean distance          |     2.72     |     2.83 (0.03)      |     2.74 (0.01)      |

By definition, DPR preserves the degree distribution and, consequently, always delivers the same median degree as the co-authorship network.
In contrast, ERR removes the inequality in node degrees (arising, for example, from [preferential attachment](https://en.wikipedia.org/wiki/Preferential_attachment)) and, consequently, delivers median degrees centred on the co-authorship network's mean degree.

The co-authorship network is about 13 times more clustered than would be expected for an Erdös-Rényi random network with same number of nodes and edges.
Controlling for the degree distribution drops this factor to just over three.
In contrast, the mean distance between nodes in the co-authorship network is closer to what we would expect in a comparable Erdös-Rényi random network than in a degree-preserving random network.

