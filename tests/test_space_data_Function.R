source("../nasa_api_mars.R") #only need if testing in this script
library(testthat)

test_that("practice", {
  expect_error(space_data("h"))
})        


#to test if OK or Failed:
test_file("test_space_data_Function.R")