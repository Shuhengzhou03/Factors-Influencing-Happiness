#### Preamble ####
# Purpose: Cleans the raw happiness survey data from the General Social Survey (GSS) for analysis.
# Author: Shuheng (Jack) Zhou
# Date: 
# Contact: shuhengzhou5@gmail.com
# License: MIT
# Pre-requisites: Have raw data downloaded in the data file
# Any other information needed? None

# Load necessary packages
library(dplyr)
library(readr)
library(arrow) # For saving data in Parquet format

# Import data
data <- read_csv("data/01-raw_data/predicting_happiness.csv")

# Check data structure
str(data)

# Process realrinc: Replace -100 with NA
data <- data %>%
  mutate(realrinc = ifelse(realrinc == -100, NA, realrinc))

# Clean categorical columns: Trim extra spaces and convert to lowercase
categorical_columns <- c("marital", "degree", "sex", "happy", "satjob", "ballot")
data[categorical_columns] <- lapply(data[categorical_columns], function(x) {
  tolower(trimws(x))
})

# Remove rows in the happy column with .d: do not know/cannot choose or .n: no answer
data <- data %>%
  filter(!happy %in% c(".d:  do not know/cannot choose", ".n:  no answer"))

# Replace invalid values in the satjob column with NA, including .i: inapplicable
data <- data %>%
  mutate(satjob = ifelse(satjob %in% c(".n:  no answer", ".d:  do not know/cannot choose", ".i:  inapplicable"), NA, satjob))

# Replace .n: no answer in marital and degree columns with NA
data <- data %>%
  mutate(marital = ifelse(marital == ".n:  no answer", NA, marital),
         degree = ifelse(degree == ".n:  no answer", NA, degree))

# Replace "8 or more" in the childs column with 8 and convert childs and age to numeric
data <- data %>%
  mutate(childs = ifelse(childs == "8 or more", "8", childs)) %>%
  mutate(age = as.numeric(age),
         childs = as.numeric(childs))

# Check the cleaned data
summary(data)

# Save the cleaned data as a CSV file
write_csv(data, "data/02-analysis_data/cleaned_happiness_data.csv")

# Save the cleaned data as a Parquet file
write_parquet(data, "data/02-analysis_data/cleaned_happiness_data.parquet")
