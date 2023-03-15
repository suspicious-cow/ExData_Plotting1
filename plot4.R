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

# convert the columns we need to numeric
powerData$Global_active_power <- as.numeric(powerData$Global_active_power)
powerData$Global_reactive_power <- as.numeric(powerData$Global_reactive_power)
powerData$Voltage <- as.numeric(powerData$Voltage)
powerData$Sub_metering_1 <- as.numeric(powerData$Sub_metering_1)
powerData$Sub_metering_2 <- as.numeric(powerData$Sub_metering_2)
powerData$Sub_metering_3 <- as.numeric(powerData$Sub_metering_3)

# add a datetime column to our table for plotting on the x axis
powerData$DateTime <- as.POSIXct(paste(powerData$Date, powerData$Time), format="%Y-%m-%d %H:%M:%S")

# set our width and height variables
pngWidth = 480
pngHeight = 480

# set our filename for the png file
pngFileName = "plot4.png"

# open our file connection
png(pngFileName, width = pngWidth, height = pngHeight, units = "px", res = 72)

# set up our page to hold four plots
par(mfcol = c(2,2))

# add our line plot from plot2.R
# create our line plot
plot(y = powerData$Global_active_power, x = powerData$DateTime, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# add our line plot from plot3.R
plot(y = powerData$Sub_metering_1, x = powerData$DateTime, type = "l", xlab = "", ylab = "Energy sub metering")
lines(y = powerData$Sub_metering_2, x = powerData$DateTime, type = "l", col = "red")
lines(y = powerData$Sub_metering_3, x = powerData$DateTime, type = "l", col = "blue")

# add a legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")

# add our line plot for voltage over time
plot(y = powerData$Voltage, x = powerData$DateTime, ylab = "Voltage", xlab = "datetime", type = "l")

# add our line plot for global reactive power over time
plot(y = powerData$Global_reactive_power, x = powerData$DateTime, ylab = "Global_reactive_power", xlab = "datetime", type = "l")

# close our file connection
dev.off()