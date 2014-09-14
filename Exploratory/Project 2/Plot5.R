# Q5 How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# For this question I have taken "motor vehicle" very literally. My classification therefore contains
# ALL items in the subclass Mobile in the SCC document's variable EI.Sector. These motor vehicle types
# include On road and off road vehicles, Aircraft, Commercial Marine vessels and Locomotives.

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

# use subset with the list of coal fueled sources on the NEI file to subset that data.
NEIVB <- subset(NEI, SCC %in% SCC2$SCC & fips == "24510")

# use ddply to sum the emmisions by year and type
NEIVBPM25 <- ddply(NEIVB, .(year), function(x) sum(x$Emissions))

# Rename the 2ndcolumn to Emissions
colnames(NEIVBPM25)[2] <- "Emissions"


# prepare to plot to png
png("plot5.png") 
qplot(year, Emissions, data=NEIVBPM25, geom ="line") + ggtitle("Baltimore, Motor Vehicle related\n PM 2.5 Emissions by year") + xlab("Year") + ylab("Total PM 2.5 Emissions (in tons)")
dev.off()


# ANSWER: Between 1999 and 2002 PM 2.5 emissions for Baltimore, Maryland, fell sharply- to less 
#than 50% of the 1999 figure. 2002 to 2005 saw a very slight increase. 2005 to 2008 saw a sharp 
#increase of almost 140 tons. The overall trend however is downward.

#N.B. Assessor please bear in mind that my defintion of Motor Vehicle includes all motorised
# vehicles which are included in the data. Therefore my total ton values will be significantly 
# higher than candidate who chose different definitions