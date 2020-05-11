
# Read in data as CSV dataframe
powerdata <- read.csv('household_power_consumption.txt', sep = ';', na.strings = '?', 
                      stringsAsFactors = FALSE, header = TRUE)

# Subset just data needed and format 'Date' to Date class
FebData <- subset(powerdata, Date %in% c('1/2/2007', '2/2/2007'))
FebData[, 'Date'] <- as.Date(FebData[, 'Date'], format = '%d/%m/%Y')

# Combine 'Date' and 'Time' and format 'Time' section to Time class
combineDateTime <- paste(FebData[, 'Date'], FebData[, 'Time'])
formatDateTime <- strptime(combineDateTime, format = '%Y-%m-%d %H:%M:%S')

# Plot all three SubMetering data on same graph vs Date/Time
# plot() puts first data set in graph, each subsequent line() adds on the other two
# legend() added to top right, 'lty = 1' or else no identifier for each is added to legend
plot(formatDateTime, FebData[, 'Sub_metering_1'], type = 'l', xlab = '', ylab = 'Energy sub metering')
  lines(formatDateTime, FebData[, 'Sub_metering_2'], type = 'l', col = 'red')
  lines(formatDateTime, FebData[, 'Sub_metering_3'], type = 'l', col = 'blue')
  legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
         col = c('black', 'red', 'blue'), lty = 1)
 
# Save copy of plot as PNG   
dev.copy(png, 'plot3.png', height = 480, width = 480)
dev.off()

  