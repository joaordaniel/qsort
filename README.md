<!-- README.md is generated from README.Rmd. Please edit that file -->
qsort
=====

Overview
--------

`qsort` is a package that allows scoring Q-sort data, using criteria sorts and derived scales from subsets of items. This package includes descriptions and scoring procedures for four different Q-sets:
Attachment Q-set (version 3.0) (Waters, 1995);
California Child Q-set (Block & Block, 1969);
Maternal Behaviour Q-set (version 3.1) (Pederson et al., 1999);
Preschool Q-set (Baumrind, 1968 revised by Wanda Bronson).

qsort package includes 3 objects:
\* `qsort_score()` a function for scoring Q-sort data;
\* `qsets` a list with four data frames used in `qsort_score()`, containing criterion scores and scales for the referred Q-sets;
\* `ex_qsort` a list containing four example data frames for the referred Q-sets.

Access `qsets` help file (`?qsets`) to learn more about which criteria sorts and scales included for each Q-set.

Installation
------------

The qsort package can be installed from GitHub:

``` r
# to install packages from github you first need to install devtools package from CRAN.
# if you haven't done so already just type
# install.packages("devtools")
devtools::install_github("joaordaniel/qsort")
```

Example
-------

The example bellow shows how to use `qsort_score()` function to compute scores from California Child Q-sort data, present in `ex_qsort` datasets (`ex_qsort$ccq`).

``` r
library(qsort)
data_ccq <- qsort_score(ex_qsort$ccq, qset = "ccq", item1 = "ccq1", subj_id = "participant", group_id = "classroom")
data_ccq
```

    ##    qset participant classroom scomp_c sest_c egores_c egocont_c sdes_c
    ## 1   ccq           1         1  -0.074 -0.093   -0.145    -0.012 -0.137
    ## 2   ccq           2         1  -0.023  0.008    0.090     0.157  0.053
    ## 3   ccq           3         1   0.092  0.086    0.112    -0.021  0.132
    ## 4   ccq           4         1  -0.105 -0.113   -0.182    -0.128 -0.160
    ## 5   ccq           5         1  -0.010 -0.039   -0.092    -0.092 -0.053
    ## 6   ccq           6         2  -0.104 -0.079   -0.042     0.156 -0.089
    ## 7   ccq           7         2   0.051  0.079    0.168     0.169  0.124
    ## 8   ccq           8         2   0.049  0.066    0.153     0.185  0.118
    ## 9   ccq           9         2  -0.024 -0.007    0.009    -0.026  0.007
    ## 10  ccq          10         2  -0.039 -0.046   -0.033     0.098 -0.042
    ##    partial_scomp_c partial_sest_c partial_egores_c partial_egocont_c
    ## 1            0.113          0.047           -0.054            -0.007
    ## 2           -0.160         -0.073            0.086             0.155
    ## 3           -0.061         -0.053           -0.002            -0.026
    ## 4            0.088          0.047           -0.089            -0.123
    ## 5            0.085          0.012           -0.090            -0.090
    ## 6           -0.054         -0.004            0.068             0.160
    ## 7           -0.139         -0.053            0.121             0.166
    ## 8           -0.130         -0.068            0.101             0.182
    ## 9           -0.069         -0.026            0.004            -0.026
    ## 10          -0.003         -0.019            0.005             0.100

Access `qsort_score` help file (`?qsort_score`) to learn more about the function's four arguments, and `qsets` help file (`?qsets`) to learn more about variables' names.

References
----------

Baumrind, D. (1968). Manual for the Preschool Behaviour Q-set. Parental Research Project. Berkeley, CA: Institute of Human Development.
Block, J. H., & Block, J. (1969). The California Child Q-Set. Berkeley, CA: Institute of Human Development, University of California.
Pederson, D. R., Moran, G., & and Bento, S. (1999). Maternal Behaviour Q-sort (version 3.1). London, ON: Psychology Department, Western University.
Waters, E. (1995). Appendix A: The attachment Q-set (Version 3. 0). Monographs of the Society for Research in Child Development, 60, 234-246.