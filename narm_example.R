library(tidyverse)

penguins <- read_csv("data/penguins.csv")

penguin_report <- group_by(penguins, species) |>
  summarise(num_penguins = n(), 
            avg_mass = mean(body_mass_g))

penguin_report2 <- group_by(penguins, species) |>
  summarise(num_penguins = n(), 
            avg_mass = mean(body_mass_g, na.rm = TRUE))
