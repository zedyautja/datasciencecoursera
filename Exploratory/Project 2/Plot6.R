# Q6 Compare emissions from motor vehicle sources in Baltimore City with emissions from 
# motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# For this question I have taken "motor vehicle" very literally. My classification therefore contains
# ALL items in the subclass Mobile in the SCC document's variable EI.Sector. These motor vehicle types
# include On road and off road vehicles, Aircraft, Commercial Marine vessels and Locomotives.

#N.B. As this question requires the comparison of 2 vastly different areas, a county and a city
# some form of transformation needed to be applied. Without this transformation it is all too easy 
#to be blinded by the "raw" difference in tonnage of PM2.5. My transformation is to normalise the 
#4 emission totals per location so that the mean = 4 and the SD = 1. This means that the size of change 
#can be clearly seen as a proportion of the whole, at the same scale.
# set the working directory


setwd("~/GitHub/datasciencecoursera/Exploratory/Project 2") 

#Load libraries
library(ggplot2)
library(dplyr)

#load the data from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# fix column name in SCC to something easier and in relation to the question
colnames(SCC)[4] <- "USE"

# drop all columns but SCC and USE. 
SCC2 <- SCC %>%
        select(SCC, USE)

# drop all non motor vehicle codes, leaving only those SCC's we need to find in NEI. This list could be more efficient
SCC2 <- subset(SCC2, USE %in% c("Mobile - On-Road Gasoline Light Duty Vehicles","Mobile - On-Road Gasoline Heavy Duty Vehicles","Mobile - On-Road Diesel Light Duty Vehicles",
                                "Mobile - On-Road Diesel Heavy Duty Vehicles","Mobile - Non-Road Equipment - Gasoline","Mobile - Non-Road Equipment - Other",               
                                "Mobile - Non-Road Equipment - Diesel", "Mobile - Aircraft","Mobile - Commercial Marine Vessels","Mobile - Locomotives"))

# use subset with the list of Motor vehicle sources on the NEI file to 
#subset that data, alongside the fips for Baltimore (24510) and LA (06037).
NEIVB <- subset(NEI, SCC %in% SCC2$SCC & fips == "24510")
NEIVLA <- subset(NEI, SCC %in% SCC2$SCC & fips == "06037")

# test to normalise
NEIVB <- ddply(NEIVB, .(year, fips), function(x) sum(x$Emissions))
NEIVLA <- ddply(NEIVLA, .(year, fips), function(x) sum(x$Emissions))

NEIVB$V1 <- scale(NEIVB$V1)
NEIVLA$V1 <- scale(NEIVLA$V1)

# check that we get mean of 0 and sd of 1
colMeans(NEIVB$V1)  # faster version of apply(scaled.dat, 2, mean)
apply(NEIVB$V1, 2, sd)
colMeans(NEIVLA$V1)  # faster version of apply(scaled.dat, 2, mean)
apply(NEIVLA$V1, 2, sd)


# combine the 2 geographic subsets
NEIVBLA <- rbind(NEIVB, NEIVLA)

# Rename the 3rd column to Emissions and 2nd to Location
colnames(NEIVBLA)[3] <- "Emissions"
colnames(NEIVBLA)[2] <- "Location"

# rename the values in the new Location column to user friendly labels
NEIVBLA$Location<- ifelse(NEIVBLA$Location == "06037", "Los Angeles", "Baltimore")

#arrange the Location column so that "like" group members are together before plotting
NEIVBLA <- arrange(NEIVBLA, Location)

#Normalised Plot written to .PNG


png("plot6.png") 
qplot(year, Emissions, data=NEIVBLA, color = Location, geom ="line") + ggtitle("Normalised Comparison of Balitimore City and Los Angeles\n County, Motor Vehicle related 2.5 Emissions total by year") + xlab("Year") + ylab("Normalised Change - Mean = 0, SD = 1") 
dev.off()


# ANSWER: With the emission outputs normalised to the same scale it can be seen that the 
#proportional change over time is far closer than the raw data would suggest on first inspection.
#It can be seen that Baltimore makes the greatest change over time when the data are transformed 
#to a directly comparable scale. Perhaps more importantly, Baltimore has improved its situation 
#in terms of this polution over the period reported.

# For this question I have taken "motor vehicle" very literally. My classification therefore contains
# ALL items in the subclass Mobile in the SCC document's variable EI.Sector. These motor vehicle types
# include On road and off road vehicles, Aircraft, Commercial Marine vessels and Locomotives.

#N.B. As this question requires the comparison of 2 vastly different areas, a county and a city
# some form of transformation needed to be applied. Without this transformation it is all too easy 
#to be blinded by the "raw" difference in tonnage of PM2.5. My transformation is to normalise the 
#4 emission totals per location so that the mean = 4 and the SD = 1. This means that the size of change 
#can be clearly seen as a proportion of the whole, at the same scale.
# set the working directory

# the code below this line is that which I used to inspect the data without normalising
#####################################################

#Code to run the standard plot without normalisation that I used to inspect the totals

# combine the 2 geographic subsets
#NEIVBLA <- rbind(NEIVB, NEIVLA)

# use ddply to sum the emmisions by year for each of the city files
#NEIVBLAPM25 <- ddply(NEIVBLA, .(year, fips), function(x) sum(x$Emissions))

# Rename the 3rd column to Emissions and 2nd to Location
#colnames(NEIVBLAPM25)[3] <- "Emissions"
#colnames(NEIVBLAPM25)[2] <- "Location"

# rename the values in the new Location column to user friendly labels
#NEIVBLAPM25$Location<- ifelse(NEIVBLAPM25$Location == "06037", "Los Angeles", "Baltimore")

#arrange the Location column so that "like" group members are together before plotting
#NEIVBLAPM25 <- arrange(NEIVBLAPM25, Location)

# prepare to plot to png
#png("plot6.png") 
#qplot(year, Emissions, data=NEIVBLAPM25, color = Location, geom ="line") + ggtitle("Comparison of Balitimore City and Los Angeles County, Motor Vehicle related 2.5 Emissions total by year") + xlab("Year") + ylab("Total PM 2.5 Emissions (in tons)") 
#dev.off()
