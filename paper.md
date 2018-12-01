---
title: 'qsort R package: A New Tool for Scoring Q-sort Data'
tags:
  - Q-set
  - criterion Q-sort scores
  - Q-sort scales
  - R
authors:
  - name: David N. Sousa
    orcid: 0000-0001-7277-6447
    affiliation: 1
  - name: João R. Daniel
    orcid: 0000-0001-6609-2014
    affiliation: 1
affiliations:
 - name: William James Center for Research, ISPA - Instituto Universitário
   index: 1
date: 19 August 2018
bibliography: paper.bib
---

# Summary

The use of Q-sets to describe subjective views on a specific research domain, in a way suitable for quantitative data analysis, has a long tradition in developmental psychology research. In this field, Q-sets generally consist of a large set of items, usually sentences printed on separate cards, that describe personality and behavioral characteristics. These items are sorted into a different number of numerical categories (e.g., 9) based on their salience as descriptors of an individual (e.g., 1- most uncharacteristic to 9- most characteristic). An individual Q-sort (i.e., the scores of all items descriptive of an individual) can then be compared (correlated) with criteria Q-sorts (description of a hypothetical person at the extreme high end of a domain) to index a score for a particular domain. Also, subsets of items can be averaged to derive a scale score [@Block1961, @Block1969, @Block1980, @John2014, @Vaughn2014]. In this paper we present an R package that computes scores from criteria Q-sorts and item scales as traditionally used in developmental psychology research.

The ``qsort`` package includes descriptions and scoring procedures for four commonly used Q-sets: Attachment Q-set (version 3.0) [@Waters1995], California Child Q-set [@Block1969], Maternal Behaviour Q-set (version 3.1) [@Pederson1999], and Preschool Q-set [@Baumrind1968] revised by Wanda Bronson).

The package contains seven objects: 

* `ex_qsort` - example Q-sort datasets for the four different Q-sets: aqs, ccq, mbqs, pq.
* `qsets_aqs`, `qsets_ccq`, `qsets_mbqs`, and `qsets_pq` - four different datasets containing items descriptions, criteria socres and/or scales for the corresponding Q-set.
* `qsort_score` -  a function to compute scores for Q-sort data using the criteria scores and/or scales from the **qsets** datasets.
* `print_cards`  - a function to create a .pdf file with items' descriptions printed in separate cards.

Each Q-set dataset includes: (1) a column with item numbers, (2) a column with Q-set initials, (3) a column with item description, (4) plus a variable number of columns according to available criteria sorts and scales. The **aqs** dataset includes: (1) security criterion scores, (2) dependency criterion scores, (3) [@Pederson1995] scales; compliance, secure base, fussy/difficult, enjoys physical contact, affective sharing, (4) and [@Posada1995] scales; smooth interactions with mother, physical contact with mother, interactions with other adults, proximity to mother. The **ccq** dataset includes scores of five criteria Q-sorts: (1) social competence criterion scores (2) self-esteem criterion scores (3) ego-resiliency criterion scores, (4) ego-control criterion scores, (5) social desirability criterion scores, and (6) emotion regulation scale scores retrieved from [shields1997emotion]. Ego-resiliency and ego-control criteria scores data for this dataset was retrieved from [@Waters1985] and from Brian Vaughn (personal communication). The **mbqs** dataset includes scores of one criterion Q-sort: (1) sensibility criterion scores. The data for this dataset was retrieved from [@Pederson1999]. Finally the **pq** dataset includes scores of three criteria Q-sorts: (1) social competence, (2) self-esteem, and (3) social desirability. The data for this dataset was retrieved from [@Waters1985].

