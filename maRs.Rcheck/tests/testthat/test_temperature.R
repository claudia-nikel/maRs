context("temperature.R") 
library(testthat)


test_that("second input argument is dataframe", {
  expect_error(temperature(413,12))
})
