#setwd("~/GitHub/R-working/Coursera stuff/Exploratory data analysis")

file <- "./data/household_power_consumption.txt"   # set the file location in local system

hpc <- read.csv(file, sep=";", na.strings="?", stringsAsFactors=FALSE) #get the file and set the ? as na value

hpc2 <- hpc[min(which(hpc$Date == "1/2/2007")):max(which(hpc$Date == "2/2/2007")),] # get the 2 days I'm interested in by specifying a range

rm("hpc")   # get my RAM back by deleting

Date_Time <- paste(hpc2$Date,hpc2$Time)  # combine date and time for the x axis value and add column to data

hpc2$DateTime <-strptime(Date_Time, "%d/%m/%Y %H:%M:%S")   # confirm the date and time format


plot(hpc2$DateTime, hpc2$Sub_metering_1,  type ="l", xlab = "", ylab = "Energy sub metering") # create plot, clear the main title, clear the x axis title, set to line type

points(hpc2$DateTime, hpc2$Sub_metering_2, type = "l", col = "red") # add second column points and set to red colour line

points(hpc2$DateTime, hpc2$Sub_metering_3, type = "l", col = "blue") # add third column points and set to blue colour line

legend("topright", xjust = 1, col = c("black", "red", "blue"), lwd = 2, cex = 0.8, legend = c("Sub_metering_1    ", "Sub_metering_2"    , "Sub_metering_3    ")) # create top right legend

dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px")  #copy the plot to png file in working dir and set its size

dev.off() # close the png device


