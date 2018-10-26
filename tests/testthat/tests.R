data_ccq <- qsort_score(ex_qsort$ccq, qset_ccq, qsort_length = 100, item1 = "ccq1", subj_id = "participant", group_id = "classroom")

data_aqs <- qsort_score(ex_qsort$aqs, qset_aqs, qsort_length = 90, item1 = "aqs1", subj_id = "participant", group_id = "classroom")

data_mbqs <- qsort_score(ex_qsort$mbqs, qset_mbqs, qsort_length = 90, item1 = "mbqs1", subj_id = "participant", group_id = "classroom")

data_pq <- qsort_score(ex_qsort$pq, qset_pq, qsort_length = 72, item1 = "pq1", subj_id = "participant", group_id = "classroom")

test_that("All output datasets are of type list", {
  expect_equal(typeof(data_ccq),"list")
  expect_equal(typeof(data_aqs),"list")
  expect_equal(typeof(data_mbqs),"list")
  expect_equal(typeof(data_pq),"list")
})

test_that("All output datasets have the expected dimensions", {
  expect_equal(dim(data_ccq),c(10,12))
  expect_equal(dim(data_aqs),c(10,13))
  expect_equal(dim(data_mbqs),c(10,3))
  expect_equal(dim(data_pq),c(10,7))
})