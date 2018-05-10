#' qsort_score
#'
#' qsort_score returns social competence and self-esteem scores (partial
#' correlations) for California Child Q-set (CCQ; Block and Block, 1969) or
#' Preschool Q-set data (PQ; Baumrind, 1968 revised by Wanda Bronson) using the
#' criterion scores presented in Waters et al. (1985), while controlling for
#' social desirability.
#'
#' @param x a data frame. x should be in wide format, with each subject data in
#'   one row and the scores for CCQ and PQ items in different columns. CCQ and
#'   PQ column names should be named sequentially from ccq1 to ccq100 and/or
#'   from pq1 to pq72 (both CCQ and PQ Q-sort data can coexist in the same data
#'   frame). qsort_score function is case insensitive for item column names
#'   (i.e., CCQ1 or ccq1 will both work), but there should be no spaces in
#'   column names. Q-set items should be scored 1 to 9 (most uncharacteristic to
#'   most characteristic of the subject).
#' @param qset either qset = "pq" or qset = "ccq".
#' @param subj_id optional. Column name of x that includes subjects'
#'   identification codes.
#' @param group_id optional. Column name of x that includes groups'
#'   identification codes.
#'
#' @return a data frame. data frame will have 4 to 6 columns: subject id -
#'   (optional) subject identification; group id - (optional) group
#'   identification; scomp - social competence scores; sest - self-esteem
#'   scores; missing - number of missing item scores in x (if any); qset - q set
#'   identification.
#' @export
#'
#' @examples
#' data_ccq <- qsort_score(ex_qsort,
#'                         qset = "ccq",
#'                         subj_id = "participant",
#'                         group_id = "classroom")
#' data_ccq
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
qsort_score <- function(x, qset = c("pq", "ccq"), subj_id = NULL, group_id = NULL) {
  # 1st: create an empty data frame (qsort_data) to store data
  # 2nd: subset criterion data frame according to qset argument
  # 3rd: identify the column number of pq1 or ccq1 in x
  # 4th: identify the column number of pq72 or ccq100 in x
  # 5th: create a selection vector with column numbers pq1-pq72 or ccq1-ccq100
  qsort_data <- data.frame()
  temp_c <- criterion[grepl(qset, criterion$qset), ]
  start_c <- match(paste(qset, 1, sep = ""), tolower(colnames(x)))
  end_c <- ifelse (qset == "pq",
                  match("pq72", tolower(colnames(x))),
                  match("ccq100", tolower(colnames(x))))
  sel <- start_c : end_c

  parcor <- function(a, b, c) {
    # parcor is the core of qsort_score function
    # the 3 arguments are automatically defined in the for cycle bellow
    # a - q-sort data for one participant
    # b - social competence or self-esteem criterion scores
    # c - social desirability criterion scores
    # computes partial correlation scores from pairwise correlations
    # output is the score computed from the last line of the function
    cor_ab <- cor(a, b, use = "pairwise.complete.obs")
    cor_ac <- cor(a, c, use = "pairwise.complete.obs")
    cor_bc <- cor(b, c, use = "pairwise.complete.obs")
    (cor_ab - cor_ac * cor_bc) / (sqrt(1 - cor_ac^2) * sqrt(1 - cor_bc^2))
  }

  for (i in 1:nrow(x)) {
    # for every line in data frame x
    # 1st: compute social competence scores
    # 2nd: compute self-esteem scores
    # 3rd: bind the different scores together
    # social competence and self-esteem scores are rounded to 4 digits
    # 4th: add a line of data to qsort_data data frame
    scomp <- parcor(t(x[i, sel]), temp_c$scomp_c, temp_c$sdes_c)
    sest <- parcor(t(x[i, sel]), temp_c$sest_c, temp_c$sdes_c)
    temp_data <- cbind.data.frame(x[i, subj_id],
                                  x[i, group_id],
                                  round(scomp, digits = 4),
                                  round(sest, digits = 4),
                                  sum(is.na(x[i, sel])),
                                  qset)
    qsort_data <- rbind.data.frame(qsort_data,temp_data)
  }
  # name qsort_data columns
  colnames(qsort_data) <- c(subj_id, group_id, "scomp", "sest", "missing", "qset")
  # return
  print(qsort_data)
}
