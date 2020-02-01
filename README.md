# 534 Project

[![Build Status](https://travis-ci.com/claudia-nikel/534_project.svg?branch=master)](https://travis-ci.com/claudia-nikel/534_project)

**Contributors:** Claudia Nikel, KT Hobbs & Shreeram Murali

# NASA Mars API
To retrieve and visualize weather data from the last 7 sols (martian days) as updated daily by NASA.

# Installation:
clone repository

`git clone https://github.com/claudia-nikel/534_project/`

in command line:

`R CMD build maRs`

`R CMD INSTALL maRs_0.1.tar.gz`

in R console:

`library(maRs)`


# Software Requirements
`maRs` was built on R version 3.5.0; therefore, it is recommended to use a similar version or higher to avoid compatability issues.

# Functions

`windspeed`: visualizes the inputted sol's windspeed (m/s) as a dial. The black bar is the average windspeed for the sol, which corresponds to the black text. The green background is the sol range (min and max), and the red or green text below is represents a decrease or increase, respectively, relative to the previous sol's average.


`pressure`: visualizes the inputted sol's pressure (Pascals) as a dial. The black bar is the average pressure for the sol, which corresponds to the black text. The orange background is the sol range (min and max), and the red or green text below is represents a decrease or increase, respectively, relative to the previous sol's average.

`temperature`: visualizes the inputted sol's pressure (converted from Farhenheit to degrees Celsius) as a dial. The black bar is the average pressure for the sol, which corresponds to the black text. The blue background is the sol range (min and max), and the red or green text below is represents a decrease or increase, respectively, relative to the previous sol's average.


# Input
For windspeed, pressure, and temperature visualizations, user must input a sol number from the previous 7 sols (e.g. windspeed(417)).

If the input is not within the last 7 sols, an error message will return listing valid options.


# Output

`windspeed(417)`

!(windspeed_example)[images/windspeed.png]
