## NASA API Mars Weather Report
## KT Hobbs & Claudia Nickel

#-------------------------------
#### Import libraries and data
#-------------------------------

library('jsonlite')
library('purrr')
library('dplyr')
library('tidyr')

req <- "https://api.nasa.gov/insight_weather/?api_key=DEMO_KEY&feedtype=json&ver=1.0"
mars <- fromJSON(req)

map(mars[1:7], ~unlist(.x[1:6]) %>%
      bind_rows) %>%
  bind_rows(.id = "day") %>%
  pivot_longer(cols = grep("\\.", names(.)), names_sep = "\\.", names_to = c(".value", "var"))


