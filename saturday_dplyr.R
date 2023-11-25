library(tidyverse)

cars2020 <- read_csv("data/cars2020.csv")

manual <- filter(cars2020, transmission == "Manual")


## as an aside
transmission_counts <- count(cars2020, transmission)
count(cars2020, cyl)

## How many cars have 6 or more cylinders?

cyl_6plus <- filter(cars2020, cyl >= 6)


## How many cars have manual transmissions and 6 or more cylinders?

manual_6plus <- filter(cars2020, transmission == "Manual",
                       cyl >= 6)

hist(cars2020$cyl, main = "My new title", col = "royalblue", )
hist(cars2020$disp, main = "Engine Displacements", col = "#C2FFC2", 
    breaks = 100)
sd(cars2020$cyl)


### Keeping only the model, mpg, transmission and cyl columns

cars_narrow <- select(cars2020, model, mpg, transmission, cyl)

hist(cars2020$mpg, breaks = 50)

plot(cars2020$disp, cars2020$mpg)

## Removing the startStop and aspiration variables 

cars_alt <- select(cars2020, -startStop, -aspiration)

## Sorting data by mpg

cars_sorted <- arrange(cars2020, mpg)

## Sorting in descending order

cars_sorted_desc <- arrange(cars2020, desc(mpg))

## Sorting by transmission type (ascending/alphabetical), then by mpg (descending)
cars_sorted_df <- arrange(cars2020, transmission, desc(mpg))

## adding a variable to indicate if the vehicle has an mpg of 30 or greater

cars_30 <- mutate(cars2020, above30 = if_else(mpg >= 30, TRUE, FALSE)) 
cars_30 <- relocate(cars_30, above30, .before = mpg)

## Alternatively we could do the same thing like this:

cars_30_alt <- mutate(cars2020, above30 = if_else(mpg >= 30, TRUE, FALSE)) |>
  relocate(above30, .before = mpg)

### Using summarise

report <- summarise(cars2020, num_cars = n(),
                    avg_mpg = mean(mpg, na.rm = TRUE))

### Using group_by along with summarise

intermediate_df <- group_by(cars2020, make)

detailed_report <- summarise(intermediate_df, num_cars = n(),
                             avg_mpg = mean(mpg, na.rm = TRUE))


intermediate_df2 <- group_by(cars2020, make, transmission)

more_detailed_report <- summarise(intermediate_df2, num_cars = n(),
                                  avg_mpg = mean(mpg, na.rm = TRUE),
                                  .groups = "drop")


### Using the |> to join the group_by and summarise

final_report <- group_by(cars2020, make) |>
  summarise(num_cars = n(), avg_mpg = mean(mpg, na.rm = TRUE),
            .groups = "drop") |>
  arrange(desc(avg_mpg))




































