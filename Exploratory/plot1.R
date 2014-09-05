file <- "./data/household_power_consumption.txt"   # set the file location in local system

hpc <- read.csv(file, sep=";", na.strings="?", stringsAsFactors=FALSE) #get the file and set the ? as na value

hpc2 <- hpc[min(which(hpc$Date == "1/2/2007")):max(which(hpc$Date == "2/2/2007")),] # get the 2 days I'm interested in by specifying a range

rm("hpc")   # get my RAM back by deleting

hist(hpc2$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)") # create plot, set the main title, x axis title, bar colour

dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px")  #copy the plot to png file in working dir and set its size

dev.off() # close the png device
