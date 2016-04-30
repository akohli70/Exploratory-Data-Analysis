library(ggplot2)
library(plyr)

## Read Data Files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- subset (NEI, fips == "24510")
vehiclesSCC <- subset (SCC,grepl("vehicle", EI.Sector,ignore.case = TRUE))
vehiclesNEI <- subset(baltimore, SCC %in% vehiclesSCC$SCC)

totalPM25 <- ddply(vehiclesNEI, .(year), function(x) sum(x$Emissions))
colnames(totalPM25)[2] <- "Emissions"

png("plot5.png",width = 640)
plot5 <- ggplot(totalPM25, aes(x=totalPM25$year,y=totalPM25$Emissions)) + geom_line()
plot5 <- plot5 + ggtitle("Baltimore City PM2.5 Motor Vehicle Emissions from 1999 to 2008") 
plot5 <- plot5 + xlab("Year")
plot5 <- plot5 + ylab("Total PM2.5 Emission (tons)")

print(plot5)
dev.off()