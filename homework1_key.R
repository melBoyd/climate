library(tidyverse)

# Select station level data:

stations <- 
  read_csv('data/raw/messy_weather.csv') %>% 
  dplyr::select(station:name) %>% 
  distinct()


observations <-
  read_csv('data/raw/messy_weather.csv') %>% 
  dplyr::select(station, year:march_31) %>%
    pivot_longer(
      march_1:march_31,
      names_to = 'day',
      values_to = 'value',
      names_prefix = 'march_') %>% 
    unite(
      'date',
      c(year, month, day),
      sep = '-') %>% 
    pivot_wider(
      names_from = variable,
      values_from = value) %>% 
    separate(
      temperature_min_max,
      c('temp_min', 'temp_max'),
      sep = ':') %>% 
    mutate_at(
      vars(precip:temp_max),
      ~as.numeric(.))
