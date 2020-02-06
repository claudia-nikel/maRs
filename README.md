# 534 Project

[![Build Status](https://travis-ci.org/claudia-nikel/maRs.svg?branch=master)](https://travis-ci.org/claudia-nikel/maRs)
[![Codecov test coverage](https://codecov.io/gh/claudia-nikel/maRs/branch/master/graph/badge.svg)](https://codecov.io/gh/claudia-nikel/maRs?branch=master)

**Contributors:** Claudia Nikel, KT Hobbs & Shreeram Murali

# NASA Mars API
To retrieve and visualize weather data from the last 7 Sols (Martian days) as recorded and updated daily by NASA's InSight Mars lander. InSight is located at Elysium Planitia, a flat surface near the equator of Mars.

# Installation:
clone repository

`git clone https://github.com/claudia-nikel/534_project/`


in R console:

`setwd('path-to-github-repo')`

`library(devtools)`

`build()`

`install()` # if updates are required, update all (1)

`library(maRs)`


# Software Requirements
`maRs` was built on R version 3.5.0; therefore, it is recommended to use a similar version or higher to avoid compatability issues.

This package also depends on the following packages: 

    library(cellranger)
    library(dplyr)
    library(httr)
    library(jsonlite)
    library(plotly)
    library(purrr)
    library(readr)
    library(stats)
    library(stringr)
    library(tidyr)
    library(utils)
    library(XML)
    library(xml2)
   

# Functions
`marsInfo`: returns a summary table of weather including the Sol number, datetime stamp of first recorded sample (`First_UTC`), last recorded sample (`Last_UTC`), the current season for Mars, as well as average (`av`), sample size (`ct`), minimum (`mn`) and maximum (`mx`) recordings for temperature (`AT`), horizontal windspeed (`HWS`), and pressure (`PRE`).

`marsAverage`: takes the saved output from the marsInfo() function and returns the average temperature, windspeed, and pressure for the last 7 Sols.

`windspeed`: retrieves the inputted Sol's horizontal wind speed (m/s) from the summary table and visualizes it as a dial. The black bar is the average windspeed for the Sol, which corresponds to the black text. The green background is the sol range (min and max), and the red or green text below is represents a decrease or increase, respectively, relative to the previous sol's average.


`pressure`: retrieves the inputted Sol's pressure (Pascal) from the summary table and visualizes it as a dial. The black bar is the average pressure for the Sol, which corresponds to the black text. The orange background is the sol range (min and max), and the red or green text below is represents a decrease or increase, respectively, relative to the previous sol's average.

`temperature`: retrieves the inputted Sol's temperature (converted from Farhenheit to degrees Celsius) from the summary table and visualizes it as a dial. The black bar is the average temperature for the Sol, which corresponds to the black text. The blue background is the sol range (min and max), and the red or green text below is represents a decrease or increase, respectively, relative to the previous sol's average.



# Input

## Summary Tables
Input your API key generated on [NASA Open APIs](https://api.nasa.gov/?search=mars) into the function `marsInfo()`.

`marsAverage()` reports only daily average information for windspeed, temperature, and pressure with the option of graphing the entire week's summary.

`marsMM()` takes the saved output from the marsInfo() function and returns plot showing maximum and minimum values of whole week along with histogram for both maximum and minimum values.


## Visualizations
For windspeed, pressure, and temperature visualizations, user must input a number from the previous 7 Sols. Since the function makes use of Plotly, you must save the function as a variable.

`windspeed(sol, x)` where sol is sol number in the form of an integer and x is the saved output from the `marsInfo()` function.

If the input is not within the last 7 Sols, an error message will return listing valid options.

To display the visualization, run the variable name.

`w`

For more examples, refer to our vignette.
