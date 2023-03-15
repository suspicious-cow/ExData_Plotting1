# check to see if the dplyr package is installed and the library is loaded
# if anything is missing, install and load as needed
print("Loading packages and libraries if needed...")
if (!require("data.table")) {
  install.packages("data.table")
  library(data.table)
} else {
  library(data.table)
}

# load the data
powerData <- fread("household_power_consumption.txt", sep = ";", header = TRUE)

# convert the dates to the proper format and make sure they are the date class
powerData$Date <- as.Date(powerData$Date, format = "%d/%m/%Y")

# grab our subset of data we want by the dates specified
powerData <- powerData[between(Date, "2007-02-01", "2007-02-02")]

# convert the global_active_power column to numeric
powerData$Global_active_power <- as.numeric(powerData$Global_active_power)

# add a datetime column to our table for plotting on the x axis
powerData$DateTime <- as.POSIXct(paste(powerData$Date, powerData$Time), format="%Y-%m-%d %H:%M:%S")

# set our width and height variables
pngWidth = 480
pngHeight = 480

# set our filename for the png file
pngFileName = "plot2.png"

# open our file connection
png(pngFileName, width = pngWidth, height = pngHeight, units = "px", res = 72)

# create our line plot
plot(y = powerData$Global_active_power, x = powerData$DateTime, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# close our file connection
dev.off()