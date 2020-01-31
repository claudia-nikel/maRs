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

#-------------------------------
#### Description
#-------------------------------
#gets api from NASA for mars and returns
#a dataframe with information on the past
#seven days

marsInfo<-function(APIkey){
  req<-paste("https://api.nasa.gov/insight_weather/?api_key=", as.character(APIkey), "&feedtype=json&ver=1.0", sep = "")
  mars<-fromJSON(req)
  
  mars.df<-(map(mars[1:7], ~unlist(.x[1:6]) %>%
      bind_rows) %>%
    bind_rows(.id = "day") %>%
    pivot_longer(cols = grep("\\.", names(.)), names_sep = "\\.", names_to = c(".value", "var")))
   return(mars.df)
  
}

x<-marsInfo("hecLCNM6NcwAGgGGWSW2xovr0SyYuXiOShVw6GxS")
