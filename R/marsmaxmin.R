## NASA API Mars Weather Report-Get API Function
## KT Hobbs & Claudia Nikel & Shreeram Murali

#-------------------------------
#### Import libraries and data
#--


library('jsonlite')
library('purrr')
library('dplyr')
library('tidyr')
library('plotly')


weeklyreport <- function(func,df){
  x<-df
  listofsols <- list()
  for (i in 1:7) {
    listofsols[i] <- as.numeric(unique(x$day))[i]
  }

  mars.mx <- (subset(x, var=='mx'))

  mars.mn <- (subset(x, var=='mn'))

  mars.max.AT <- mars.mx$AT
  mars.min.AT <- mars.mn$AT

  mars.max.HWS <- mars.mx$HWS
  mars.min.HWS <- mars.mn$HWS

  mars.max.PRE <- mars.mx$PRE
  mars.min.PRE <- mars.mn$PRE


  if (func=='t'){
    par(mfrow=c(2,2))
    plot(listofsols,mars.max.AT, xlab = 'Sols',ylab='Max Atmospheric Temperature for last 7 days')
    lines(listofsols,mars.max.AT)
    plot(listofsols,mars.min.AT, xlab = 'Sols',ylab='Min Atmospheric Temperature for last 7 days')
    lines(listofsols,mars.min.AT)
    mars.max.AT<- as.numeric(mars.max.AT)
    mars.min.AT<- as.numeric(mars.min.AT)
    hist(mars.max.AT)
    hist(mars.min.AT)
  }

  if (func=='w'){
    plot(listofsols,mars.max.HWS, xlab = 'Sols',ylab='Max High Windspeed for last 7 days')
    lines(listofsols,mars.max.HWS)
    plot(listofsols,mars.min.HWS, xlab = 'Sols',ylab='Max High Windspeed for last 7 days')
    lines(listofsols,mars.min.HWS)
    mars.max.HWS<- as.numeric(mars.max.HWS)
    mars.min.HWS<- as.numeric(mars.min.HWS)
    hist(mars.max.HWS)
    hist(mars.min.HWS)
  }
  
  if (func=='p'){
    plot(listofsols,mars.max.PRE, xlab = 'Sols',ylab='Max Pressure for last 7 days')
    lines(listofsols,mars.max.PRE)
    plot(listofsols,mars.min.PRE, xlab = 'Sols',ylab='Min Pressure for last 7 days')
    lines(listofsols,mars.min.PRE)
    mars.max.PRE<- as.numeric(mars.max.PRE)
    mars.min.PRE<- as.numeric(mars.min.PRE)
    hist(mars.max.PRE)
    hist(mars.max.PRE)
  }
}

#weeklyreport(func='t',x)

#weeklyreport(func='w',x)

#weeklyreport(func='p',x)



