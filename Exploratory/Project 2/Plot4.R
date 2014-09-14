# Q4 Across the United States, how have emissions from coal combustion-related sources changed 
# from 1999-2008?

# set the working directory
setwd("~/GitHub/datasciencecoursera/Exploratory/Project 2")

#Load libraries
library(ggplot2)
library(dplyr)

#load the data from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# fix column name in SCC to something easier
colnames(SCC)[4] <- "Fuel"

# drop all columns but SCC and Fuel. 

SCC2 <- SCC %>%
        select(SCC, Fuel)

# drop all non COAL codes, leaving only those SCC's we need to find in NEI

SCC2 <- subset(SCC2, Fuel %in% c("Fuel Comb - Electric Generation - Coal","Fuel Comb - Industrial Boilers, ICEs - Coal","Fuel Comb - Comm/Institutional - Coal" ))

# use subset with the list of coal fueled sources on the NEI file to subset that data.
NEICOAL <- subset(NEI, SCC %in% SCC2$SCC)

# use ddply to sum the emmisions by year and type
NEICOALPM25 <- ddply(NEICOAL, .(year, type), function(x) sum(x$Emissions))

# Rename the thirdcolumn to Emissions
colnames(NEICOALPM25)[3] <- "Emissions"

# prepare to plot to png
png("plot4.png") 
qplot(year, Emissions, data=NEICOALPM25, color=type, geom ="line") + ggtitle("United States Coal Source related\n PM 2.5 Emissions by type and year") + xlab("Year") + ylab("Total PM 2.5 Emissions (in tons)")
dev.off()

# ANSWER : POINT type PM2.5 emissions have fallen overall over the period being studied. The fall rate was not consistent over the period; there was a strong fall in 1999 to 2002, a small rise between 2002 and 2005. and a second strong fall between 2005 and 2008.
#          NONPOINT type PM2.5 emission have fallen very slightly over the whole period. The period 1999 to 2002 showed a rise in NONPOINT type emissions, 2002 to 2005 showed very little change. The period 2005 to 2008 showed a fall to slightly below 1999 levels.
