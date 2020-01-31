source("../maRs/marsAverage.R") #only need if testing in this script
library(testthat)

test_that("data types correct", {
  s<-marsAverage(x, graph=NULL)
  expect_is(typeof(s),'character')
})


test_that("correct column names", {
  n<-c("sol", "atm_temp", "horiz_windspeed", "atm_pres")
  s<-marsAverage(x, graph=NULL)
  expect_named(s, n)
})

test_that("correct type of data in sol column", {
  s<-marsAverage(x, graph=NULL)
  expect_equal(typeof(s$sol),'integer')
})

test_that("output is a data frame", {
  s<-marsAverage(x, graph=NULL)
  expect_is(s,'data.frame')
})

test_that("correct dataframe size", {
  s<-marsAverage(x, graph=NULL)
  expect_equal(dim(s), c(7, 4))
})

#to test if OK or Failed in R console:
#test_file("test_marsAverage.R")