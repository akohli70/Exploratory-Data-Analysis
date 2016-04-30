library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


Baltimore <- subset (NEI, fips == "24510")
LA <- subset(NEI,fips =="06037")

vehiclesSCC <- subset (SCC,grepl("vehicle", EI.Sector,ignore.case = TRUE))
vehiclesBaltimore <- subset(Baltimore, SCC %in% vehiclesSCC$SCC)
vehiclesLA <- subset(LA, SCC %in% vehiclesSCC$SCC)

vehiclesAll <- rbind(vehiclesLA,vehiclesBaltimore)

totalPM25 <- aggregate (Emissions ~ fips * year, data =vehiclesAll, FUN = sum ) 
totalPM25$City_County <- ifelse(totalPM25$fips == "24510", "Baltimore", "Los Angles")

png("plot6.png",width=640)
plot6 <- ggplot(totalPM25, aes(x=totalPM25$year,y=totalPM25$Emissions,color=totalPM25$City_County)) + geom_line()
plot6 <- plot6 + ggtitle("Motor Vehicle Emission Levels PM2.5 in Los Angles and Baltimore") 
plot6 <- plot6 + xlab("Year") 
plot6 <- plot6 + ylab("Levels of PM2.5 Emissions")
plot6 <- plot6 + theme(legend.title = element_text(color="black", size=12, face="bold"))+
  scale_color_discrete(name="City/County")

print(plot6)
dev.off()