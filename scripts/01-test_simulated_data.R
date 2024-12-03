#### Preamble ####
# Purpose: Tests the structure and validity of the simulated happiness dataset.
# Author: Shuheng (Jack) Zhou
# Date: November 26 2024
# Contact: shuhengzhou5@gmail.com
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? None 


#### Workspace Setup ####
library(dplyr)
library(readr)
library(arrow)
library(testthat)

#### Load the Simulated Data ####
simulated_data <- read_parquet("data/00-simulated_data/predicting_happiness.parquet")

#### Begin Tests ####

# Test 1: Check the number of rows
test_that("Dataset contains exactly 1000 rows", {
  expect_equal(nrow(simulated_data), 1000)
})

# Test 2: Check if all required columns exist
test_that("All required columns are present", {
  required_columns <- c("year", "marital", "childs", "age", "degree", "sex", "happy", "satjob", "realrinc", "ballot")
  expect_true(all(required_columns %in% colnames(simulated_data)),
              info = paste("Missing columns:", paste(setdiff(required_columns, colnames(simulated_data)), collapse = ", ")))
})

# Test 3: Check if year column is set to 2016
test_that("Year column is set to 2016", {
  expect_true(all(simulated_data$year == 2016))
})

# Test 4: Check if number of children is valid
test_that("Childs column values are in the range 0-5 for married individuals and 0-3 otherwise", {
  married_condition <- simulated_data$marital == "Married"
  unmarried_condition <- simulated_data$marital != "Married"
  expect_true(all(simulated_data$childs[married_condition] >= 0 & simulated_data$childs[married_condition] <= 5))
  expect_true(all(simulated_data$childs[unmarried_condition] >= 0 & simulated_data$childs[unmarried_condition] <= 3))
})

# Test 5: Check if age column is within valid range
test_that("Age column values are within the range 18-80", {
  expect_true(all(simulated_data$age >= 18 & simulated_data$age <= 80))
})


# Test 6: Check if job satisfaction aligns with real income
test_that("Job satisfaction aligns with real income", {
  income_levels <- cut(simulated_data$realrinc,
                       breaks = c(-Inf, 30000, 60000, 90000, Inf),
                       labels = c("very dissatisfied", "a little dissatisfied", "moderately satisfied", "very satisfied"))
  expect_true(all(simulated_data$satjob == as.character(income_levels)))
})

# Test 7: Check if ballot column contains valid categories
test_that("Ballot column contains only valid values", {
  valid_ballots <- c("Ballot a", "Ballot b", "Ballot c")
  expect_true(all(simulated_data$ballot %in% valid_ballots))
})

