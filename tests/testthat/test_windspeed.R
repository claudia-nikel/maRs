context("windspeed.R") 
library(testthat)

test_that("data types correct", {
  w<-windspeed(413,x)
  expect_is(typeof(w),'character')
})

test_that("second input argument is dataframe", {
  expect_error(windspeed(413,12))
})


