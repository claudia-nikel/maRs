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

marsAverage<-function(mars.df){
  
  
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
  
  
}

s<-marsAverage(x)
s



