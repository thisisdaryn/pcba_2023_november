library(tidyverse)

cars2020 <- read_csv("data/cars2020.csv") |> 
  mutate(id = 1:n()) |>
  relocate(id)

cars_id <- cars2020 |>
  select(id, make, model)

cars_info <- cars2020 |>
  select(id, transmission, atvType, disp, mpg)


joined_data <- left_join(cars_id, cars_info, by = "id")
