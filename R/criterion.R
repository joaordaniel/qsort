#' Waters et al. (1985) criterion scores
#'
#' A dataset containing Waters et al.'s (1985) social competence, self-esteem
#' and social desirability criterion scores for the California Child Q-set (CCQ;
#' Block and Block, 1969) and the Preschool Q-set (PQ; Baumrind, 1968 revised by
#' Wanda Bronson). Q-set items are scored 1 to 9 (most uncharacteristic to most
#' characteristic of the respective domain). Originally Waters et al. (1985)
#' scored the most characteristic items as 1 and the least characteristic ones
#' as 9. Here we inverted the scores to be more intuitive. qsort_score function
#' uses this dataset to compute social competence and self-esteem scores.
#' Consequently, changes made in this dataset will affect qsort_score output. We
#' made a few corrections to Water et al.'s (1985) items' numbers and
#' descriptions: (1) CCQ item numbers 15 and 96 appear repeated twice - "Shows
#' concerns for moral issues (reciprocity, fairness)" is now CCQ item number 25,
#' and "Is verbally fluent" is now CCQ item 69; (2) PQ item 23 now reads "Other
#' children seek his company", instead of "Other children seldom seek his
#' company".
#'
#' @format A data frame with 172 rows and 6 variables: \describe{
#'   \item{item}{item number, ranging from 1 to 100 for CCQ items and 1 to 72
#'   for PQ items} \item{qset}{ccq - California Child Q-set; pq - Preschool
#'   Q-set} \item{scomp_c}{social competence criterion scores}
#'   \item{sest_c}{self-esteem competence criterion scores} \item{sdes_c}{social
#'   desirability criterion scores} \item{description}{item description} }
#'
#' @references Baumrind, D. (1968). Manual for the Preschool Behaviour Q-set.
#'   Parental Research Project. Berkeley, CA: Institute of Human Development,
#'   University of California.
#'
#'   Block, J. H., & Block, J. (1969). The California Child Q-Set. Berkeley, CA:
#'   Institute of Human Development, University of California.
#'
#'   Waters, E., Noyes, D. M., Vaughn, B. E., & Ricks, M. (1985). Q-sort
#'   definitions of social competence and self-esteem: Discriminant validity of
#'   related constructs in theory and data. Developmental Psychology, 21,
#'   508-522.
#'
"criterion"
