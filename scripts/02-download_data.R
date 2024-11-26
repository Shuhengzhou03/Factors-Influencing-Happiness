#### Preamble ####
# Purpose: Downloads and saves the data from GSS
# Author: Shuheng (Jack) Zhou
# Date: 11 February 2023 
# Contact: shuhengzhou5@gmail.com
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Download data ####
gss_data <- 
  read_csv(
    here::here("data/raw_data/GSS_DATA.csv"),  
    show_col_types = FALSE
  )


#### Save data ####
# change the_raw_data to whatever name you assigned when you downloaded it.
write_csv(predicting_happiness, "data/raw_data/predicting_happiness.csv")
         
