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

# set our width and height variables
pngWidth = 480
pngHeight = 480

# set our filename for the png file
pngFileName = "plot1.png"

# open our file connection
png(pngFileName, width = pngWidth, height = pngHeight, units = "px", res = 72)

# create our histogram
hist(powerData$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", main = "Global Active Power")

# close our file connection
dev.off()