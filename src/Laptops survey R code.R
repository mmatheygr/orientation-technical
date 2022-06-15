### Load libraries
library(tidyverse)
library(readxl)

### Import data

Survey_2022 <- read.csv("C:/Users/mauri/Downloads/2022-06-14-survey.txt")
Survey_2021 <- read.csv("C:/Users/mauri/Downloads/2021-06-15-survey.txt")

### Remove CUDA count from 2022 as it doesn't appear in 2021

Survey_2022 <- Survey_2022[-8]

### Add year to data

Survey_2021$Year <- 2021
Survey_2022$Year <- 2022

### Put together both surveys

new_headers <- c('Time', 'OS', 'CPU_GHz', 'CPU_cores', 'RAM_(GB)', 'Storage_(GB)', 'GPU_Description', 'Year')
colnames(Survey_2021) <- new_headers
colnames(Survey_2022) <- new_headers
total_surveys <- rbind(Survey_2021, Survey_2022)

### Eliminate outliers and change data

total_surveys <- total_surveys %>% filter(`RAM_(GB)` < 100)
total_surveys$OS <- if_else(total_surveys$OS == "Windows 10", "Windows", total_surveys$OS)

### Total Windows vs Mac

ggplot(total_surveys, aes(OS, fill = factor(Year))) + geom_bar(position = "dodge")

### Proportion of Windows vs Mac

ggplot(total_surveys, aes(factor(Year), fill = OS)) + geom_bar(position = "fill")

### CPU GHz

ggplot(total_surveys, aes(factor(Year), CPU_GHz, fill = factor(Year))) + geom_boxplot()

### RAM

ggplot(total_surveys, aes(factor(Year), `RAM_(GB)`, fill = factor(Year))) + geom_boxplot()

### Storage

ggplot(total_surveys, aes(factor(Year), `Storage_(GB)`, fill = factor(Year))) + geom_boxplot()       