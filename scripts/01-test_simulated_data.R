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


# Load necessary packages
library(dplyr)
library(readr)
library(arrow)

# Load the simulated data
simulated_data <- read_parquet("data/00-simulated_data/predicting_happiness.parquet")

# Define a test function
check <- function(condition, success_msg, fail_msg) {
  if (condition) {
    message(success_msg)
  } else {
    stop(fail_msg)
  }
}

#### Data Testing ####

# Test 1: Check the number of rows
check(
  nrow(simulated_data) == 1000,
  "Pass: The dataset contains exactly 1000 rows",
  "Fail: The dataset does not contain 1000 rows"
)

# Test 2: Check if all required columns exist
required_columns <- c("year", "marital", "childs", "age", "degree", "sex", "happy", "satjob", "realrinc", "ballot")
check(
  all(required_columns %in% colnames(simulated_data)),
  "Pass: All required columns are present",
  paste("Fail: The following columns are missing: ", paste(setdiff(required_columns, colnames(simulated_data)), collapse = ", "))
)

# Test 3: Check if year column is correctly set to 2016
check(
  all(simulated_data$year == 2016),
  "Pass: All rows in the year column are set to 2016",
  "Fail: Not all rows in the year column are set to 2016"
)

# Test 4: Check if childs column is within the valid range (0 to 5)
check(
  all(simulated_data$childs >= 0 & simulated_data$childs <= 5, na.rm = TRUE),
  "Pass: All values in the childs column are within the range 0 to 5",
  "Fail: The childs column contains values outside the range 0 to 5"
)

# Test 5: Check if age column is within the valid range (18 to 80)
check(
  all(simulated_data$age >= 18 & simulated_data$age <= 80, na.rm = TRUE),
  "Pass: All values in the age column are within the range 18 to 80",
  "Fail: The age column contains values outside the range 18 to 80"
)

# Test 6: Check if happy column contains only valid values
valid_happy <- c("Very happy", "Pretty happy", "Not too happy")
check(
  all(simulated_data$happy %in% valid_happy),
  "Pass: The happy column contains only valid values",
  "Fail: The happy column contains invalid values"
)

# Test 7: Check if satjob column contains only valid job satisfaction levels
valid_satjob <- c("very satisfied", "moderately satisfied", "a little dissatisfied", "very dissatisfied")
check(
  all(simulated_data$satjob %in% valid_satjob),
  "Pass: The satjob column contains only valid values",
  "Fail: The satjob column contains invalid values"
)

# Test 8: Check if realrinc column is within the valid range (1000 to 150000)
check(
  all(simulated_data$realrinc >= 1000 & simulated_data$realrinc <= 150000, na.rm = TRUE),
  "Pass: All values in the realrinc column are within the range 1000 to 150000",
  "Fail: The realrinc column contains values outside the range 1000 to 150000"
)

# Test 9: Check if sex column contains only "Male" and "Female"
valid_sex <- c("Male", "Female")
check(
  all(simulated_data$sex %in% valid_sex),
  "Pass: The sex column contains only valid values",
  "Fail: The sex column contains invalid values"
)

# Test 10: Check if marital column contains only valid marital statuses
valid_marital <- c("Married", "Never married", "Divorced", "Widowed", "Separated")
check(
  all(simulated_data$marital %in% valid_marital),
  "Pass: The marital column contains only valid values",
  "Fail: The marital column contains invalid values"
)

# Test 11: Check if degree column contains only valid education levels
valid_degree <- c("High school", "Bachelor's", "Graduate", "No degree", "Less than high school", "Associate/junior college")
check(
  all(simulated_data$degree %in% valid_degree),
  "Pass: The degree column contains only valid values",
  "Fail: The degree column contains invalid values"
)

# Test 12: Check if ballot column contains only valid ballot types
valid_ballot <- c("Ballot a", "Ballot b", "Ballot c")
check(
  all(simulated_data$ballot %in% valid_ballot),
  "Pass: The ballot column contains only valid values",
  "Fail: The ballot column contains invalid values"
)
