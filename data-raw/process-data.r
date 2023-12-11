library("dplyr")
library("tidyr")

mochasta1 <- read.csv("./data-raw/mochasta1/within_means.csv") |>
  pivot_longer(
    cols = starts_with("sp")
    , names_to = "position"
    , values_to = "pos_total"
  ) |>
  mutate(
    id = as.factor(id)
    , order = as.factor(order)
    , task = as.factor(task)
    , sound = as.factor(sound)
    , position = as.factor(position)
  ) |>
  ungroup()

save(mochasta1, file = "./data/mochasta1.Rdata")

mochasta2 <- read.csv("./data-raw/mochasta2/between_means.csv") |>
  mutate(id = paste(id, task, sep = "-")) |>
  pivot_longer(
    cols = starts_with("sp")
    , names_to = "position"
    , values_to = "pos_total"
  ) |>
  mutate(
    id = as.factor(id)
    , task = as.factor(task)
    , sound = as.factor(sound)
    , position = as.factor(position)
  )

save(mochasta2, file = "./data/mochasta2.Rdata")
