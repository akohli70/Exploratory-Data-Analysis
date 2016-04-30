## Read Data Files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Calculate Total PM2.5 emission from all sources
totalPM <- tapply(NEI$Emissions, NEI$year, sum)

png("plot1.png",width=640)

plot(names(totalPM), totalPM, 
  type="l", xlab = "Year", 
  ylab = "Total PM2.5 Emission (tons)", 
  main = "Total United Stated PM2.5 Emission all sources from years 1999 to 2008", 
  col="blue")
dev.off()