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
# Plot 2 Line graph
png(filename = "plot2.png", width = 480, height = 480, units = "px")
par(mfrow=c(1,1))
with(power.2,plot(DateTime,Global_active_power, type = "n", xlab = "",
                  ylab = "Global Active Power (kilowatts)"))
with(power.2,lines(DateTime,Global_active_power))
dev.off()