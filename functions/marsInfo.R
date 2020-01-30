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
  req<-paste("https://api.nasa.gov/insight_weather/?api_key=", as.character(APIkey), "&feedtype=json&ver=1.0", sep = "")
  mars<-fromJSON(req)
  
  mars<-(map(mars[1:7], ~unlist(.x[1:6]) %>%
      bind_rows) %>%
    bind_rows(.id = "day") %>%
    pivot_longer(cols = grep("\\.", names(.)), names_sep = "\\.", names_to = c(".value", "var")))

  mars.av<-subset(mars, var == 'av')
  
  atm_temp<-mars.av$AT
  horiz_windspeed<-mars.av$HWS
  atm_pres<-mars.av$PRE
  sol<-mars.av$day
  marsdata<-data.frame(sol, atm_temp, horiz_windspeed, atm_pres)
  marsdata



}

marsInfo("hecLCNM6NcwAGgGGWSW2xovr0SyYuXiOShVw6GxS")


#plots a 3 line graphs of the temperature (blue), wind speed (orange) and atmospheric pressure (green) of mars for the last 7 sols

marsdata<-marsInfo("hecLCNM6NcwAGgGGWSW2xovr0SyYuXiOShVw6GxS")


p<-plot_ly(marsdata, x=~sol, y=~atm_temp, name='Atmospheric Temperature', type='scatter', mode='lines+markers') %>%
  add_trace(y=~horiz_windspeed, name='Horizontal Wind Speed', mode='lines+markers') %>%
  add_trace(y=~atm_pres, name='Atmospheric Pressure', mode='lines+markers') %>%
  layout(title = "Weekly Weather Summary on Mars", xaxis = list(title = "Sol"), yaxis = list(title = " "))

p

