# Q3 Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
#which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City?
#Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make 
#a plot answer this question.

# I want to make 4 lines on 1 plot with a legend for this one.

# set the working directory
setwd("~/GitHub/datasciencecoursera/Exploratory/Project 2")

#Load libraries
library(ggplot2)
library(plyr)

#load the data from working directory
NEI <- readRDS("summarySCC_PM25.rds")              

# subset the NEI data to return only Baltimore, Maryland observations
balt <- subset(NEI, fips == 24510) 

# use ddply to sum the emmisions by year and type
balttot <- ddply(balt, .(year, type), function(x) sum(x$Emissions))

# Rename the thirdcolumn to Emissions
colnames(balttot)[3] <- "Emissions"

# prepare to plot to png
png("plot3.png") 
qplot(year, Emissions, data=balttot, color=type, geom ="line") + ggtitle("Baltimore City PM 2.5 Emissions\n by source, type and year") + xlab("Year") + ylab("Total PM 2.5 Emissions (in tons)")
dev.off()

# ANSWER: It can be seen from the graph that NON-ROAD, NONPOINT and ON-ROAD all show downward trends over the period reported
# It can also be seent that the POINT data show a small overall upward trend, with a large peak in 2005
