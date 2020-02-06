## NASA API Mars Weather Report-Pressure Function
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

# plot pressure for one sol
# black bar is the average, corresponding to the black text
# orange background is the sol's range (min and max)
# red or green text below is relative to the previous sol's average

pressure <- function(sol, mars.df){
  
  # average
  sol.av <- subset(mars.df, mars.df$day == sol & mars.df$var == 'av')$PRE
  
  # max
  sol.mx <- subset(mars.df, mars.df$day == sol & mars.df$var == 'mx')$PRE
  
  # min
  sol.mn <- subset(mars.df, mars.df$day == sol & mars.df$var == 'mn')$PRE
  
  # list of sols to filter plots by
  # testing that the correct sol was chosen
  listofsols <- list()
  for (i in 1:7) {
    listofsols[i] <- as.numeric(unique(mars.df$day))[i]
  }
  listofsols
  
  
  if (length(subset(mars.df$day, mars.df$day == as.numeric(sol)-1) != 0)) {
    # reference sol, the day before
    refsol <- as.character(as.numeric(sol)-1)
    ref.av <- subset(mars.df, mars.df$day == refsol & mars.df$var == 'av')$PRE
    
    p <- plot_ly(
      domain = list(x = c(0, 1), y = c(0, 1)),
      value = sol.av,
      delta = list(reference = ref.av),
      title = list(text = paste("Pressure (Pa) for Sol", sol, sep = " "), font = list(size = 16)),
      type = "indicator",
      mode = "gauge+number+delta",
      gauge = list(
        axis = list(range = list(NULL, 700), tickwidth = 1),
        bar = list(color = "#E6843E"),
        bgcolor = "white",
        steps = list(
          list(range = c(sol.mn, sol.mx), color = "#EEE0D6")),
        threshold = list(
          line = list(color = "black", width = 1),
          thickness = 0.75,
          value = sol.av)
      ))
    
  } else if (listofsols[1] == as.numeric(sol)) {
    
    p <- plot_ly(
      domain = list(x = c(0, 1), y = c(0, 1)),
      value = sol.av,
      title = list(text = paste("Pressure (Pa) for Sol", sol, sep = " "), font = list(size = 16)),
      type = "indicator",
      mode = "gauge+number",
      gauge = list(
        axis = list(range = list(NULL, 700), tickwidth = 1),
        bar = list(color = "#E6843E"),
        bgcolor = "white",
        steps = list(
          list(range = c(sol.mn, sol.mx), color = "#EEE0D6")),
        threshold = list(
          line = list(color = "black", width = 1),
          thickness = 0.75,
          value = sol.av)
      )
    ) 
    
  } else {
    listofsols <- list(as.numeric(unique(mars.df$day)))
    print(c("Please select one of the sol numbers from the last seven sols: " = listofsols))
  }
}

#p<-pressure(415, marsInfo("hecLCNM6NcwAGgGGWSW2xovr0SyYuXiOShVw6GxS"))

