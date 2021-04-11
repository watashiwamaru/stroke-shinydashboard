
library(scales)
library(dplyr)
library(tidyverse)
library(ggplot2)
library(plotly)
library(shinydashboard)
library(shiny)
library(DT)
library(glue)

options(scipen = 9999)

data_stroke <- read.csv("tidy_stroke_dataset.csv")

