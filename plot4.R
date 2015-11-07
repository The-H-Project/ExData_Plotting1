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
png(filename='plot4.png', bg='transparent')

# Create a 2x2 window frame.
par(mfrow=c(2,2))

# Draw the first graph (upper left).
plot(graphset$DateTime, graphset$Global_active_power, type='s', xlab='', ylab='Global Active Power')

# Draw the second graph (upper right).
plot(graphset$DateTime, graphset$Voltage, type='s', xlab='datetime', ylab='Voltage')

# Draw the third graph (lower left).
plot(graphset$DateTime, graphset$Sub_metering_1, xlab='', ylab='Energy sub-metering', type='s')
lines(graphset$DateTime, graphset$Sub_metering_2, col=2)
lines(graphset$DateTime, graphset$Sub_metering_3, col='blue')
legend ('topright', col=c('black','red','blue'), lwd=1, bty='n',
       legend=c('Sub_metering_1','Sub_metering_2', 'Sub_metering_3'))

# Draw the fourth graph (lower right).
plot(graphset$DateTime, graphset$Global_reactive_power, type='s', xlab='datetime', ylab='Global_reactive_power')

# Close the plot device, and reset the window to one graph.
dev.off()
par(mfrow=c(1,1))

