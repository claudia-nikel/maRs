source("../nasa_api_mars.R") #only need if testing in this script
library(testthat)

test_that("practice", {
  expect_error(space_data("hecLCNM6NcwAGgGGWSW2xovr0SyYuXiOhVw6GxS"))
})


#to test in R console use:
#testthat::test_dir(“tests”) 