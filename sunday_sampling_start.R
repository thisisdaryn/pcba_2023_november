library(tidyverse) # for dplyr, ggplot2, readr and other libraries
library(rsample) # for sampling and resampling (creating test and training sets)
library(rpart) # for decision-tree models
library(rpart.plot) # for visualising decision trees


cars2020 <- read_csv("data/cars2020.csv", 
                     show_col_types = FALSE)

set.seed(1729) ## to ensure that we all get the same data splits

cars_split <- initial_split(cars2020, prop = 0.8)
cars_training <- training(cars_split)
cars_data <- testing(cars_split)