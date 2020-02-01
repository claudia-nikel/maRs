context("pressure.R") 
library(testthat)

test_that("data types correct", {
  p<-pressure(413,x)
  expect_is(typeof(p),'character')
})

test_that("second input argument is dataframe", {
  expect_error(pressure(413,12))
})
