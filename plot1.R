
# Read in entire dataset as CSV dataframe
powerdata <- read.csv('household_power_consumption.txt', sep = ';', na.strings = '?', 
              stringsAsFactors = FALSE, header = TRUE)

# Subset out just the data for Feb 1st and Feb 2nd
FebData <- subset(powerdata, Date %in% c('1/2/2007', '2/2/2007'))

# Convert 'Date' column entries into Date class
FebData[, 'Date'] <- as.Date(FebData[, 'Date'], format = '%d/%m/%Y')

# Merge the formatted 'Date' entries and the unformatted 'Time' entries
combineDateTime <- paste(FebData[, 'Date'], FebData[, 'Time'])

# Reformat 'Time' to Time class; formatting before merging causes incorrect dates to be attached to Time
formatDateTime <- strptime(combineDateTime, format = '%Y-%m-%d %H:%M:%S')

# Plot bar chart for GAP
hist(FebData[, 'Global_active_power'], main = 'Global Active Power', 
     xlab = 'Global Active Power (kilowatts)', col = 'red')

# Save plot as a PNG copy
dev.copy(png, 'plot1.png', height = 480, width = 480)
dev.off()
