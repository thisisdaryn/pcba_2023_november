library(tidyverse)
library(rsample)

so <- read_csv("data/stackoverflow.csv",
               show_col_types = FALSE) |> 
  mutate(output = if_else(remote == "Not remote", 0, 1)) |>
  relocate(output, .after = remote)

## adding a column to show salary in local currency
temp <- so |>
  mutate(local_currency = case_when(country == "Germany" ~ salary*0.91,
                                    country == "United Kingdom" ~ salary*0.79,
                                    country == "United States" ~ salary,
                                    country == "Canada" ~ salary*1.36,
                                    country == "India" ~ salary*83.31,
                                    .default = NA_real_))



## bar chart showing country and remote status
ggplot(data = so,
       aes(x = country, fill = remote)) + geom_bar() 


## histogram of career satisfaction
ggplot(data = so,
       aes(x = career_satisfaction)) + geom_histogram(bins = 10, fill = "orange", color = "blue")


## Comparing salaries across countries
ggplot(data = so,
       aes(y = country, x = salary)) + 
  geom_boxplot()


set.seed(1126)
so_split <- initial_split(so, prop = 0.8)
so_training <- training(so_split)
so_testing <- testing(so_split)

model1 <- glm(output~country+salary+years_coded_job, data = so_training,
              family = binomial(link = "logit"))
summary(model1)

so_training$model1 <- predict(model1, newdata = so_training, type = "response")
## type = "response" is necessary to get p (as opposed to ln(p/(1-p)))
max(so_training$model1)

# boxplot comparing predicted probabilities in remote vs not remote
ggplot(data = so_training,
       aes(x = remote, y = model1)) + 
    geom_boxplot(alpha = 0.3) 

## actual values superimposed on boxplot
ggplot(data = so_training,
       aes(x = remote, y = model1)) + 
  geom_boxplot(alpha = 0.3) + geom_jitter(alpha = 0.2)


### now to do the whole thing but balancing the data first 


#### Balancing the data i.e. 50% remote; 50% not remote
so_remote <- filter(so, remote == "Remote")
so_not_remote <- filter(so, remote == "Not remote")

so_remote_split <- initial_split(so_remote, prop = 0.8)
so_remote_training <- training(so_remote_split)

so_not_remote_split <- initial_split(so_not_remote, prop = 0.0916)
so_not_remote_training <- training(so_not_remote_split)

balanced_training_data <- bind_rows(so_remote_training, so_not_remote_training)

### calibrate a model on the balanced data
model2 <- glm(output~country+salary+years_coded_job, data = balanced_training_data,
              family = binomial(link = "logit"))
balanced_training_data$model2 <- predict(model2, newdata = balanced_training_data,
                                         type = "response")

ggplot(data = balanced_training_data,
       aes(x = remote, y = model2)) + 
  geom_boxplot()










