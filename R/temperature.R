## NASA API Mars Weather Report-Temperature Function
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

# plot atmospheric temp for one sol
# black bar is the average, corresponding to the black text
# blue background is the sol's range (min and max)
# red or green text below is relative to the previous sol's average

temperature <- function(sol, mars.df){
  
  # average
  sol.av <- subset(mars.df, mars.df$day == sol & mars.df$var == 'av')$AT
  
  # max
  sol.mx <- subset(mars.df, mars.df$day == sol & mars.df$var == 'mx')$AT
  
  # min
  sol.mn <- subset(mars.df, mars.df$day == sol & mars.df$var == 'mn')$AT
  
  # convert farhenheit to celsius
  sol.av <- (as.numeric(sol.av) - 32) * 5/9
  sol.mx <- (as.numeric(sol.mx) - 32) * 5/9
  sol.mn <- (as.numeric(sol.mn) - 32) * 5/9
  
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
    ref.av <- subset(mars.df, mars.df$day == refsol & mars.df$var == 'av')$AT
    
    p <- plot_ly(
      value = sol.av,
      delta = list(reference = ref.av),
      title = list(text = paste("Atmospheric Temperature (°C) \n for Sol", sol, sep = " "), font = list(size = 20)),
      type = "indicator",
      mode = "gauge+number+delta",
      gauge = list(
        axis = list(range = list(NULL, 700), tickwidth = 1),
        bar = list(color = "royalblue"),
        bgcolor = "white",
        steps = list(
          list(range = c(sol.mn, sol.mx), color = "#E0E6F2")),
        threshold = list(
          line = list(color = "black", width = 1),
          thickness = 0.75,
          value = sol.av)
      )) %>%
      layout(margin = list(l=15,r=30))
    
  } else if (listofsols[1] == as.numeric(sol)) {
    
    p <- plot_ly(
      value = sol.av,
      title = list(text = paste("Atmospheric Temperature (°C) \n for Sol", sol, sep = " "), font = list(size = 20)),
      type = "indicator",
      mode = "gauge+number",
      gauge = list(
        axis = list(range = list(-100, 0), tickwidth = 1),
        bar = list(color = "royalblue"),
        bgcolor = "white",
        steps = list(
          list(range = c(sol.mn, sol.mx), color = "#E0E6F2")),
        threshold = list(
          line = list(color = "black", width = 1),
          thickness = 0.75,
          value = sol.av)
      )
    ) %>%
      layout(margin = list(l=15,r=30))
    
  } else {
    listofsols <- list(as.numeric(unique(mars.df$day)))
    print(c("Please select one of the sol numbers from the last seven sols: " = listofsols))
  }
}

t<-temperature(413,x)
t

