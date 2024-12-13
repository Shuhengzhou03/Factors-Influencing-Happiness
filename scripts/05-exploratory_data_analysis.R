#### Preamble ####
# Purpose: Explore the analysis data
# Author: Shuheng (Jack) Zhou
# Date: November 27 2024
# Contact: shuhengzhou5@gmail.com
# License: MIT
# Pre-requisites: Analysis data generated in 02-analysis_data
# Any other information needed? None


#### Workspace setup ####
library(ggplot2)
library(arrow)
library(here)
library(dplyr)

#### Read data ####
data <- read_parquet(here::here("data/02-analysis_data/cleaned_happiness_data.parquet"))


# Bar Plot: Happiness Levels by Marital Status
plot1 <- ggplot(happiness_data, aes(x = marital, fill = happy)) +
  geom_bar(position = "stack") +
  labs(title = "Happiness Levels by Marital Status", x = "Marital Status", y = "Count", fill = "Happiness Level")

# Line/Density Plot: Happiness Levels Over Age
plot2 <- ggplot(happiness_data, aes(x = age, group = happy, color = happy)) +
  geom_density() +
  labs(title = "Happiness Levels Over Age", x = "Age", y = "Density", color = "Happiness Level")

# Bar Plot: Happiness Levels by Education Degree
plot3 <- ggplot(happiness_data, aes(x = degree, fill = happy)) +
  geom_bar(position = "dodge") +
  labs(title = "Happiness Levels by Education Degree", x = "Education Degree", y = "Count", fill = "Happiness Level")

# Boxplot: Real Income by Happiness Levels
plot4 <- ggplot(happiness_data, aes(x = happy, y = realrinc)) +
  geom_boxplot(fill = "lightblue") +
  labs(title = "Real Income by Happiness Levels", x = "Happiness Level", y = "Real Income")

# Heatmap: Job Satisfaction and Happiness
plot5 <- ggplot(happiness_data, aes(x = satjob, y = happy, fill = childs)) +
  geom_tile() +
  labs(title = "Heatmap of Job Satisfaction and Happiness", x = "Job Satisfaction", y = "Happiness Level", fill = "Number of Children")

