## NASA API Mars Weather Report
## KT Hobbs & Claudia Nickel

#-------------------------------
#### Import libraries and data
#-------------------------------

library('jsonlite')
library('purrr')
library('dplyr')
library('tidyr')
library('plotly')
library('dplyr')


api <- "hecLCNM6NcwAGgGGWSW2xovr0SyYuXiOShVw6GxS"


req <- paste("https://api.nasa.gov/insight_weather/?api_key=", api, "&feedtype=json&ver=1.0", sep = "")
mars <- fromJSON(req)

mars.df <- map(mars[1:7], ~unlist(.x[1:6]) %>%
      bind_rows) %>%
  bind_rows(.id = "day") %>%
  pivot_longer(cols = grep("\\.", names(.)), names_sep = "\\.", names_to = c(".value", "var"))


# plot windspeeds for one sol
# NOTE: need to figure out how to raise exception for the first sol (can't plot the sol before it)

windspeed <- function(sol){
  
    # average
    refsol <- as.character(as.numeric(sol)-1)
    sol.av <- subset(mars.df, mars.df$day == sol & mars.df$var == 'av')$HWS
    ref.av <- subset(mars.df, mars.df$day == refsol & mars.df$var == 'av')$HWS
  
    
    # max
    sol.mx <- subset(mars.df, mars.df$day == sol & mars.df$var == 'mx')$HWS
    
    
    # min
    sol.mn <- subset(mars.df, mars.df$day == sol & mars.df$var == 'mn')$HWS
    
  
    p <- plot_ly(
      domain = list(x = c(0, 1), y = c(0, 1)),
      value = sol.av,
      delta = list(reference = ref.av),
      title = list(text = paste("Wind Speeds for Sol", sol, sep = " ")),
      type = "indicator",
      mode = "gauge+number+delta",
      gauge = list(
        bar = list(color = "royalblue"),
        bgcolor = "white",
        borderwidth = 2,
        bordercolor = "gray",
        threshold = list(
          line = list(color = "red", width = 4),
          thickness = 0.75,
          value = sol.mx),
        threshold = list(
          line = list(color = "green", width = 4),
          thickness = 0.75,
          value = sol.mn)
      )) %>%
      layout(margin = list(l=15,r=30))

}

p <- windspeed(404)
p


# grab only the average windspeeds for each day
mars.av <- subset(mars.df, var == 'av')
weekly.av <- mean(as.numeric(mars.av$HWS))

mars.mn <- subset(mars.df, var == 'mn')
weekly.min <- min(as.numeric(mars.mn$HWS))

mars.mx <- subset(mars.df, var == 'mx')
weekly.max <- max(as.numeric(mars.mx$HWS))
