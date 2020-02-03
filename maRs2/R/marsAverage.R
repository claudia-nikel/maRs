## NASA API Mars Weather Report-Average Weather Function
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

#return df of weekly weather summary on mars
#plots stacked line graph if specified in argument
#where green is pressure, orange is wind speed 
#and blue is temperature

marsAverage<-function(mars.df, graph=NULL){
  
  
  #takes on subset of df with averages
  mars.av<-subset(mars.df, var == 'av')
  
  #rename df columns
  atm_temp<-mars.av$AT
  horiz_windspeed<-mars.av$HWS
  atm_pres<-mars.av$PRE
  sol<-mars.av$day
  marsdata<-data.frame(sol, atm_temp, horiz_windspeed, atm_pres)
  #returns df of weekly averages
  return(marsdata)
  
  #checks to see of optional graph parameter is NULL
  if (is.null(graph)){
  
  }
  else {
    #plots 3 line graphs of the temperature (blue), wind speed (orange) and atmospheric pressure (green) of mars for the last 7 sols
    p<-plot_ly(marsdata, x=~sol, y=~atm_temp, name='Atmospheric Temperature', type='scatter', mode='lines+markers') %>%
    add_trace(y=~horiz_windspeed, name='Horizontal Wind Speed', mode='lines+markers') %>%
    add_trace(y=~atm_pres, name='Atmospheric Pressure', mode='lines+markers') %>%
    layout(title = "Weekly Weather Summary on Mars", xaxis = list(title = "Sol"), yaxis = list(title = " "))
    p
    }
  
}

#without graph
#s<-marsAverage(x, graph=NULL)


#q<-marsAverage(x, graph=TRUE)
