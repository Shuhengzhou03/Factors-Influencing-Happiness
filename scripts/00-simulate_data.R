#### Preamble ####
# Purpose: Simulated the analysis dataset
# Author: Shuheng (Jack) Zhou
# Date: November 26 2024
# Contact: shuhengzhou5@gmail.com
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Simulation ####
# Set seed for reproducibility
set.seed(800)

# Number of rows in the dataset
n <- 1000

# Set the year to 2016
year <- rep(2016, n)  # All rows will have year = 2016

# Generate marital status
marital <- sample(c("Married", "Never married", "Divorced", "Widowed", "Separated"), n, replace = TRUE)

# Generate number of children, influenced by marital status
childs <- ifelse(marital == "Married", sample(0:5, n, replace = TRUE, prob = c(0.1, 0.2, 0.3, 0.2, 0.1, 0.1)),
                 sample(0:3, n, replace = TRUE, prob = c(0.5, 0.3, 0.15, 0.05)))

# Generate age values, slightly influenced by marital status
age <- ifelse(marital == "Married", round(rnorm(n, mean = 40, sd = 10)), 
              round(rnorm(n, mean = 30, sd = 8)))
age <- pmin(pmax(age, 18), 80)  # Ensure age stays within 18-80

# Generate degree values
degree <- sample(c("High school", "Bachelor's", "Graduate", "No degree", "Less than high school",
                   "Associate/junior college"), n, replace = TRUE)

# Generate sex values
sex <- sample(c("Male", "Female"), n, replace = TRUE)

# Generate real income values, influenced by degree
income_by_degree <- c("Less than high school" = 25000, "High school" = 35000, "Associate/junior college" = 45000,
                      "Bachelor's" = 65000, "Graduate" = 85000, "No degree" = 30000)
income_sd <- 15000
realrinc <- round(rnorm(n, mean = unname(income_by_degree[degree]), sd = income_sd), 2)
realrinc <- pmax(realrinc, 1000)  # Ensure income is non-negative

# Generate job satisfaction, influenced by real income
satjob <- cut(realrinc, breaks = c(-Inf, 30000, 60000, 90000, Inf),
              labels = c("very dissatisfied", "a little dissatisfied", "moderately satisfied", "very satisfied"))

# Generate happiness values, influenced by income, job satisfaction, and number of children
happy_prob <- case_when(
  satjob == "very satisfied" & realrinc > 60000 ~ list(c(0.6, 0.3, 0.1)),
  satjob == "moderately satisfied" & realrinc > 40000 ~ list(c(0.4, 0.4, 0.2)),
  satjob == "a little dissatisfied" ~ list(c(0.2, 0.5, 0.3)),
  TRUE ~ list(c(0.1, 0.3, 0.6))
)

# Sample happiness values using the probabilities
happy <- mapply(function(prob) sample(c("Very happy", "Pretty happy", "Not too happy"), 1, prob = prob), happy_prob)
# Generate ballot type
ballot <- sample(c("Ballot a", "Ballot b", "Ballot c"), n, replace = TRUE)

# Create dataframe
simulated_data <- data.frame(year, marital, childs, age, degree, sex, happy, satjob, realrinc, ballot)

# View the first few rows of the dataset
head(simulated_data)

# Save to parquet
write_parquet(simulated_data, "data/00-simulated_data/predicting_happiness.parquet")
