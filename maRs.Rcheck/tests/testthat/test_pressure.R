context("pressure.R") 
library('testthat')


test_that("second input argument is dataframe", {
  expect_error(pressure(413,12))
})
