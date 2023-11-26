library(tidyverse)

penguins <- read_csv("data/penguins.csv", 
                     show_col_types = FALSE)

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = bill_depth_mm)) + 
  geom_point() + theme_minimal() 


my_cols <- c("Adelie" = "red", 
             "Chinstrap" = "blue",
             "Gentoo" = "green")

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = bill_depth_mm,
                     colour = species)) + 
  geom_point() + scale_colour_manual(values = my_cols) + 
  labs(title = "A Penguin graph", 
       subtitle = "Here's a graph based on data collected about penguins in Antarctica",
       y = "Bill depth", x = "flipper length") +
  theme(legend.position = "bottom")

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = bill_depth_mm,
                     colour = species, 
                     shape = sex)) + 
  geom_point() + scale_colour_manual(values = my_cols)


### histograms of penguin body masses

ggplot(data = penguins, 
       mapping = aes(x = body_mass_g)) + geom_histogram(fill = "skyblue",
                                                        color = "royalblue") +
  theme_minimal() + facet_wrap(~species, ncol = 1)

ggplot(data = penguins, 
       mapping = aes(x = body_mass_g)) + geom_histogram(fill = "skyblue",
                                                        color = "royalblue") +
  theme_minimal() + facet_grid(species~sex)


### Using box plots to compare body masses across different species

ggplot(data = penguins,
       mapping = aes(y = species, x = body_mass_g)) + 
  geom_boxplot()


library(ggbeeswarm)
ggplot(data = penguins,
       mapping = aes(y = species, x = body_mass_g)) + 
  geom_beeswarm()




