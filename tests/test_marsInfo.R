source("../functions/marsInfo.R") #only need if testing in this script
library(testthat)

test_that("invalid API key", {
  expect_error(marsInfo("h"))
})        


#to test if OK or Failed in R console:
#test_file("test_marsInfo.R")


