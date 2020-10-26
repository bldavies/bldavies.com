---
title: Research funding and collaboration
topics: [research, networks]
---

Research is increasingly conducted by teams.
Consequently, there is growing interest in the mechanisms underlying research team formation.
In [a new NBER working paper][paper-url], my co-authors and I explore one potential mechanism: participation in research funding contests.
Such contests may promote collaboration for several reasons:

* They require proposal team members to invest resources in planning collaborative projects;
* They may help researchers screen for productive collaborators;
* If better ideas are more likely to win funding then success signals that researchers' shared ideas are worth pursuing.

These arguments suggest that the members of more successful proposal teams are more likely to become co-authors.
We test this hypothesis empirically, using data from New Zealand.
Our data include Scopus publication records on New Zealand researchers and their international co-authors.
We link these records to data on applications to the [Marsden Fund](https://www.royalsociety.org.nz/what-we-do/funds-and-opportunities/marsden), the premier source of funding for basic research in New Zealand.

In our data, researchers with more successful Marsden Fund applications tended to have more co-authors.
However, this tendency may be driven by confounding factors, such as researchers' ability to generate publishable research.
We control for such factors by analysing co-authorship dynamics econometrically.
Specifically, we use [dyadic regression](https://doi.org/10.1016/B978-0-12-811771-2.00008-0) to estimate how the probability that pairs of researchers co-author in a given year varies with their observable characteristics.
Pairs were more likely to co-author in a given year if

* they had co-authored with each other recently,
* they co-authored with others often,
* they published in similar fields,
* their prior publications attracted more citations, or
* their prior citation histories differed.

The fifth bullet implies negative [assortative mixing](https://en.wikipedia.org/wiki/Assortative_mixing) among the researchers in our data, which we suspect arises due to inter-generational collaboration (e.g., professors working with graduate students and post-docs).

On average, pairs were 13.8 percentage points more likely to co-author in a given year if they co-submitted Marsden Fund proposals during the previous ten years than if they did not.
This co-authorship rate was not significantly larger among pairs who received funding.
However, increasing the lag between our outcome and explanatory variables delivers the opposite result: funding receipt, rather than proposal submission, promotes co-authorship.
As discussed in [our paper][paper-url], these patterns suggest that the "treatment effect" of research funding contest participation on co-authorship is limited to successful participants only.

Our analysis has both technical and policy implications.
On the technical side, we discuss some empirical problems that arise when analysing co-authorship networks, offer solutions to these problems, and discuss how these solutions affect our inferences.
On the policy side, we show how science funding schemes can influence how researchers choose collaborators, which may have long-term effects on how science and innovation systems evolve.

[paper-url]: https://www.nber.org/papers/w27916
