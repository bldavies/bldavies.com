---
title: Gender sorting among economists
topics: [networks, research]
summary: |
  Summary of "Gender sorting among economists: Evidence from the NBER"
---

I have a [new paper](https://doi.org/10.1016/j.econlet.2022.110640) on gender sorting in economic research teams.
Here's the abstract:

> I compare the co-authorship patterns of male and female economists, using historical data on National Bureau of Economic Research working papers.
> Men tended to work in smaller teams than women, but co-authored more papers and so had more co-authors overall.
> Both men and women had more same-gender co-authors than we would expect if co-authorships were random.
> This was especially true for men in Macro/Finance.

I show that the NBER co-authorship network is [assortatively mixed](/blog/assortative-mixing/) with respect to gender, and has been since the late 1980s.
This could reflect explicit choices to work in same-gender teams.
But it could also be a consequence of other choices (e.g., which topics to research) that lead to gender sorting.
I leave this distinction open for future research.

The paper uses data from [nberwp](https://github.com/bldavies/nberwp/), an R package I've been working on since 2019.
I've described and used the package in several blog posts:

* [Introducing nberwp](/blog/introducing-nberwp/)
* [NBER (co-)authorships](/blog/nber-co-authorships/)
* [Triadic closure at the NBER](/blog/triadic-closure-nber/)
* [Female representation and collaboration at the NBER](/blog/female-representation-collaboration-nber/)
* [nberwp is now on CRAN](/blog/nberwp-cran/)
* [nberwp 1.1.0](/blog/nberwp-1-1-0/)
* [Publication outcomes of NBER working papers](/blog/publication-outcomes-nber-working-papers)
* [Gender differences in publication rates within NBER programs](/blog/gender-differences-publication-rates-nber-programs/)

The paper is in [*Economics Letters*](https://www.sciencedirect.com/journal/economics-letters), which publishes concise papers at most 2,000 words long.
This seemed appropriate for my paper: it's longer than a blog post but shorter than an [*AER*](https://www.aeaweb.org/journals/aer) epic.
The few words mask the many hours spent collecting and cleaning the data (e.g., manually identifying about 2,500 authors' genders).
Such is the nature of publishing empirical work.
