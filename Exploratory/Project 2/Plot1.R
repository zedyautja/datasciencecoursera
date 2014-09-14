#Q1 Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from 
#all sources for each of the years 1999, 2002, 2005, and 2008.

# set the working directory
setwd("~/GitHub/datasciencecoursera/Exploratory/Project 2") 

#load the data from working directory
NEI <- readRDS("summarySCC_PM25.rds")                     

#use tapply() to find the sum total of emmissions by year and store this as the Y axis data
Q1y <- tapply(NEI$Emissions, NEI$year,sum)    

#use unique() to find the discrete year values for the x-axis
Year <- unique(NEI$year)                       

# plot a line graph to see the trend. With simple labels  ADD LABELS
 

# prepare to plot to png
png("plot1.png") 
plot(Year,Q1y, type = "l", main = "Total PM 2.5 emissions in United States", 
     ylab = "Total PM 2.5 emissions (in tons)")  
dev.off()

# ANSWER:  The trend is clearly downwards