---
title: 'College Degrees in the US: Similarity Measures'
tags: [similarity, networks, PUMS, R]
math: true
---



In my last post, I used the [2016 ACS PUMS](https://census.gov/programs-surveys/acs/data/pums.html) data to analyse how educational attainment and degree field choices vary between demographic groups.
I commented that the rates at which graduates pair fields together "provide insight into the intellectual connections between fields."
This post compares different ways of estimating the strength of such connections.

## Field pair co-occurrences

The [repository](https://github.com/bldavies/college-degrees) for this post contains the files `observations.csv` and `fields.csv`, which I import as follows.


```r
library(readr)

data_url     <- 'https://raw.githubusercontent.com/bldavies/college-degrees/master/data/'
observations <- read_csv(paste0(data_url, 'observations.csv'))
fields       <- read_csv(paste0(data_url, 'fields.csv'))
```

`observations` aggregates the sample weights in the PUMS data by age, sex, and degree level and fields.
I use these weights to construct a field pair co-occurrence matrix `C`:


```r
library(dplyr)

C <- observations %>%
  # Aggregate sample weights by field pair
  filter(level > 0) %>%
  mutate(field2 = ifelse(is.na(field2), field1, field2)) %>%
  count(field1, field2, wt = weight) %>%
  mutate(n = n / 2) %>%
  # Identify weighted field-respondent pairs
  mutate(respondent = row_number()) %>%
  tidyr::gather(key, field, field1, field2) %>%
  count(field, respondent, wt = n) %>%
  # Count field pair co-occurrences
  widyr::pairwise_count(field, respondent, wt = n, diag = TRUE) %>%
  # Cast to matrix
  reshape2::acast(item1 ~ item2, value.var = 'n', fill = 0)
```

The diagonal elements of `C` estimate the total number of graduates with degrees in each field, while the off-diagonal elements estimate the number of graduates that chose each degree field pair.
For example, the elements of the leading submatrix


```r
C[1:5, 1:5]
```

```
##          1100     1101    1102     1103    1104
## 1100 181555.0    128.0     0.0    163.5     0.0
## 1101    128.0 124979.0   647.5    971.0   196.5
## 1102      0.0    647.5 47352.5    521.5     0.0
## 1103    163.5    971.0   521.5 173097.0   261.5
## 1104      0.0    196.5     0.0    261.5 46670.0
```

provide estimates for the degree fields listed in the first five rows of `fields`:


```r
head(fields, 5)
```

```
## # A tibble: 5 x 2
##   field field_desc                           
##   <dbl> <chr>                                
## 1  1100 General Agriculture                  
## 2  1101 Agriculture Production And Management
## 3  1102 Agricultural Economics               
## 4  1103 Animal Sciences                      
## 5  1104 Food Science
```

About 125,000 graduates hold degrees in Agriculture Production And Management, nearly 1,000 of which also hold degrees in Animal Sciences.
Agricultural Economics attracts about as many graduates as Food Science, but no respondents in the PUMS data reported studying both.

## Similarity measures

The diagonal elements of `C` estimate the "size," in units of graduates, of each degree field.
The distribution of field sizes is positively skewed, with the largest field having more than 30 times the size of the smallest 50% of fields:


```r
summary(diag(C))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   10696   54731  142088  415163  407828 4275723
```

Using the elements of `C` to measure the strength of connections between fields may lead to biased inferences by, for example, making large fields with proportionally few graduates in common appear to have stronger connections than small fields with proportionally many graduates in common.
One way to avoid such bias is to normalise each element `$c_{ij}$` of `C` by the corresponding field sizes `$s_i=c_{ii}$` and `$s_j=c_{jj}$`, thereby producing a scale-invariant "similarity" measure between pairs of degree fields.

Dividing `$c_{ij}$` by the arithmetic mean `$(s_i+s_j)/2$` yields the [Dice coefficient](https://en.wikipedia.org/wiki/Sørensen–Dice_coefficient)
`$$ \mathrm{Dice}(i,j) = \frac{2c_{ij}}{s_i+s_j}, $$`
while dividing `$c_{ij}$` by the geometric mean `$\sqrt{s_is_j}$` yields the [Ochiai coefficient](https://en.wikipedia.org/wiki/Cosine_similarity#Otsuka-Ochiai_coefficient)
`$$ \mathrm{Ochiai}(i,j) = \frac{c_{ij}}{\sqrt{s_i\,s_j}}. $$`
The Dice coefficient can be used to define the [Jaccard index](https://en.wikipedia.org/wiki/Jaccard_index)
`$$ \begin{align} \mathrm{Jaccard}(i,j) &= \frac{c_{ij}}{s_i + s_j - c_{ij}} \\ &= \frac{\mathrm{Dice}(i,j)}{2 - \mathrm{Dice}(i,j)}, \end{align} $$`
which is conceptually related to the [overlap coefficient](https://en.wikipedia.org/wiki/Overlap_coefficient)
`$$ \mathrm{Overlap}(i,j) = \frac{c_{ij}}{\min(s_i, s_j)} $$`
in that both capture the relative size of set intersections.
These four similarity measures take values on the closed unit interval `$[0,1]$`, with more "similar" fields achieving values closer to unity.
Indeed, one can show that `$$ \mathrm{Jaccard}(i,j) \le \mathrm{Dice}(i,j) \le \mathrm{Ochiai}(i,j) \le \mathrm{Overlap}(i,j) \le 1, $$` with the two inner inequalities holding with equality if and only if `$s_i=s_j$`, and with all four inequalities holding with equality if and only if `$s_i=s_j=c_{ij}$`. Thus, two fields have unit similarity precisely when the sets of graduates with degrees in each field coincide.

I compute matrices of Dice, Jaccard, Ochiai and overlap similarities by defining


```r
S <- matrix(rep(diag(C), nrow(C)), nrow = nrow(C))
```

and exploiting element-wise matrix operations:


```r
dice_mat    <- 2 * C / (S + t(S))
jaccard_mat <- C / (S + t(S) - C)
ochiai_mat  <- C / sqrt(S * t(S))
overlap_mat <- C / pmin(S, t(S))
```

## Ordinal properties

One way to compare similarity measures is to compare how they rank fields from most to least similar.
I do so using [Kendall's tau coefficient](https://en.wikipedia.org/wiki/Kendall_rank_correlation_coefficient), which captures the extent to which two rankings agree on the relative positions of ranked entities.
Kendall's tau is defined as 
`$$ \tau(r_1,r_2) = \frac{2\times\text{Number of concordant pairs}}{\text{Number of pairs}} - 1, $$`
where `$r_1$` and `$r_2$` are ranking functions, and where a pair `$(x,y)$` of entities is "concordant" if `$(r_1(x)-r_1(y))$` and `$(r_2(x)-r_2(y))$` share the same sign.
If every pair is corcordant then `$\tau(r_1,r_2)=1$` and if none are concordant then `$\tau(r_1,r_2)=-1$`.
The more `$r_1$` and `$r_2$` agree on the relative positions of ranked entities, the greater is the number of concordant pairs and hence the larger is `$\tau(r_1,r_2)$`.

Rearranging the definition of `$\tau(r_1,r_2)$` gives
`$$ \Pr(\text{Pair is concordant}) = \frac{\tau(r_1, r_2) + 1}{2}. $$`
Thus, computing Kendall's tau for the rankings produced by each similarity measure, and mapping the results linearly to the unit interval, allows me to estimate the rates of agreement between different measures.
I compute these rates as follows, excluding zero and unit similarities, and report the results as a matrix.


```r
similarities <- tibble(
  Dice      = as.vector(dice_mat),
  Jaccard   = as.vector(jaccard_mat),
  Ochiai    = as.vector(ochiai_mat),
  Overlap   = as.vector(overlap_mat),
  `Co-occ.` = as.vector(C)  # Include for comparison
) %>%
  filter(as.vector(upper.tri(C) & C > 0))

similarities %>%
  cor(method = 'kendall') %>%
  {(. + 1) / 2} %>%  # Map to unit interval
  round(3)
```

```
##          Dice Jaccard Ochiai Overlap Co-occ.
## Dice    1.000   1.000  0.914   0.778   0.778
## Jaccard 1.000   1.000  0.914   0.778   0.778
## Ochiai  0.914   0.914  1.000   0.864   0.798
## Overlap 0.778   0.778  0.864   1.000   0.765
## Co-occ. 0.778   0.778  0.798   0.765   1.000
```

The Dice and Jaccard measures produce identical rankings, and both reach about 91% and 78% agreement with the rankings produced using the Ochiai and overlap measures.
All four measures produce rankings that reach less than 80% agreement with the ranking produced using co-occurrence counts.

The following table presents the 10 most similar field pairs using the Dice and Jaccard measures, and those pairs' ranks using the Ochiai, overlap and co-occurrence measures.


|Field 1                                     |Field 2                                | Dice/Jacc. rank| Ochiai rank| Overlap rank| Co-occ. rank|
|:-------------------------------------------|:--------------------------------------|---------------:|-----------:|------------:|------------:|
|Plant Science And Agronomy                  |Soil Science                           |               1|           1|            1|          127|
|Mathematics Teacher Education               |Science And Computer Teacher Education |               2|           3|           15|           66|
|Biochemical Sciences                        |Molecular Biology                      |               3|           2|            5|           56|
|Ecology                                     |Miscellaneous Biology                  |               4|           4|           21|          146|
|Mathematics                                 |Physics                                |               5|           5|            8|           11|
|Political Science And Government            |History                                |               6|           8|           48|            2|
|Journalism                                  |Mass Media                             |               7|           9|           30|           26|
|Social Science Or History Teacher Education |Language And Drama Education           |               8|          10|           43|           53|
|Accounting                                  |Finance                                |               9|          12|           32|            1|
|Soil Science                                |Geosciences                            |              10|          14|           53|         1048|

Plant Science And Agronomy and Soil Science top the rankings for all four similarity measures, despite being only the 127th most common field pair.
Biochemical Sciences and Molecular Biology, and Mathematics and Physics are the only other field pairs that rank in the top 10 most similar across all four measures.
Accounting and Finance, the most common field pair, ranks in the top 10 most similar fields using the Dice and Jaccard measures only.

## Network properties

Another way to compare similarity measures is to compare properties of the networks they define.
Each similarity matrix defines a network in which nodes represent degree fields and in which edges have weight equal to the similarity between incident nodes.


```r
library(igraph)

get_network <- function(adj_mat) {
  adj_mat %>%
    graph.adjacency(mode = 'undirected', weighted = TRUE) %>%
    simplify()  # Ignore self-similarities
}

coocc_net   <- get_network(C)
dice_net    <- get_network(dice_mat)
jaccard_net <- get_network(jaccard_mat)
ochiai_net  <- get_network(ochiai_mat)
overlap_net <- get_network(overlap_mat)
```

I compare similarity measures by comparing fields' [centralities](https://en.wikipedia.org/wiki/Centrality) in each network.
I base my analysis on [PageRank](https://en.wikipedia.org/wiki/PageRank) centrality for a variety of reasons:

* Unlike degree-based centrality measures (e.g., degree and strength), PageRank considers the "importance" of each neighbour as well as neighbourhood size;
* Unlike distance-based centrality measures (e.g., betweenness and closeness), PageRank doesn't require solving a bunch of [shortest path problems](https://en.wikipedia.org/wiki/Shortest_path_problem);
* Unlike eigenvector centrality, PageRank doesn't require the underlying network to be strongly connected.[^notes]

I store degree fields' PageRank centralities as a tibble


```r
pageranks <- tibble(
  Dice      = page_rank(dice_net)$vector,
  Jaccard   = page_rank(jaccard_net)$vector,
  Ochiai    = page_rank(ochiai_net)$vector,
  Overlap   = page_rank(overlap_net)$vector,
  `Co-occ.` = page_rank(coocc_net)$vector
)
```

and compute the corresponding matrix of Kendall's tau coefficients, each mapped linearly to the unit interval:


```r
pageranks %>%
  cor(method = 'kendall') %>%
  {(. + 1) / 2} %>%
  round(3)
```

```
##          Dice Jaccard Ochiai Overlap Co-occ.
## Dice    1.000   0.999  0.949   0.819   0.824
## Jaccard 0.999   1.000  0.949   0.819   0.823
## Ochiai  0.949   0.949  1.000   0.869   0.839
## Overlap 0.819   0.819  0.869   1.000   0.791
## Co-occ. 0.824   0.823  0.839   0.791   1.000
```

The rankings of fields from most to least PageRank-central under the Dice and Jaccard measures are almost identical, and reach just over 82% agreement with the ranking produced using co-occurrence counts.

The table below presents the 10 most PageRank-central fields using the Dice measure, and the corresponding ranks using the Jaccard, Ochiai, overlap and co-occurrence measures.
The column "Size rank" orders each field from largest to smallest.


|Field                                                         | Dice rank| Jaccard rank| Ochiai rank| Overlap rank| Co-occ. rank| Size rank|
|:-------------------------------------------------------------|---------:|------------:|-----------:|------------:|------------:|---------:|
|French German Latin And Other Common Foreign Language Studies |         1|            1|           1|            9|           15|        35|
|Mathematics                                                   |         2|            2|           2|            6|           10|        22|
|Political Science And Government                              |         3|            3|           3|            5|            5|        10|
|Mass Media                                                    |         4|            5|          11|           23|           28|        50|
|Molecular Biology                                             |         5|            4|          13|           26|           53|       113|
|English Language And Literature                               |         6|            6|           4|            4|            3|         9|
|History                                                       |         7|            7|           9|           10|            9|        15|
|Economics                                                     |         8|            8|           7|            7|            8|        14|
|Psychology                                                    |         9|            9|           5|            3|            1|         3|
|Sociology                                                     |        10|           10|          10|           13|           12|        19|

Languages, Mathematics, and Political Science And Government are the most PageRank-central fields under the Dice, Jaccard and Ochiai measures.
The Ochiai and overlap measures rank Mass Media and Molecular Biology relatively low on PageRank centrality, possibly due to those fields' relatively small size.
The PageRank centralities produced using co-occurrence counts appear to correlate positively with field size, consistent with my worry that such counts may bias the measurement of intellectual connectedness in favour of larger fields.



[^notes]: Ryan Tibshirani [provides excellent notes](http://www.stat.cmu.edu/~ryantibs/datamining/lectures/03-pr.pdf) on how PageRank handles disconnected components and "dangling" nodes.
