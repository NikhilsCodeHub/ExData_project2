### Plot 3

## Load Dplyr 
library(dplyr)
library(ggplot2)

## Read and Groupby data for the Plot1
NEI <- readRDS("summarySCC_PM25.rds")
NEI<-tbl_df(NEI)

## Filter for Baltimore City, Maryland using fips =="24510" and Group Data by Year & Type and Summarise
plot1DF<- NEI %>% filter(fips=="24510") %>%
    group_by(year, type) %>% summarise(sum(Emissions))

## update column names
colnames(plot1DF)=c("Year", "Type", "Total_Emissions")

## Using ggplot and line color to identify sources with decreased emissions.
g<-ggplot(plot1DF, aes(Year,Total_Emissions)) + geom_line(aes(color=Type), size=2)
print(g)
dev.copy(png, "plot3.png", width=600, height=600, units="px")
dev.off()

## Another way of looking at this is to use faceting, as below.
# g<-ggplot(plot1DF, aes(Year,Total_Emissions)) + geom_line(colour="lightgreen",size=2) + facet_grid(.~Type)
# print(g)
# dev.copy(png, "plot3.png", width=480, height=480, units="px")
# dev.off()





