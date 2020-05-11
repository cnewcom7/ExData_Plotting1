
# Read in all of the data as CSV 
powerdata <- read.csv('household_power_consumption.txt', sep = ';', na.strings = '?', 
                      stringsAsFactors = FALSE, header = TRUE)

# Subset just data needed and format 'Date' correctly
FebData <- subset(powerdata, Date %in% c('1/2/2007', '2/2/2007'))
FebData[, 'Date'] <- as.Date(FebData[, 'Date'], format = '%d/%m/%Y')

# Merge 'Date' and 'Time' and format 'Time' to Time class
combineDateTime <- paste(FebData[, 'Date'], FebData[, 'Time'])
formatDateTime <- strptime(combineDateTime, format = '%Y-%m-%d %H:%M:%S')

# Makes a 2x2 grid to plot each graph with adjusted margins
# Plotting order goes top-left, bottom-left, top-right, bottom-right
par(mfcol = c(2,2), mar = c(5, 4, 2, 2))

# Plot GAP vs. Date/Time (plot 2 output)
plot(formatDateTime, FebData[, 'Global_active_power'], type = 'l', xlab = ' ', 
     ylab = 'Global Active Power (kilowatts)')

# Plot each SubMetering data set vs Time (plot 3 output), made legend smaller with 'cex = 0.75'
plot(formatDateTime, FebData[, 'Sub_metering_1'], type = 'l', xlab = '', ylab = 'Energy sub metering')
  lines(formatDateTime, FebData[, 'Sub_metering_2'], type = 'l', col = 'red')
  lines(formatDateTime, FebData[, 'Sub_metering_3'], type = 'l', col = 'blue')
  legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       col = c('black', 'red', 'blue'), lty = 1, cex = 0.75 )

# Plot Voltage vs Date/Time    
plot(formatDateTime, FebData[, 'Voltage'], type = 'l', xlab = 'DateTime', ylab = 'Voltage')

# Plot GRP vs Date/Time
plot(formatDateTime, FebData[, 'Global_reactive_power'], type = 'l', 
     xlab = 'DateTime', ylab = ' Global Reactive Power')

# Save copy of all four plots as PNG
dev.copy(png, 'plot4.png', height = 480, width = 480)
dev.off()

