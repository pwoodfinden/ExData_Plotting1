
setwd("C:/Coursera/Data_Science/Exploratory_Data_Analysis/data")
library(data.table)
library(lubridate)

## Read in Electrical Usage data
epc <- fread("household_power_consumption.txt", header = TRUE, sep = ";",
             colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric"
                            , "numeric", "numeric", "numeric"))
## Subset to dates 01/02/2007 and 02/02/2007
epc1 <- subset(epc, Date == "1/2/2007" | Date == "2/2/2007")

## Add Datetime column (uses lubridate)
epc1$DateTime <- dmy_hms(paste(epc1$Date, epc1$Time))

## Column Classes - for some reason colClasses failed on import
epc1$Global_active_power <- as.numeric(epc1$Global_active_power)
epc1$Global_reactive_power <- as.numeric(epc1$Global_reactive_power)
epc1$Voltage <- as.numeric(epc1$Voltage)
epc1$Global_intensity <- as.numeric(epc1$Global_intensity)
epc1$Sub_metering_1 <- as.numeric(epc1$Sub_metering_1)
epc1$Sub_metering_2 <- as.numeric(epc1$Sub_metering_2)


## Plot 1
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(epc1$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (Kilowatts)")
dev.off()