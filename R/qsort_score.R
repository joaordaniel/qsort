#'qsort_score
#'
#'qsort_score returns a data frame with scores derived from criteria Q-sorts and
#'from scales created from subsets of items.
#'
#'@param x data frame. x should be in wide format, with each subject data in
#'  one row and the scores for qset items in different columns. Columns with
#'  qset item scores should be ordered sequentially from item 1 to the last
#'  item.
#'@param qset "aqs" for Attachment Q-set (version 3.0) (Waters, 1995); "ccq" for
#'  California Child Q-set (Block & Block, 1969); "mbqs" for Maternal
#'  Behaviour Q-set (version 3.1) (Pederson et al., 1999); and "pq" for
#'  Preschool Q-set (Baumrind, 1968 revised by Wanda Bronson).
#'@param item1 column name of x containing item 1 qset score
#'@param subj_id optional. Column name of x with subjects' identification codes.
#'@param group_id optional. Column name of x with groups' identification codes.
#'
#'@return a data frame. This data frame will have a varying number of columns
#'  depending on the number of available criteria sorts and scales for the
#'  selected qset. Column names ending in "_c" refer to criteria sorts' scores, while
#'  column names ending in "_s" refer to scales' scores. The different types of criteria
#'  sorts and scales for each qset can be consulted in the documentation of
#'  qsets object (?qsets).
#'
#'@export
#'
#'@examples
#'data_ccq <- qsort_score(ex_qsort$ccq,
#'                        qset = "ccq",
#'                        item1 = "ccq1",
#'                        subj_id = "participant",
#'                        group_id = "classroom")
#'data_ccq
#'
#'data_aqs <- qsort_score(ex_qsort$aqs,
#'                        qset = "aqs",
#'                        item1 = "aqs1")
#'
#'@references Baumrind, D. (1968). Manual for the Preschool Behaviour Q-set.
#'  Parental Research Project. Berkeley, CA: Institute of Human Development,
#'  University of California.
#'
#'  Block, J. H., & Block, J. (1969). The California Child Q-Set. Berkeley, CA:
#'  Institute of Human Development, University of California.
#'
#'  Pederson, D. R., Moran, G., & and Bento, S. (1999). Maternal Behaviour
#'  Q-sort (version 3.1). London, ON: Psychology Department, Western University.
#'
#'  Waters, E. (1995). Appendix A: The attachment Q-set (Version 3. 0).
#'  Monographs of the Society for Research in Child Development, 60, 234–246.

qsort_score <- function(x, qset = names(qsets), item1, subj_id = NULL, group_id = NULL) {
# store number of items of each qset
  qsort_length <- c(90, 100, 72, 90)
  names(qsort_length) <- c("aqs", "ccq", "pq", "mbqs")

# create a selection vector with column numbers of x qset items
  start_x <- match(item1, (colnames(x)))
  end_x <- start_x + qsort_length[[qset]] - 1
  sel_x <- start_x : end_x

# identify criteria scores' column(s) in selected qset
# column names ending in "_c"
  cscores <- grep("_c$", names(qsets[[qset]]), value = T)

# identify scales' column(s) in selected qset
# column names ending in "_s"
  scales <- grep("_s$", names(qsets[[qset]]), value = T)

# identify column(s) detailing items to be inverted for scale computation
# column names ending in "_inv"
  scales_inv <- grep("_inv$", names(qsets[[qset]]), value = T)

# create an empty data frame to store output values
  qsort_data <- data.frame()

  for(i in 1:nrow(x)){
# for all rows/cases in x
# first create empty data frames to store temporary values used in the computations below
    temp_id <- cbind.data.frame(qset, x[i, subj_id], x[i, group_id])
    names(temp_id) <- c("qset", subj_id, group_id)
    temp_cs <- data.frame()[1, ]
    temp_s <- data.frame()[1,]
    temp_s3 <- data.frame()[1, ]

    if(length(cscores) > 0){
# if selected qset contains criteria scores
      for(j in 1:length(cscores)){
# compute the correlation between the individual profile and each criterion sort
# store correlation values in j number of columns in temp_cs
# and name them accordingly
        temp_cs[1, j] <- cor(t(x[i, sel_x]),
                         qsets[[qset]][ , cscores[[j]]],
                         use = "pairwise.complete.obs")
      }
      names(temp_cs) <- cscores

      if("sdes_c" %in% cscores){
# if one of the criteria sorts corresponds to social desirability
        cscores2 <- cscores[cscores != "sdes_c"]
        for(k in 1:length(cscores2)){
# compute partial correlations between the individual profile data and each criterion sort,
# while controlling for social desirability
# add partial correlation values to temp_cs
# and name columns accordingly
          cor_ab <- temp_cs[cscores2[[k]]]
          cor_ac <- temp_cs["sdes_c"]
          cor_bc <- cor(qsets[[qset]][ , cscores2[[k]]],
                           qsets[[qset]][ , "sdes_c"],
                           use = "pairwise.complete.obs")

          temp_cs[1, (length(cscores) + k)] <- (cor_ab - cor_ac * cor_bc) /
                                                (sqrt(1 - cor_ac^2) * sqrt(1 - cor_bc^2))
        }
        names(temp_cs) <- c(cscores, paste("partial_", cscores2, sep =""))
      }
    }

    if(length(scales) > 0){
# if selected qset contains scales
      for(j in 1:length(scales)){
# match individual profile data with columns indicating scales' items
# and which items need to be inverted
        temp_s <- cbind(t(x[i, sel_x]),
                        qsets[[qset]][ , scales[j]],
                        qsets[[qset]][ , scales_inv[j]])
        names(temp_s) <- c("row", scales[j], scales_inv[j])

# invert scores
        temp_s$row[!is.na(temp_s[ , 3])] <- 10 - temp_s$row[!is.na(temp_s[ , 3])]

# compute scores for each scale
        temp_s <- plyr::ddply(temp_s, scales[j],summarise, mean(row, na.rm = T))
        temp_s <- temp_s[!is.na(temp_s[[1]]), ]

# store each score in a separate column of temp_s2
# name them accordingly
        temp_s2 <- as.data.frame(t(temp_s[[2]]))
        names(temp_s2) <- paste(scales[j], "_", temp_s[[1]], sep = "")

# bind scores for all scales presented in selected qset
        temp_s3 <- cbind.data.frame(temp_s3, temp_s2)
      }
    }

# bind each case identification columns (if given),
# correlation values computed from criteria sorts,
# and scale scores
    temp_data <- cbind.data.frame(temp_id, temp_cs, temp_s3)

# add a row to output data frame
    qsort_data <- rbind(qsort_data, temp_data)
  }

  row.names(qsort_data) <- NULL

# round numeric variables to three digits
  qsort_data <- purrr::modify_if(qsort_data, ~is.numeric(.), ~round(., 3))

# return output
  qsort_data
}
