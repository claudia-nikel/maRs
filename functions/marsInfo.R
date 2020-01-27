## NASA API Mars Weather Report
## KT Hobbs & Claudia Nikel & Shreeram Murali

#-------------------------------
#### Import libraries and data
#-------------------------------

library('jsonlite')
library('purrr')
library('dplyr')
library('tidyr')
library('plotly')

marsInfo<-function(APIkey){
  req <- paste("https://api.nasa.gov/insight_weather/?api_key=", as.character(APIkey), "&feedtype=json&ver=1.0", sep = "")
  mars <- fromJSON(req)
  
  mars<-(map(mars[1:7], ~unlist(.x[1:6]) %>%
      bind_rows) %>%
    bind_rows(.id = "day") %>%
    pivot_longer(cols = grep("\\.", names(.)), names_sep = "\\.", names_to = c(".value", "var")))

  mars.av <- subset(mars, var == 'av')
  
  trace_0 <- mars.av$AT
  trace_1 <- mars.av$HWS
  trace_2 <- mars.av$PRE
  x <- mars.av$day
  data <- data.frame(x, trace_0, trace_1, trace_2)
  
  p <- plot_ly(data, x = ~x, y = ~trace_0, name = 'Atmospheric Temperature', type = 'scatter', mode = 'lines+markers') %>%
    add_trace(y = ~trace_1, name = 'Horizontal Wind Speed', mode = 'lines+markers') %>%
    add_trace(y = ~trace_2, name = 'Atmospheric Pressure', mode = 'lines+markers') %>%
    layout(title = "Weekly Weather Summary on Mars", xaxis = list(title = "Sol"), yaxis = list(title = " "))
  
  p
#plots a 3 line graphs of the temperature (blue), wind speed (orange) and atmospheric pressure (green) of mars for the last 7 sols

}

marsInfo("hecLCNM6NcwAGgGGWSW2xovr0SyYuXiOShVw6GxS")


