---
title: Social networks in rural India
topics: [culture, networks, software]
summary: |
  I describe IndianVillages, an R package containing data on social networks in rural India.
  These networks are assortatively mixed with respect to caste.
linkSource: yes
---

[IndianVillages](https://github.com/bldavies/IndianVillages) is a new R package containing data on social networks in rural India.
I derived these data from [Banerjee et al.'s (2013)](https://doi.org/10.1126/science.1236498) surveys of households across 75 [Karnatakan](https://en.wikipedia.org/wiki/Karnataka) villages.
This post describes the derived data and the networks they define.
I also show that the networks are [assortatively mixed](/blog/assortative-mixing/) with respect to [caste](https://en.wikipedia.org/wiki/Caste_system_in_India).

## Data description

IndianVillages provides two tables.
The first, `households`, links each household to its village and caste:

```r
library(dplyr)
library(IndianVillages)

head(households)
```

```
## # A tibble: 6 × 3
##    hhid village caste
##   <dbl>   <dbl> <chr>
## 1  1001       1 <NA> 
## 2  1002       1 <NA> 
## 3  1003       1 <NA> 
## 4  1004       1 <NA> 
## 5  1005       1 <NA> 
## 6  1006       1 <NA>
```

The `hhid` and `village` columns store household and village IDs.
The `caste` column stores caste memberships:

```r
count(households, caste, sort = T)
```

```
## # A tibble: 6 × 2
##   caste               n
##   <chr>           <int>
## 1 OBC              5517
## 2 <NA>             4455
## 3 Scheduled Caste  2584
## 4 General          1371
## 5 Scheduled Tribe   618
## 6 Minority          359
```

Some `caste` values are missing because the surveys were changed during their collection.
About 53% of the households with known castes are in the [Other Backward Class](https://en.wikipedia.org/wiki/Other_Backward_Class) ("OBC").
This exceeds the (disputed) share of OBCs in India's general population during the survey period.

The second table, `household_relationships`, contains information on inter-household relationships:

```r
head(household_relationships)
```

```
## # A tibble: 6 × 4
##   hhid.x hhid.y village type                        
##    <dbl>  <dbl>   <dbl> <fct>                       
## 1   1001   1002       1 Help with a decision        
## 2   1001   1002       1 Borrow kerosene or rice from
## 3   1001   1002       1 Lend kerosene or rice to    
## 4   1001   1002       1 Are related to              
## 5   1001   1002       1 Invite to one's home        
## 6   1001   1002       1 Visit in another's home
```

The `hhid.x` and `hhid.y` columns store ego and alter household IDs.
The `type` column stores relationship types:

```r
count(household_relationships, type, sort = T)
```

```
## # A tibble: 12 × 2
##    type                             n
##    <fct>                        <int>
##  1 Visit in another's home      33629
##  2 Invite to one's home         32652
##  3 Engage socially with         30939
##  4 Borrow money from            25514
##  5 Lend kerosene or rice to     23993
##  6 Borrow kerosene or rice from 23743
##  7 Lend money to                23558
##  8 Obtain medical advice from   22310
##  9 Help with a decision         17228
## 10 Are related to               16037
## 11 Give advice to               15613
## 12 Go to temple with             2700
```

These types correspond to questions asked in Banerjee et al.'s surveys.

## Inter-household networks

We can use `households` and `household_relationships` to define social networks among the households in each village.
First, use the `graph_from_data_frame` function from [igraph](https://igraph.org/) to create the network among all households:

```r
library(igraph)

net = graph_from_data_frame(
  distinct(household_relationships, hhid.x, hhid.y),
  directed = F,
  vertices = households
)
```

`net` contains 66,862 edges: one for each pair of households with at least one social relationship.
There are no between-village relationships in the data, so we can partition `net` into village-specific networks without deleting any edges:

```r
library(purrr)

villages = sort(unique(households$village))

village_nets = map(villages, ~subgraph(net, V(net)$village == .))

sum(map_dbl(village_nets, gsize))  # Same as gsize(net)
```

```
## [1] 66862
```

The networks in `village_nets` are too large to describe visually.
Instead, let's compute some of their properties:

```r
village_nets_properties = map_df(village_nets, ~{
  comp = components(.)
  giant = subgraph(., comp$membership == which.max(comp$csize))
  tibble(
    Households = gorder(.),
    `Mean degree` = mean(degree(.)),
    `% of households in giant` = 100 * gorder(giant) / gorder(.),
    `Mean distance in giant` = mean_distance(giant)
  )
})
```

I summarize these properties in the table below.
The number of households in each village ranges from 77 to 356.
The mean degree of the households in each village ranges from 6.11 to 13.44.
Most households are in the giant component for their village, and are connected to others in that component via paths of length two or three.

|Property                 |   Mean| Std. dev.|  Min.| Median|   Max.|
|:------------------------|------:|---------:|-----:|------:|------:|
|Households               | 198.72|     59.29| 77.00| 190.00| 356.00|
|Mean degree              |   8.90|      1.61|  6.11|   8.72|  13.44|
|% of households in giant |  95.10|      2.71| 84.62|  95.54|  99.42|
|Mean distance in giant   |   2.75|      0.21|  2.30|   2.72|   3.32|

## Inter-caste mixing

We can use `net` to study the extent of [assortative mixing](/blog/assortative-mixing/) with respect to caste membership.
First, delete the 4,455 households with missing `caste` values:

```r
subnet = subgraph(net, !is.na(V(net)$caste))
```

`subnet` contains 10,449 households with a mean degree of 9.08.
This is similar to the mean degree in `net`.
The two networks also have similar mean distances between connected households: 2.85 in `subnet`, versus 2.81 in `net`.

Next, compute `subnet`'s mixing matrix:

```r
library(bldr)  # https://github.com/bldavies/bldr

mix_mat = get_mixing_matrix(subnet, 'caste')
```

I define `get_mixing_matrix` [here](https://github.com/bldavies/bldr/blob/master/R/get_mixing_matrix.R).
It returns a matrix in which rows and columns correspond to castes, and entries equal the share of edges joining households in each caste pair.
Multiplying these entries by the sum of degrees---which, by the [degree sum formula](https://en.wikipedia.org/wiki/Handshaking_lemma), equals twice the number of edges---yields a table of inter-caste edge counts:

```r
mix_mat * (2 * gsize(subnet))
```

```
##             
##              General Minority   OBC Sch. Caste Sch. Tribe
##   General       8680       79  3118        932        521
##   Minority        79     1860   381        156         84
##   OBC           3118      381 40058       4325       2241
##   Sch. Caste     932      156  4325      16074        910
##   Sch. Tribe     521       84  2241        910       2722
```

For example, `subnet` contains 3,118 edges between households in general castes and households in OBC castes.

We can measure the extent of assortative mixing by comparing `mix_mat` to the matrix we'd expect if edges were independent of caste.
This matrix equals the outer product of the row and column sums of `mix_mat`:

```r
mix_mat_indep = rowSums(mix_mat) %*% t(colSums(mix_mat))
```

Comparing the traces of `mix_mat` and `mix_mat_indep` allows us to measure mixing overall:

```r
tr = function(m) sum(diag(m))

c(tr(mix_mat), tr(mix_mat_indep))
```

```
## [1] 0.7313254 0.3598672
```

So `subnet` contains about twice as many within-caste edges than we'd expect if edges were independent of caste.

We can also compare `mix_mat` and `mix_mat_indep` element-wise to assess which inter-caste relationships are most over-represented:

```r
round(mix_mat / mix_mat_indep, 2)
```

```
##             
##              General Minority   OBC Sch. Caste Sch. Tribe
##   General       4.64     0.22  0.44       0.30       0.57
##   Minority      0.22    26.93  0.28       0.26       0.48
##   OBC           0.44     0.28  1.51       0.37       0.65
##   Sch. Caste    0.30     0.26  0.37       3.04       0.60
##   Sch. Tribe    0.57     0.48  0.65       0.60       6.15
```

So, for example, there are about 51% more OBC-OBC edges than we'd expect if edges were independent of caste, but less than half as many general-OBC edges.

