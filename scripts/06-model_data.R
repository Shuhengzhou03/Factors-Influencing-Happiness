#### Preamble ####
# Purpose: To identify key factors influencing happiness levels using Bayesian Logistic Regression.
# Author: Shuheng (Jack) Zhou
# Date: 
# Contact: shuhengzhou5@gmail.com
# License: MIT
# Pre-requisites: Cleaned datasets should be available.
# Any other information needed? Make sure you are in the `starter_folder` R project.


# Install and load necessary packages
if (!requireNamespace("brms", quietly = TRUE)) {
  install.packages("brms")
}
if (!requireNamespace("arrow", quietly = TRUE)) {
  install.packages("arrow")
}
library(dplyr)
library(brms)
library(arrow)

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
happiness_model <- brm(
  happy_binary ~ marital + childs + age + degree + sex + satjob + realrinc,  # Predictor variables
  data = data,
  family = bernoulli(link = "logit"),  # Logistic regression
  prior = c(
    prior(normal(0, 2), class = "b"),  # Prior for coefficients
    prior(cauchy(0, 2), class = "Intercept")  # Prior for intercept
  ),
  iter = 2000,  # Total iterations
  chains = 4,   # Number of MCMC chains
  warmup = 1000,  # Warm-up iterations
  cores = 4,    # Number of cores for parallel computation
  seed = 123    # Random seed for reproducibility
)

# View model summary
summary(happiness_model)

# Plot posterior distributions
plot(happiness_model)

# Check MCMC convergence
mcmc_plot(happiness_model)

# Posterior predictive checks
pp_check(happiness_model)
