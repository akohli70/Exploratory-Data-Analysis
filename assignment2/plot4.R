library(ggplot2)
library(plyr)

## Read Data Files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Filter Coal SCC codes
coalSCC <- subset (SCC,grepl("coal", EI.Sector,ignore.case = TRUE))

## Filter NEI data based on Coal SCC codes
coalNEI <- subset(NEI, SCC %in% coalSCC$SCC)

## Calcucalte PM25 value
totalPM25 <- ddply(coalNEI, .(year, type), function(x) sum(x$Emissions))

# Rename the column
colnames(totalPM25)[3] <- "Emissions"

png("plot4.png",width=640)
plot4 <- ggplot(totalPM25, aes(x=totalPM25$year,y=totalPM25$Emissions,color=totalPM25$type)) + geom_line()
plot4 <- plot4 + stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", color = "black", aes(shape="total"), geom="line") 
plot4 <- plot4 + geom_line(aes(size="total", shape = NA)) 
plot4 <- plot4 + ggtitle("Coal Combustion PM2.5 Emissions by Source Type and Year") 
plot4 <- plot4 + xlab("Year") + ylab("Total PM2.5 Emissions (tons)")
plot4 <- plot4 + theme(legend.title = element_text(color="black", size=12, face="bold"))+
  scale_color_discrete(name="Type")

print(plot4)
dev.off()