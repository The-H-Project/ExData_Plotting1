# Load required packages:
# data.table 1.9.6 or higher
library(data.table)

# Load the data file. It is kept one level above the project working directory, because the 
# git repository may only include the R and .png files.
dataset <- fread('../household_power_consumption.txt', na.strings='?')

# Convert date and time text data into values.
dataset$Date <- as.Date(dataset$Date, format='%d/%m/%Y')

# Filter for 2/1/2007 and 2/2/2007.
graphset <- dataset[Date %between% c('2007-02-01','2007-02-02')]
rm(dataset)

# Combine the Date and Time into one continuous DateTime field, 
# and remove the individual Date and Time fields.
graphset[,DateTime := as.POSIXct(paste(graphset$Date,graphset$Time))]
graphset[,Date:= NULL]
graphset[,Time:= NULL]

plot(graphset$DateTime, graphset$Global_active_power, type='s', xlab='', 
     ylab='Global Active Power (kilowatts)')

# Export the graph to a png file.
dev.copy(png, './Exploratory\ Data\ Analysis/ExData_Plotting1/plot2.png')
dev.off()

