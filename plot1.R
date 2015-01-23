### Plot 1

## Load Dplyr 
library(dplyr)

## Read and Groupby data for the Plot1
NEI <- readRDS("summarySCC_PM25.rds")
NEI<-tbl_df(NEI)
group_by(NEI, year) %>% summarise(sum(Emissions))

## Begin Base PLotting functions
par(lwd=5, las=1, mar=c(5,5,3,2), mgp=c(4,1,0))
plot(plot1DF$Year, plot1DF$Total_Emissions, xlim=c(1998, 2009), ylim=c(3000000, 7500000),type="n", xlab="Year", ylab="Total Emissions")
lines(plot1DF$Year, plot1DF$Total_Emissions, type="l" )
points(plot1DF$Year, plot1DF$Total_Emissions, pch=19, col="blue")
title("Trend of PM2.5 Emission")
par(lwd=2)
legend("topright", legend="PM2.5 Emission", pch=19, col="blue" )
dev.copy(png, "plot1.png", width=480, height=480, units="px")
dev.off()


