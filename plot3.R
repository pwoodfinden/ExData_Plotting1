
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


## Plot 3
png(filename = "plot3.png", width = 480, height = 480, units = "px")
plot(epc1$DateTime, epc1$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(epc1$DateTime, epc1$Sub_metering_1, type = "l", col = "black")
lines(epc1$DateTime, epc1$Sub_metering_2, type = "l", col = "red")
lines(epc1$DateTime, epc1$Sub_metering_3, type = "l", col = "blue")
legend("topright", lwd = c(1, 1, 1), col = c("black", "red", "blue"), 
       legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"))
dev.off()