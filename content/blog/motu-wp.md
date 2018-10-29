---
title: Coauthorship Networks at Motu
date: "2018-06-21"
tags: [igraph, networks, R, Motu]
---

Earlier this year I joined [Motu](https://motu.nz), an economic and public policy research institute based in Wellington, New Zealand.
In this post, I analyse the coauthorship network among Motu researchers based on working paper publications.
The source code and data used in my analysis are available [here](https://github.com/bldavies/motu-wp).

## Collecting and preparing the data

Bibliographic data is notoriously uncooperative.
Changes in author or institution names make it difficult to uniquely identify researchers across time, reducing data consistency and completeness.
Moreover, most bibliographic databases charge an access fee that discourages casual exploration.
Fortunately, [Motu's working paper directory](https://motu.nz/resources/working-papers/) is presented in a consistent format that makes it amenable to web scraping free of charge.

The Python script [`urls.py`](https://github.com/bldavies/motu-wp/blob/master/code/urls.py) scrapes the directory for a list of working paper attributes.
I use [Beautiful Soup](https://www.crummy.com/software/BeautifulSoup/) to parse the source HTML and the regular expression library `re` to extract elements of interest.
Although [regular expressions and HTML generally don't play nicely](https://stackoverflow.com/questions/1732348/regex-match-open-tags-except-xhtml-self-contained-tags), they seemed to cooperate in meeting my specific needs.

`urls.py` outputs a file named [`urls.csv`](https://github.com/bldavies/motu-wp/blob/master/data/urls.csv) that stores the list of working paper years, numbers and URLs.
Each URL points to a landing page for the associated working paper containing, for example, abstract and citation metadata.
A second script, [`linked-authors.py`](https://github.com/bldavies/motu-wp/blob/master/code/linked-authors.py), loops through each URL and queries the associated metadata for a list of authors.
I extract only those authors with outgoing hyperlinks because

1. the hyperlinked URL provides a unique and consistent author ID, and
2. it is much easier to perform a regular expression search for `<a href="(.*?)">` than to distinguish the different uses of commas case-by-case.

The resulting file [`linked-authors.csv`](https://github.com/bldavies/motu-wp/blob/master/data/linked-authors.csv) contains working paper years and numbers, and the associated authors' names and IDs.
It excludes the authors of three papers for which there is no landing page linked from the main directory.

After generating the aforementioned CSVs, I migrate from Python to R and begin my analysis.
The first step is to import the [`igraph`](http://igraph.org/r/) package for working with network objects, load several packages from the [tidyverse](https://www.tidyverse.org) to help with plotting and data manipulation, and of course read in the data:

```r
library(dplyr)
library(ggplot2)
library(igraph)
library(readr)
library(stringr)
library(tidyr)

fields <- read_csv("data/fields.csv")
linked_authors <- read_csv("data/linked-authors.csv")
urls <- read_csv("data/urls.csv")
```

The file [`fields.csv`](https://github.com/bldavies/motu-wp/blob/master/data/fields.csv) contains the name, ID and ambient colour for each of [Motu's six primary research areas](https://motu.nz/our-work/), and is created manually.
I merge `linked_authors` and `urls` into a single tibble `data` as follows, using a regular expression search to extract the field ID from each working paper's URL.

```r
data <- linked_authors %>%
  left_join(urls) %>%
  mutate(paper_id = paste0(year - 2000, "-", number),
         field_id = sub("/our-work/(.*?)/.*", "\\1", url)) %>%
  select(year, paper_id, field_id, author_id)
```

## The authorship network

I next construct an authorship network by pairing papers with their authors using the information contained in `data`.
I achieve this by defining an author-paper incidence matrix

```r
incidence <- table(data$author_id, data$paper_id)
```

and using that matrix to create a bipartite network `bip`:

```r
bip <- graph.incidence(incidence)
```
 
The authorship network `bip` contains 73 authors who collectively wrote 230 working papers over the 2003--2018 sample period.
Those papers are distributed across Motu's research fields as shown in the chart below.

![](https://raw.githubusercontent.com/bldavies/motu-wp/master/figures/field-counts.svg?sanitize=true)

The variation in working paper counts reflects the variation in fields' tenure within Motu's research portfolio.
Environment and Resources, contributing 67 working papers, has been around since the series began; Human Rights, appearing only once in the series, is a relatively new research field for Motu.

The authorship network `bip` is drawn below using [Fruchterman and Reingold's (1991)](https://onlinelibrary.wiley.com/doi/abs/10.1002/spe.4380211102) force-directed algorithm.
Squares denote working papers and are coloured by research field.
Each circle denotes an author and is scaled according to the number of working papers (co)written by that author.

![](https://raw.githubusercontent.com/bldavies/motu-wp/master/figures/author-network.svg?sanitize=true)


A striking feature of `bip` is the presence of three high-degree vertices, or *hubs*, each representing an author of at least 30 working papers.
These hubs are shaded in the map of `bip` shown above.
Another feature is the variation in field diversity within authors' individual corpuses.
Urban and Regional authors tend to also write papers on Wellbeing and Macroeconomics, while Environment and Resources authors are more specialised.

## The coauthorship network

Projecting `bip` onto the set of authors yields a coauthorship network in which two authors are adjacent if they have written a paper together.
I define such a projection via

```r
net <- bipartite.projection(bip)[[1]]
```

I use the [`jaccard`](https://github.com/bldavies/pokenet/blob/master/code/jaccard.R) function described in my previous post to determine the similarity between two authors from their authorship counts.
According to this measure, maximally similar authors always write together while maximally dissimilar authors never write together.
Again, I use the Fruchterman-Reingold algorithm for distributing vertices in the plane.
The resulting map of `net` is shown below.

![](https://raw.githubusercontent.com/bldavies/motu-wp/master/figures/coauthor-network.svg?sanitize=true)

The coauthorship network is very sparse, containly only 165 (about 6%) of the 2,628 possible edges between its 73 vertices.
However, the largest connected component (LCC) of `net` contains all but six authors, two of whom write exclusively with each other and the remaining four having zero coauthors.
Such connectivity is facilitated by the three shaded hubs identified above.
These hubs each have at least 20 coauthors and are collectively adjacent to 61 of the 67 authors in the LCC.

### Hints of small-worldness

The sparsity of `net` implies that most pairs of authors aren't coauthors.
Indeed, the probability that two randomly selected authors are coauthors is given by `net`'s edge density: about 0.06.
However, it is not unusual for two randomly selected authors to share a common coauthor; within the LCC of `net`, the probability of such an event is about 0.46.
I calculate this probability by examining the distribution of (unweighted) [geodesic distances](https://en.wikipedia.org/wiki/Distance_(graph_theory)) between the vertices in `net` and determining the proportion of vertex pairs that are distance two apart.
The following function performs that calculation for an arbitrary connected graph `G`.

```r
common_neighbour_rate <- function (G) {
    B <- distances(G, weights = rep(1, gsize(G))) == 2
    num_pairs <- choose(gorder(G), 2)
    rate <- (sum(B) / 2) / num_pairs  # Average within upper right triangle
    return (rate)
}
```

The function `common_neighbour_rate` works by computing the geodesic distances between each pair of vertices in `G`, defining binary indicator variables (as entries of the matrix `B`) for whether each distance is equal to two and taking the average of those variables over all possible vertex pairs.
Its name comes from recognising that "coauthor" is a context-specific synonym for "neighbouring vertex."

Within the LCC of `net`, the average distance between any two authors is equal to 2.5 while the maximum such distance---the *diameter* of the LCC---is equal to five.
These numbers suggest a smallness about the world inhabited by Motu working paper authors: if you ask anyone if they've written a paper with so-and-so, the answer you'll get is probably, "no, but I've written with someone who has written with someone that has."
It appears that, at least in terms of geodesic distances, Motu researchers are seldom far apart.

### Testing for small-worldness

[Watts and Strogatz (1998)](https://www.nature.com/articles/30918) formalise the idea of small-worldness.[^strogatz]
They identify small-world networks as those that are

> highly clustered ... yet have small characteristic path lengths.

The extent to which a network is clustered is determined by its [clustering coefficient](https://en.wikipedia.org/wiki/Clustering_coefficient#Global_clustering_coefficient), while the characteristic path length is simply the mean geodesic distance between pairs of vertices.
Intuitively, a network is small-world if it has local communities whose links are mostly internal but with a few external links that facilitate fast inter-community exchange.
For example, most flights undertaken by New Zealanders comprise travel within our dense domestic network, but a Cantabrian wanting to holiday in Bangkok or Dubai need only make a pitstop in Sydney.
The latter acts as a hub that connects many distant cities in the same way that the three shaded vertices in the map of `net` above connect many otherwise distant authors.

[Humphries and Gurney (2008)](http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0002051) describe a method for determining small-worldness using random graphs.
Their strategy is to compare the clustering coefficient and mean distance between vertices in a network to the expected value of those attributes if edges are randomly distributed.
Concretely, they state that 

> A network with `n` nodes and `m` edges is a small-world network if it has a similar path length but greater clustering of nodes than an equivalent Erdös-Rényi random graph with the same `n` and `m`.

The [Erdös-Rényi model](https://en.wikipedia.org/wiki/Erdős–Rényi_model) is a simple method of generating random graphs with a fixed number of vertices and edges, the latter being placed between vertex pairs with uniform probability and without duplication.
Such graphs tend to have short mean distances because edges are as likely to traverse the network and bridge communities as they are to consolidate an already tight local community.
Likewise, random edge assignment disregards community formation, causing Erdös-Rényi graphs to have small clustering coefficients.

The function below computes the clustering coefficient (known to `igraph` users as `transitivity`) and characteristic path length for a sample of Erdös-Rényi random graphs that are equivalent to an arbitrary graph `G`.
The sample means of these attributes provide baselines against which to measure the corresponding values observed from `G`.

```r
small_world_baselines <- function (G, sample_size = 1000, seed = 0) {
  set.seed(seed)
  transitivity_samples <- rep(0, sample_size)
  mean_distance_samples <- rep(0, sample_size)
  for (i in 1 : sample_size) {
    er <- sample_gnm(gorder(G), gsize(G))
    transitivity_samples[i] <- transitivity(er)
    mean_distance_samples[i] <- mean_distance(er, directed = FALSE)
  }
  return (list(transitivity = mean(transitivity_samples),
               mean_distance = mean(mean_distance_samples)))
}
```

The coauthorship network `net` has clustering coefficient 0.24 and mean distance 2.48, with baseline comparators of 0.06 and 2.95, respectively.
Thus, `net` is about four times as clustered as is expected for a network with its density and has slightly shorter geodesic distances than would be obtained by allocating edges randomly.
These facts positively indicate small-worldness, and reflect widespread collaboration between authors within and between research fields.

Humphries and Gurney define a *small-world coefficient* by taking the ratio of observed and expected clustering coefficients, and dividing the result by the ratio of observed and expected mean distances.
This quotient is larger than one for small-world networks.
The coauthorship network `net` obtains a small-world coefficient of 4.60, thereby passing the Humphries-Gurney small-worldness test.

## Subsampling by field

Finally, I analyse the coauthorship network within Motu's five largest research fields.
I filter the working papers from `data` that correspond to each field and recompute several statistics mentioned earlier using the subsample data.
The first set of statistics is shown in the table below.

Field | Papers | Authors | Edge Density | LCC Order | LCC Diameter
:--- | ---:| ---:| ---:| ---:| ---:
Environment and Resources | 67 | 37 | 0.08 | 29 | 3
Population and Labour | 55 | 27 | 0.14 | 25 | 4
Urban and Regional | 49 | 31 | 0.10 | 28 | 4
Wellbeing and Macroeconomics | 35 | 19 | 0.13 | 14 | 2
Productivity and Innovation | 23 | 18 | 0.18 | 18 | 4

Environment and Resources boasts the largest number of authors as well as working papers. However, it has the least dense coauthorship network, containing only 8% of all possible edges.
The Productivity and Innovation coauthorship network is the most dense.
All 18 of its contained authors are connected by a path of at most four coauthorships.
The largest connected component of the Wellbeing and Macroeconomics coauthorship network is the smallest among the five fields; however, every pair of authors within its LCC are coauthors or share a common coauthor.

I also test each field's coauthorship network for small-worldness using the Humphries-Gurney procedure.
The results are tabulated below.

Field | Clustering Coefficient (Baseline) | Mean Distance (Baseline) | Small-world Coefficient
:---| ---:| ---:| ---:
Environment and Resources | 0.25 (0.08) | 1.93 (3.16) | 5.13
Population and Labour | 0.35 (0.13) | 2.15 (2.54) | 3.07
Urban and Regional | 0.17 (0.09) | 2.13 (3.04) | 2.69
Wellbeing and Macroeconomics | 0.19 (0.11) | 1.77 (2.88) | 2.76
Productivity and Innovation | 0.36 (0.17) | 2.26 (2.40) | 2.26

All five fields have small-world coefficients greater than one, and therefore satisfy Humphries and Gurney's criterion.
However, the ratio of observed and baseline clustering coefficients is not as large in any field as it is in the full coauthorship network.
Moreover, only two fields have mean distances close to those expected in an equivalent Erdös-Rényi random graph.
The best candidate for a small world---that is, a world with high clustering and as-random geodesic distances---is the Productivity and Innovation coauthorship network, despite it having the lowest small-world coefficient.

I suspect that network size adds considerable noise to these estimates.
Even the full coauthorship network `net` is barely large enough to exhibit any global structure that can be distinguished from randomness.
Applying the Humphries-Gurney test to a larger network, or implementing a more robust procedure such as that proposed by [Telesford et al. (2011)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3604768/), may yield cleaner results.

[^strogatz]: The linked article is locked behind a paywall. However, Strogatz hosts [a free copy](http://www.stevenstrogatz.com/articles/collective-dynamics-of-small-world-networks-pdf) on his website.
