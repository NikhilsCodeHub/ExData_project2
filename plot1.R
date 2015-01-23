### Plot 1

## Load Dplyr 
library(dplyr)

##=== Read and Groupby data for the Plot1
NEI <- readRDS("summarySCC_PM25.rds")
NEI<-tbl_df(NEI)

##=== group the data by Year
plot1DF<-group_by(NEI, year) %>% summarise(sum(Emissions))
colnames(plot1DF)=c("Year", "Total_Emissions")

##=== Begin Base PLotting functions
#--- setup par function with line width= 5, lables=horizontal, margins, magnification of axes for clarity
par(lwd=5, las=1, mar=c(5,5,3,2), mgp=c(4,1,0))

#--- Start the plotting activity with type=n 
plot(plot1DF$Year, plot1DF$Total_Emissions, xlim=c(1998, 2009), ylim=c(3000000, 7500000),type="n", xlab="Year", ylab="Total Emissions")

#--- Draw the lines
lines(plot1DF$Year, plot1DF$Total_Emissions, type="l" )

#--- Plot the points
points(plot1DF$Year, plot1DF$Total_Emissions, pch=19, col="blue")

#--- Set Title
title("Trend of PM2.5 Emission in US")
par(lwd=2)

#--- Set Legend
legend("topright", legend="PM2.5 Emission", pch=19, col="blue" )

#=== Copy the plot to PNG file.
dev.copy(png, "plot1.png", width=480, height=480, units="px")
dev.off()


