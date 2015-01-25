### Plot 6

## Load Dplyr 
library(dplyr)
library(ggplot2)

## Read and Groupby data for the Plot1
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI<-tbl_df(NEI)
SCCDF<-tbl_df(SCC)

##=== Remove unwanted columns from the Source Dataset
SCCDF<-select(SCCDF, -(11:15))
SCCDF<-select(SCCDF, -(5:6))

## Group Data by Year & SCC to Summarise
plotDF<- NEI %>% filter(fips=="24510" | fips=="06037") %>%
    group_by(year, SCC, fips) %>% summarise(sum(Emissions))

## update column names
colnames(plotDF)=c("CalYear", "SCC", "Fips", "Total_Emissions")

##=== Mutate to create new columns SCC.Levels to search within
SCCDF<-mutate(SCCDF, SCC, Data.Category, SCC.Levels = paste(Short.Name, EI.Sector, SCC.Level.One, SCC.Level.Two, SCC.Level.Three, SCC.Level.Four))

## Join the plotDF and SCCDF on SCC to create a single dataset.
allData<-inner_join(plotDF, SCCDF, by=c("SCC"="SCC"))

## Search for rows containing Motor Vehicles related sources
plotData<-allData[grep("Vehicles", allData$SCC.Levels),]

## Group the above restultant data by CalYear and Total_Emissions
plotData<- plotData %>% 
    group_by(CalYear, Fips) %>% summarise(sum(Total_Emissions))

## Rename column names
colnames(plotData)=c("CalYear", "Fips" ,"Total_Emissions")



## Using ggplot and line color to identify sources with decreased emissions by Type.
g<-ggplot(plotData, aes(CalYear,Total_Emissions)) + 
    geom_line(aes(color=Fips), size=2) +
    labs(title="Total PM2.5 Emissions from Motor Vehicles \n in Baltimore City and Los Angeles County") +
    theme(plot.title=element_text(color="brown", size=16, face="bold"), legend.title=element_text(color="Navy", size=12, face="bold"), axis.title=element_text(color="black", size=14, face="bold"))

##
## g<-ggplot(plotData, aes(CalYear,Total_Emissions)) + geom_line(colour="lightgreen",size=2) + facet_grid(.~Fips) +
##    labs(title="Total PM2.5 Emissions from Motor Vehicles \n in Los Angeles County and Baltimore City") +
##    theme(plot.title=element_text(color="brown", size=16, face="bold"), legend.title=element_text(color="Navy", size=12, face="bold"), axis.title=element_text(color="black", size=14, face="bold")) + 

# Print the Plot to Screen
print(g)

##=== Copy Plot to PNG
dev.copy(png, "plot6.png", width=600, height=600, units="px")
dev.off()

