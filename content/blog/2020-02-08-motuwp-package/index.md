---
title: motuwp is now an R package
tags: [collaboration, networks, packages]
linkSource: yes
---

My current project at Motu involves analysing co-authorship networks.
It is helpful for me to have a small example network that I can use to, for example, [compare sampling techniques][sampling-post].
The [Motu working paper co-authorship network](/blog/coauthorship-networks-motu/) is my go-to.
Since I work mostly in R, I have converted the [repository](https://github.com/bldavies/motuwp) containing the underlying authorship data to an R package.
This package can be installed from GitHub via [remotes](https://github.com/r-lib/remotes):

```r
library(remotes)

install_github('bldavies/motuwp')
```
 
motuwp provides two data frames: `papers`, containing working paper attributes, and `authors`, containing author-paper pairs.
These pairs can be used to construct a co-authorship network as follows:

```r
library(igraph)
library(motuwp)

# Method 1: Project bipartite author-paper network onto author set
bip <- graph_from_data_frame(authors, directed = F)
V(bip)$type <- V(bip)$name %in% authors$author
net <- bipartite_projection(bip, which = 'true', multiplicity = F)

# Method 2: use convenience function that returns same network
net <- coauthorship_network()
```

The co-authorship network `net` contains 185 nodes and 729 edges.
These values are larger than the corresponding values of 82 and 218 reported in [my mid-2019 blog post][sampling-post] on the network.
The increases are due to me adding (i) the remaining working papers from 2019, (ii) some papers with missing landing pages, and (iii) authors with no hyperlinked profile page on Motu's website.

[sampling-post]: /blog/sampling-motu-coauthorship-network/
