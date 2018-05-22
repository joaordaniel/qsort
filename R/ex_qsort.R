#'Example datasets
#'
#'A list containing four hypothetical Q-sort datasets.
#'
#'For these examples, items were given random scores (1 to 9; least to most
#'characteristic respectively) following a rectangular distribution. For the CCQ
#'Q-set this corresponds to placing 11 items in each of the 9 categories, plus
#'an additional one in the center category (i.e., 12 items in category 5). For
#'the remaining Q-sets all the 9 categories include the same number of items
#'(AQS = 10, MBQS = 10, PQ = 8).
#'
#' @format Data frames with 10 rows and a variable number of columns, depending
#'   on the number of Q-set items (AQS = 90, CCQ = 100, MBQS = 90, PQ = 72)
#'   \describe{
#'   \item{participant}{Subject identification.}
#'   \item{classroom}{Group identification.}
#'   \item{qset1 to ...}{Items' scores.}
#'   }
#'
"ex_qsort"
