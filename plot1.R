# Load required packages:
# data.table 1.9.6 or higher
library(data.table)

# Load the data file.
dataset <- fread('./Exploratory Data Analysis/household_power_consumption.txt', na.strings='?')

# Convert date and time text data into values.
dataset$Date <- as.Date(dataset$Date, format='%d/%m/%Y')

# Filter for 2/1/2007 and 2/2/2007.
graphset <- dataset[Date %between% c('2007-02-01','2007-02-02')]
rm(dataset)

# Combine the Date and Time into one continuous Date Time field.
graphset[,DateTime := as.POSIXct(paste(graphset$Date,graphset$Time))]
