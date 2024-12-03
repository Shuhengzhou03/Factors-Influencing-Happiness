#### Preamble ####
# Purpose: To identify key factors influencing happiness levels using Bayesian Logistic Regression.
# Author: Shuheng (Jack) Zhou
# Date: November 27 2024
# Contact: shuhengzhou5@gmail.com
# License: MIT
# Pre-requisites: Cleaned datasets should be available.
# Any other information needed? Make sure you are in the `starter_folder` R project.


# Install and load necessary packages
library(dplyr)
library(brms)
library(arrow)
library(rstanarm)

# Load data
data <- read_parquet("data/02-analysis_data/cleaned_happiness_data.parquet")

# Check data structure and summary
str(data)
summary(data)

# Data preparation
data <- data %>%
  filter(
    !is.na(marital), 
    !is.na(childs), 
    !is.na(age), 
    !is.na(degree), 
    !is.na(sex), 
    !is.na(happy), 
    !is.na(satjob), 
    !is.na(realrinc)
  ) %>%
  mutate(
    happy_binary = ifelse(happy == "very happy", 1, 0),  # Binary target variable
    age = scale(age),  # Standardize age
    realrinc = scale(realrinc)  # Standardize real income
  )

# Build the Bayesian Logistic Regression model
happiness_model <- stan_polr(
  formula = as.factor(happy_binary) ~ marital + childs + age + degree + sex + satjob + realrinc,
  data = data,
  method = "logistic", # Use logistic cumulative link model
  prior = NULL, # Use default priors to simplify the model
  prior_counts = NULL # Use default priors for the intercepts
)

# View model summary
summary(happiness_model)

# Plot posterior distributions
plot(happiness_model)


# Posterior predictive checks
pp_check(happiness_model)

#### Save model ####
saveRDS(
  happiness_model,
  file = "models/happiness_model.rds"
)
