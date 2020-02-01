context("temperature.R") 
library(testthat)

test_that("data types correct", {
  t<-temperature(413,x)
  expect_is(typeof(t),'character')
})

test_that("second input argument is dataframe", {
  expect_error(temperature(413,12))
})
