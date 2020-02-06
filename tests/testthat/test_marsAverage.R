context("marsAverage.R") #only need if testing in this script
library('testthat')
library('testthat')
library('jsonlite')
library('purrr')
library('dplyr')
library('tidyr')
library('plotly')

test_that("data types correct", {
  x<-marsInfo("hecLCNM6NcwAGgGGWSW2xovr0SyYuXiOShVw6GxS")
  s<-marsAverage(x)
  expect_is(typeof(s),'character')
})


test_that("correct column names", {
  n<-c("sol", "atm_temp", "horiz_windspeed", "atm_pres")
  x<-marsInfo("hecLCNM6NcwAGgGGWSW2xovr0SyYuXiOShVw6GxS")
  s<-marsAverage(x)
  expect_named(s, n)
})

test_that("correct type of data in sol column", {
  x<-marsInfo("hecLCNM6NcwAGgGGWSW2xovr0SyYuXiOShVw6GxS")
  s<-marsAverage(x)
  expect_equal(typeof(s$sol),'integer')
})

test_that("output is a data frame", {
  x<-marsInfo("hecLCNM6NcwAGgGGWSW2xovr0SyYuXiOShVw6GxS")
  s<-marsAverage(x)
  expect_is(s,'data.frame')
})

test_that("correct dataframe size", {
  x<-marsInfo("hecLCNM6NcwAGgGGWSW2xovr0SyYuXiOShVw6GxS")
  s<-marsAverage(x)
  expect_equal(dim(s), c(7, 4))
})

test_that("first input argument is dataframe", {
  expect_error(marsAverage(12))
})


#to test if OK or Failed in R console:
#test_file("test_marsAverage.R")