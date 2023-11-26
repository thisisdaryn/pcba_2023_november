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

plot1 <- ggplot(data = cars_training, 
                aes(y = transmission, x = mpg)) + 
  geom_boxplot()

plot1

model1 <- lm(mpg~transmission, data = cars_training)

cars_training$model1 <- predict(model1, newdata = cars_training)

ggplot(data = cars_training,
       aes(x = mpg, y = model1, color = transmission)) + 
  geom_point() + xlim(c(0,60)) + ylim(c(0,60)) + 
  geom_abline(intercept = 0, slope = 1)

ggplot(data = cars_training,
       aes(x = disp, y = mpg, color = transmission)) + 
  geom_point()

model2 <- lm(mpg~disp, data = cars_training)


cars_training$model2 <- predict(model2, newdata = cars_training)



model3 <- lm(mpg~disp+transmission, data = cars_training)
summary(model3)
cars_training$model3 <- predict(model3, newdata = cars_training)


ggplot(data = cars_training, 
       aes(x = mpg, y = model3)) +  
  geom_point() + xlim(c(0,60)) + ylim(c(0,60)) + 
  geom_abline(intercept = 0, slope = 1)

model4 <- rpart(mpg~disp+transmission, data = cars_training)
rpart.plot(model4)

cars_training$model4 <- predict(model4, newdata = cars_training)

ggplot(data = cars_training, 
       aes(x = mpg, y = model4)) +  
  geom_point() + xlim(c(0,60)) + ylim(c(0,60)) + 
  geom_abline(intercept = 0, slope = 1)
