context("marsInfo.R") #only need if testing in this script
library(testthat)

test_that("invalid API key", {
  expect_error(marsInfo("h"))
})     

#test_that("data types correct", {
  #x<-marsInfo("hecLCNM6NcwAGgGGWSW2xovr0SyYuXiOShVw6GxS")
  #expect_is(typeof(x),'character')
#})


#test_that("correct column names", {
  #x<-c("day", "First_UTC", "Last_UTC", "Season", "var", "AT", "HWS", "PRE")
  #y<-marsInfo("hecLCNM6NcwAGgGGWSW2xovr0SyYuXiOShVw6GxS")
  #expect_named(y, x)
#})

#test_that("correct type of data in Season column", {
  #x<-marsInfo("hecLCNM6NcwAGgGGWSW2xovr0SyYuXiOShVw6GxS")
  #expect_equal(typeof(x$Season),'character')
#})

#test_that("output is a data frame", {
  #x<-marsInfo("hecLCNM6NcwAGgGGWSW2xovr0SyYuXiOShVw6GxS")
  #expect_is(x,'data.frame')
#})

#test_that("correct dataframe size", {
  #x<-marsInfo("hecLCNM6NcwAGgGGWSW2xovr0SyYuXiOShVw6GxS")
  #expect_equal(dim(x), c(28, 8))
#})



#to test if OK or Failed in R console:
#test_file("test_marsInfo.R")

#library(covr)
#report()
