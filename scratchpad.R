# load packages
install.packages("data.table")
library(data.table)

# load the data
powerData <- fread("household_power_consumption.txt", sep = ";", header = TRUE)

# convert the dates to the proper format and make sure they are the date class
powerData$Date <- as.Date(powerData$Date, format = "%d/%m/%Y")

# grab our subset of data we want by the dates specified
powerData <- powerData[between(Date, "2007-02-01", "2007-02-02")]

# set our width and height variables
pngWidth = 480
pngHeight = 480

# set our filename for the png file
pngFileName = "plot1.png"



