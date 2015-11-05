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

# Combine the Date and Time into one continuous Date Time field.
graphset[,DateTime := as.POSIXct(paste(graphset$Date,graphset$Time))]

# Open the png plot device.
png(filename='plot3.png')

# Draw the graph.
plot(graphset$DateTime, graphset$Sub_metering_1, xlab='', ylab='Energy sub-metering', type='s')
lines(graphset$DateTime, graphset$Sub_metering_2, col=2)
lines(graphset$DateTime, graphset$Sub_metering_3, col='blue')
legend ('topright', col=c('black','red','blue'), lwd=1,
        legend=c('Sub_metering_1','Sub_metering_2', 'Sub_metering_3'))

# Close the plot device.
dev.off()
