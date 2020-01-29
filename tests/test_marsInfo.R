source("../functions/marsInfo.R") #only need if testing in this script
library(testthat)

test_that("invalid API key", {
  expect_error(marsInfo("h"))
})     

test_that("data types correct", {
  expect_is(typeof(marsInfo("hecLCNM6NcwAGgGGWSW2xovr0SyYuXiOShVw6GxS")),'character')
})


#to test if OK or Failed in R console:
#test_file("test_marsInfo.R")


