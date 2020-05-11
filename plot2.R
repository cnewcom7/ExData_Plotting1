# Read entire file in as CSV data frame
powerdata <- read.csv('household_power_consumption.txt', sep = ';', na.strings = '?', 
                      stringsAsFactors = FALSE, header = TRUE)

# Subset just the Feb 1st and Feb 2nd data needed then convert 'Date' into Date Class
FebData <- subset(powerdata, Date %in% c('1/2/2007', '2/2/2007'))
FebData[, 'Date'] <- as.Date(FebData[, 'Date'], format = '%d/%m/%Y')

# Merge 'Date' and 'Time' columns together then format the 'Time' section to Time class
combineDateTime <- paste(FebData[, 'Date'], FebData[, 'Time'])
formatDateTime <- strptime(combineDateTime, format = '%Y-%m-%d %H:%M:%S')

# Plot the data for GAP vs. the Time/Date; type = 'l' makes it a line (defaults to scatterplot)
plot(formatDateTime, FebData[, 'Global_active_power'], type = 'l', xlab = ' ', 
     ylab = 'Global Active Power (kilowatts)')

# Save a PNG copy of the plot
dev.copy(png, 'plot2.png', width = 480, height = 480)
dev.off()



