---
title: NBER (co-)authorships
topics: [networks, research, software]
linkSource: yes
---

I recently updated the R package [nberwp](https://github.com/bldavies/nberwp) to include data on NBER working paper authorships.
These data describe a bipartite author-paper network containing 13,571 authors and 26,586 papers.
On average, each author has 4.35 papers and each paper has 2.22 authors.

The co-authorship network among NBER authors---that is, the [bipartite projection](https://en.wikipedia.org/wiki/Bipartite_network_projection) of the author-paper network onto the set of authors---contains 0.03% of the possible edges among the 13,571 authors in the network.
On average, each author has 4.72 unique co-authors across the working paper series.
About 95% of authors belong to a single connected component of the co-authorship network, while 139 authors have no co-authors.

One challenge that arises when constructing co-authorship networks is [disambiguating authors' names](https://en.wikipedia.org/wiki/Author_name_disambiguation).
Slight misspellings may split a single author into many nodes, while many authors with the same name may be merged into a single node.
These false splits and merges inhibit one's ability to draw robust inferences about collaborative behaviour from the co-authorship network's structure.

It is easiest to disambiguate author names when they can be cross-referenced against other data.
The [NBER RePEc index](https://www.nber.org/RePEc/nbr/nberwo/), from which I extract the authorship data, links some authors to their [RePEc](http://repec.org/) author IDs.
These IDs allow me to merge some authors who publish under varying names.
I also merge authors with (i) sufficiently similar names and (ii) overlapping neighbourhoods in the co-authorship network.
Criterion (i) assumes that authors' names tend to vary from their true values by a few characters only, while criterion (ii) assumes that authors tend to write multiple papers with the same set of co-authors.
Combined, these criteria form a computationally feasible heuristic for identifying and resolving false splits.

In contrast, I do not attempt to identify false merges.
One method could be to look for authors who bridge otherwise distant parts of the co-authorship network.
This method assumes that authors tend to sort into clusters (e.g., by research interest) and that links between clusters are uncommon.
However, this assumption defies the empirical evidence that the co-authorship network among economists has a [small-world](https://en.wikipedia.org/wiki/Small-world_network) structure ([Goyal et al., 2006](https://doi.org/10.1086/500990)).

