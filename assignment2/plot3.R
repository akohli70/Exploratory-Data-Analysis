library(ggplot2)
library(plyr)

## Read Data Files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Filter for Baltimore City
baltimore <- subset (NEI, fips == "24510")
typePM25 <- ddply(baltimore, .(year, type), function(x) sum(x$Emissions))

colnames(typePM25)[3] <- "Emissions"

png("plot3.png",width = 640)

plot3 <- ggplot(typePM25, aes(x=typePM25$year,y=typePM25$Emissions,color=typePM25$type)) + geom_line() + 
  ggtitle("Baltimore City PM2.5 Emmissions by source, type and year") + 
  xlab("Year") + ylab("Total PM2.5 Emissions (in tons)")

plot3 <- plot3 + theme(legend.title = element_text(color="black", size=12, face="bold"))+
  scale_color_discrete(name="Type")

print(plot3)
dev.off()