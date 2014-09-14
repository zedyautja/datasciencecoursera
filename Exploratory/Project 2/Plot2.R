# Q2 Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# set the working directory
setwd("~/GitHub/datasciencecoursera/Exploratory/Project 2")

#load the data from working directory
NEI <- readRDS("summarySCC_PM25.rds")             

# subset the NEI data to return only Baltimore, Maryland observations
balt <- subset(NEI, fips == 24510) 

#use tapply() to find the sum total of emmissions by year and store this as the Y axis data 
Q2y <- tapply(balt$Emissions, balt$year,sum)   

#use unique() to find the discrete year values for the x-axis
Year <- unique(balt$year)                       


# prepare to plot to png
png("plot2.png") 
plot(Year,Q2y, type = "l",main = "Total PM 2.5 emissions in Baltimore, United States", 
     ylab = "Total PM 2.5 emissions (in tons)")
dev.off()


# ANSWER: The overall trend for Balitmore, Maryland is also generally downward.
# It is not a smooth trend and would benefit earlier or later data to confirm 