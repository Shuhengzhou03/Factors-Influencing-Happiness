#### Preamble ####
# Purpose: Test the data sets
# Author: Shuheng (Jack) Zhou
# Date: November 27 2024
# Contact: shuhengzhou5@gmail.com
# License: MIT
# Pre-requisites: Run 02-download_data.R, 03-data_cleaning.R
# Any other information needed? None

# Load required packages
library(dplyr)
library(readr)
library(testthat)

# Load data
data <- read_csv("data/02-analysis_data/cleaned_happiness_data.csv")

# Begin tests
test_that("Dataset contains at least 100 rows", {
  expect_true(nrow(data) >= 100, info = "Fail: The dataset contains fewer than 100 rows")
})

test_that("All required columns are present", {
  required_columns <- c("realrinc", "happy", "satjob", "childs", "age", "degree", "sex", "marital")
  expect_true(all(required_columns %in% colnames(data)), 
              info = paste("Fail: The following columns are missing: ", 
                           paste(setdiff(required_columns, colnames(data)), collapse = ", ")))
})

test_that("All values in realrinc are non-negative", {
  expect_true(all(data$realrinc >= 0, na.rm = TRUE), 
              info = "Fail: realrinc contains negative values")
})

test_that("All values in childs are within the valid range (0 to 8)", {
  expect_true(all(data$childs >= 0 & data$childs <= 8, na.rm = TRUE), 
              info = "Fail: childs contains invalid values")
})

test_that("All values in age are within the valid range (18 to 120)", {
  expect_true(all(data$age >= 18 & data$age <= 120, na.rm = TRUE), 
              info = "Fail: age contains invalid values")
})

test_that("happy column contains only valid values", {
  valid_happy <- c("very happy", "pretty happy", "not too happy")
  expect_true(all(data$happy %in% valid_happy, na.rm = TRUE), 
              info = "Fail: happy column contains invalid values")
})

test_that("sex column contains only 'male' and 'female'", {
  valid_sex <- c("male", "female")
  expect_true(all(data$sex %in% valid_sex, na.rm = TRUE), 
              info = "Fail: sex column contains invalid values")
})

test_that("marital column contains only valid values (allowing NA)", {
  valid_marital <- c("married", "never married", "divorced", "widowed", "separated")
  expect_true(all(na.omit(data$marital) %in% valid_marital), 
              info = "Fail: marital column contains invalid values")
})

test_that("degree column contains only valid education levels (allowing NA)", {
  valid_degree <- c("high school", "bachelor's", "graduate", "no degree", 
                    "less than high school", "associate/junior college")
  expect_true(all(na.omit(data$degree) %in% valid_degree), 
              info = "Fail: degree column contains invalid values")
})

test_that("satjob column contains only valid job satisfaction levels (allowing NA)", {
  valid_satjob <- c("very satisfied", "moderately satisfied", "a little dissatisfied", "very dissatisfied")
  expect_true(all(na.omit(data$satjob) %in% valid_satjob), 
              info = "Fail: satjob column contains invalid values")
})
