context("windspeed.R") 
library(testthat)


test_that("second input argument is dataframe", {
  expect_error(windspeed(413,12))
})


