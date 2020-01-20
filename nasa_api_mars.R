## NASA API Mars Weather Report
## KT Hobbs & Claudia Nickel

#-------------------------------
#### Import libraries and data
#-------------------------------
library('RJSONIO')
library('jsonlite')
library('tidyverse')
library('kableExtra')


request <- "https://api.nasa.gov/insight_weather/?api_key=hecLCNM6NcwAGgGGWSW2xovr0SyYuXiOShVw6GxS&feedtype=json&ver=1.0"
mars <- fromJSON(request, flatten = TRUE)

cnames <- names(mars$`401`)

# restructure for each report
mars$`407` <- cbind(mars$`407`$AT,
                    rep(mars$`407`$First_UTC, length(mars$`407`$AT)), 
                    rep(mars$`407`$Last_UTC, length(mars$`407`$AT)),
                    mars$`407`$PRE, 
                    rep(mars$`407`$Season, length(mars$`407`$AT)),
                    rep(mars$`407`$WD$most_common, length(mars$`407`$AT))
)

colnames(mars$`407`) <- cnames

mars$`407`
