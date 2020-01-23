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
# black bar is the average, corresponding to the black text
# green background is the sol's range (min and max)
# red or green text below is relative to the previous sol's average

windspeed <- function(sol){
  
    # average
    sol.av <- subset(mars.df, mars.df$day == sol & mars.df$var == 'av')$HWS
    
    # max
    sol.mx <- subset(mars.df, mars.df$day == sol & mars.df$var == 'mx')$HWS
    
    # min
    sol.mn <- subset(mars.df, mars.df$day == sol & mars.df$var == 'mn')$HWS
    
    # list of sols to filter plots by
    listofsols <- list()
    for (i in 1:7) {
      listofsols[i] <- as.numeric(unique(mars.df$day))[i]
    }
    listofsols
    
    
    
    if (length(subset(mars.df$day, mars.df$day == as.numeric(sol)-1) != 0)) {
    # reference sol, the day before
      refsol <- as.character(as.numeric(sol)-1)
      ref.av <- subset(mars.df, mars.df$day == refsol & mars.df$var == 'av')$HWS
    
      p <- plot_ly(
        domain = list(x = c(0, 1), y = c(0, 1)),
        value = sol.av,
        delta = list(reference = ref.av),
        title = list(text = paste("Horizontal Wind Speeds (m/s) \n for Sol", sol, sep = " "), font = list(size = 20)),
        type = "indicator",
        mode = "gauge+number+delta",
        gauge = list(
          axis = list(range = list(NULL, 25), tickwidth = 1),
          bar = list(color = "darkgreen"),
          bgcolor = "white",
          steps = list(
            list(range = c(sol.mn, sol.mx), color = "lightgreen")),
          threshold = list(
            line = list(color = "black", width = 1),
            thickness = 0.75,
            value = sol.av)
        )) %>%
        layout(margin = list(l=15,r=30))
      
    } else if (listofsols[1] == as.numeric(sol)) {
      
      p <- plot_ly(
        domain = list(x = c(0, 1), y = c(0, 1)),
        value = sol.av,
        title = list(text = paste("Horizontal Wind Speeds (m/s) \n for Sol", sol, sep = " "), font = list(size = 20)),
        type = "indicator",
        mode = "gauge+number",
        gauge = list(
          axis = list(range = list(NULL, 25), tickwidth = 1),
          bar = list(color = "darkgreen"),
          bgcolor = "white",
          steps = list(
            list(range = c(sol.mn, sol.mx), color = "lightgreen")),
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

w <- windspeed(407)
w



# plot pressure for one sol
# black bar is the average, corresponding to the black text
# orange background is the sol's range (min and max)
# red or green text below is relative to the previous sol's average

pressure <- function(sol){
  
  # average
  sol.av <- subset(mars.df, mars.df$day == sol & mars.df$var == 'av')$PRE
  
  # max
  sol.mx <- subset(mars.df, mars.df$day == sol & mars.df$var == 'mx')$PRE
 
  # min
  sol.mn <- subset(mars.df, mars.df$day == sol & mars.df$var == 'mn')$PRE
  
  # list of sols to filter plots by
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
      title = list(text = paste("Pressure (Pa) for Sol", sol, sep = " "), font = list(size = 20)),
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
      )) %>%
      layout(margin = list(l=15,r=30))
    
  } else if (listofsols[1] == as.numeric(sol)) {
    
    p <- plot_ly(
      domain = list(x = c(0, 1), y = c(0, 1)),
      value = sol.av,
      title = list(text = paste("Pressure (Pa) for Sol", sol, sep = " "), font = list(size = 20)),
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
    ) %>%
      layout(margin = list(l=15,r=30))
    
  } else {
    listofsols <- list(as.numeric(unique(mars.df$day)))
    print(c("Please select one of the sol numbers from the last seven sols: " = listofsols))
  }
}

p <- pressure(408)
p



# plot atmospheric temp for one sol
# black bar is the average, corresponding to the black text
# blue background is the sol's range (min and max)
# red or green text below is relative to the previous sol's average

temperature <- function(sol){
  
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

t <- temperature(405)
t
