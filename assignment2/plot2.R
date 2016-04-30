## Read Data Files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Filter for Baltimore City
MD.Baltimore <- subset (NEI, fips == "24510")
totalPM <- tapply(MD.Baltimore$Emissions, MD.Baltimore$year, sum)

png("plot2.png",width=640)
plot(names(totalPM), 
     totalPM, 
     type = "l", 
     xlab="Year", 
     ylab= "Total PM2.5 Emissions (tons)", 
     main= "Total for Baltimore City PM2.5 Emission by Year", 
     col = "blue")
dev.off()