[@Waters1985] analysis of the discriminant validity of related constructs in the California Child Q-set [@Block1969] and the Preschool Q-set [@Baumrind1968] revised by Wanda Bronson) indicate that social desirability scores should be used to control for response bias when computing participants' scores (correlations) from criterion scores. Response bias in Q-sorts can occur when observers, confronted with two equally descriptive items of a participant, place one of the items higher (or lower) in the sort because it is more (or less) socially acceptable. Thus, the authors state that participant's scores are best indexed by a partial correlation between her/his Q-sort description and the criterion Q-sort, controlling for social desirability. The ``qsets_ccq`` and ``qsets_pq`` datasets include social desirability criterion scores. For these two Q-sets (**ccq** and **pq**) the ``qsort_score`` function will compute partial correlations between individual Q-sorts and criteria Q-sorts' scores, controlling for social desirability. 

The following installs and loads ``qsort`` package:

```
  # install qsort from CRAN
  install.packages("qsort")

  # load qsort
  library(qsort)
```

# Examples

The ``qsort_score`` function uses the criteria scores and/or scales from the ``qsets`` datasets to compute scores for Q-sort data. The following applies the ``qsort_score`` function to ``ex_qsort$ccq`` and stores the output data frame in ``data_ccq``. 

```
R> data_ccq <- qsort_score(ex_qsort$ccq, qset_ccq, qsort_length = 100, item1 = "ccq1", subj_id = "participant", group_id = "classroom")

R> data_ccq

   participant classroom scomp_c sest_c egores_c egocont_c sdes_c partial_scomp_c
1            1         1  -0.074 -0.093   -0.145    -0.012 -0.137           0.113
2            2         1  -0.023  0.008    0.090     0.157  0.053          -0.160
3            3         1   0.092  0.086    0.112    -0.021  0.132          -0.061
4            4         1  -0.105 -0.113   -0.182    -0.128 -0.160           0.088
5            5         1  -0.010 -0.039   -0.092    -0.092 -0.053           0.085
6            6         2  -0.104 -0.079   -0.042     0.156 -0.089          -0.054
7            7         2   0.051  0.079    0.168     0.169  0.124          -0.139
8            8         2   0.049  0.066    0.153     0.185  0.118          -0.130
9            9         2  -0.024 -0.007    0.009    -0.026  0.007          -0.069
10          10         2  -0.039 -0.046   -0.033     0.098 -0.042          -0.003
   partial_sest_c partial_egores_c partial_egocont_c shields_s_emreg
1           0.047           -0.054            -0.007             4.3
2          -0.073            0.086             0.155             5.9
3          -0.053           -0.002            -0.026             5.1
4           0.047           -0.089            -0.123             3.7
5           0.012           -0.090            -0.090             4.4
6          -0.004            0.068             0.160             5.7
7          -0.053            0.121             0.166             5.9
8          -0.068            0.101             0.182             5.9
9          -0.026            0.004            -0.026             5.0
10         -0.019            0.005             0.100             5.2
```
For details about the ``qsort_score`` function usage type ``?qsort_score``. The first two columns of ``data_ccq`` correspond to **qset**, **participant** and **classroom** identification variables; the remaining columns refer to correlation values computed from correlating individual Q-sorts with the criteria Q-sorts' scores (present in ``qsets_ccq``). The names of these columns follow the column names in ``qsets_ccq`` datasets (e.g., social competence- **scomp_c**, self-esteem- **sest_c**, etc.). Variable names are detailed in the help files of the different **qsets**. Scores obtained from partial correlations controlled by social desirability correspond to columns in the output data frame with names starting with **partial_**. 

To create a .pdf file where items' descriptions are printed in separate cards, the `print_cards` function can be used as in the following example:

```
R> print_cards(qset = "aqs", desc_col = "description", dir.print = getwd())
```

This creates a .pdf file, in in the working directory, with Attachment Q-set item cards.

For further details on how to use the functions provided and the Q-set datasets contained in the ``qsort`` package type `help(qsort)`. At the moment, ``qsort`` package only analyses data for four different Q-sets, but it can be easily updated to extend its capabilities to other Q-sets scored from scales or criteria scores. We believe this tool to be of great interest and utility for developmental psychology researchers and we invite them to contribute with new or updated versions of existing Q-sets, criterion scores and derived scales.

# References
