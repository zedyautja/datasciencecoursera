#setwd("~/GitHub/R-working/Coursera stuff/Exploratory data analysis")

file <- "./data/household_power_consumption.txt"   # set the file location in local system

hpc <- read.csv(file, sep=";", na.strings="?", stringsAsFactors=FALSE) #get the file and set the ? as na value

hpc2 <- hpc[min(which(hpc$Date == "1/2/2007")):max(which(hpc$Date == "2/2/2007")),] # get the 2 days I'm interested in by specifying a range

rm("hpc")   # get my RAM back by deleting

Date_Time <- paste(hpc2$Date,hpc2$Time)  # combine date and time for the x axis value and add column to data

hpc2$DateTime <-strptime(Date_Time, "%d/%m/%Y %H:%M:%S")   # confirm the date and time format

# plot definition area

par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0)) # mfrow ( nr,nc) mar and oma (b,l,t,r) Setup layout, grid and margins

with (hpc2, {
  plot(DateTime, Global_active_power,  type ="l", xlab = "", ylab = "Global Active Power") #top left
  plot(DateTime, Voltage,  type ="l", xlab = "datetime") #top right
  plot(DateTime, Sub_metering_1,  type ="l", xlab = "", ylab = "Energy sub metering") # create plot, clear the main title, clear the x axis title, set to line type
      points(DateTime, Sub_metering_2, type = "l", col = "red") # add second column points and set to red colour line
      points(DateTime, Sub_metering_3, type = "l", col = "blue") # add third column points and set to blue colour line
      legend("topright", xjust = 1, bty = "n", col = c("black", "red", "blue"), lwd = 2, cex = 0.8, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) # create top right legend
  plot(DateTime, Global_reactive_power,  type ="h", xlab = "datetime") # bottom right
})

dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px")  #copy the plot to png file in working dir and set its size

dev.off() # close the png device

