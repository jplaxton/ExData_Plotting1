# Load libraries required for script
library(lubridate)
library(dplyr)
#
# read data table from current working directory
power <- read.table(
        './household_power_consumption.txt',
        header=T,sep=";",stringsAsFactors = F,na.strings = "?")
#
# add column with date and time pasted together
power.1<-mutate(power,DateTime = paste(Date,Time))
#
# convert new column into date and time format
power.1[,"DateTime"]<- dmy_hms(power.1[,"DateTime"])
#
# subset data for the dates indicated
power.2<-subset(power.1,DateTime>ymd("2007-02-01") & DateTime<ymd("2007-02-03"))
#
# Plot 4 2 X 2 plot matrix
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2))
with(power.2,plot(DateTime,Global_active_power, type = "n", xlab = "",
                  ylab = "Global Active Power"))
with(power.2,lines(DateTime,Global_active_power))
with(power.2,plot(DateTime,Voltage, type = "n"))
with(power.2,lines(DateTime,Voltage))
with(power.2,plot(DateTime, Sub_metering_1, type = "n", xlab = "",
                  ylab = "Energy sub metering"))
with(power.2,lines(DateTime,Sub_metering_1))
with(power.2,lines(DateTime,Sub_metering_2,col="red"))
with(power.2,lines(DateTime,Sub_metering_3,col="blue"))
legend("topright",lty = 1,col = c("black","red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty = "n")
with(power.2,plot(DateTime,Global_reactive_power, type = "n"))
with(power.2,lines(DateTime,Global_reactive_power))
dev.off()