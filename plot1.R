# Load required packages:
# data.table 1.9.6 or higher
library(data.table)

# Load the data file.
dataset <- fread('./Exploratory Data Analysis/household_power_consumption.txt', na.strings='?')
