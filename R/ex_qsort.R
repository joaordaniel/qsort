#'Example dataset
#'
#'An hypothetical dataset containing both CCQ and PQ Q-set data.
#'
#'Q-set items' scores (CCQ: columns 3 to 102, PQ: columns 103 to 174),
#'plus two identification columns: subject and a group (first two columns).
#'
#'For this example items were given random scores (1 to 9; least to most
#'characteristic respectively) following a rectangular distribution. For the CCQ
#'Q-set this corresponds to placing 11 items in each of the 9 categories, plus
#'an additional one in the center category (i.e., 12 items in category 5). For
#'the PQ Q-set all the 9 categories include 8 items.
#'
#' @format A data frame with 15 rows and 174 variables:
#'   \describe{
#'   \item{participant}{subject identification}
#'   \item{classroom}{group identification}
#'   \item{ccq1 to ccq100}{ccq items' scores}
#'   \item{pq1 to pq100}{pq items' scores} }
#'
"ex_qsort"
