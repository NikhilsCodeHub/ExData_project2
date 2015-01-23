###=== Plot 2

##=== Load Dplyr 
library(dplyr)

## Read and Groupby data for the Plot1
NEI <- readRDS("summarySCC_PM25.rds")
NEI<-tbl_df(NEI)

##=== Filter for Baltimore City, Maryland using fips =="24510" and Group Data by Year and Summarise
plot1DF<- NEI %>% filter(fips=="24510") %>%
    group_by(year) %>% summarise(sum(Emissions))

##=== update column names
colnames(plot1DF)=c("Year", "Total_Emissions")


##=== Begin Base PLotting functions
#--- setup par function with line width= 5, lables=horizontal, margins, magnification of axes for clarity
par(lwd=5, las=1, mar=c(6,5,4,2), mgp=c(4,1,0))

#--- Start the plotting activity with type=n 
plot(plot1DF$Year, plot1DF$Total_Emissions, xlim=c(1998, 2009), type="n", xlab="Year", ylab="Total Emissions")

#--- Draw the lines
lines(plot1DF$Year, plot1DF$Total_Emissions, type="l" )

#--- Plot the points
points(plot1DF$Year, plot1DF$Total_Emissions, pch=19, col="blue")

#--- Set Title
title("Annual PM2.5 Emissions \n for Balitmore City, Maryland")
par(lwd=2)

#--- Set Legend
legend("topright", legend="PM2.5 Emission", pch=19, col="blue" )

#=== Copy the plot to PNG file.
dev.copy(png, "plot2.png", width=480, height=480, units="px")
dev.off()


