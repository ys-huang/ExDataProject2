#Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?


#Read raw data in
NEI <- readRDS("./ExDataProject2/Raw/summarySCC_PM25.rds")
SCC <- readRDS("./ExDataProject2/Raw/Source_Classification_Code.rds")

#Sum up the emission in Baltimore by year
baltimore<- NEI[NEI$fips == "24510",]
LA <- NEI[NEI$fips == "06037",]
#find out the SCC relating to vehicle
vehicle.scc <- SCC$SCC[ grepl("vehicle", SCC$Short.Name, ignore.case=TRUE) |
                                grepl("motor | vehicle", SCC$EI.Sector, ignore.case=TRUE) |
                                grepl("motor | vehicle", SCC$SCC.Level.One, ignore.case=TRUE) |
                                grepl("motor | vehicle", SCC$SCC.Level.Two, ignore.case=TRUE) |
                                grepl("motor | vehicle", SCC$SCC.Level.Three, ignore.case=TRUE) |
                                grepl("motor | vehicle", SCC$SCC.Level.Four, ignore.case=TRUE) ]



# select data according coal related SCC
vehicle.bal <- subset(baltimore, baltimore$SCC %in% vehicle.scc)
total.bal <- tapply(vehicle.bal$Emissions, vehicle.bal$year, sum, na.rm = TRUE)
vehicle.LA <- subset(LA, LA$SCC %in% vehicle.scc)
total.LA <- tapply(vehicle.LA$Emissions, vehicle.LA$year, sum, na.rm = TRUE)

#combine data together and transfer to long data form
data <- cbind(total.bal, total.LA)
data<- cbind(as.numeric(rownames(data)), data)
colnames(data) <- c("year", "Baltimore","Los Angels" )
rownames(data) <- c()
data <- as.data.frame(data)
library(reshape2)
data.long <- melt(data, id= "year", value.name = "emission", variable.name = "city")


#plotting the sum up data
library(ggplot2)
png("./ExDataProject2/plot6.png")
ggplot(data.long, aes(year, emission)) + 
        geom_line(aes(color=factor(city))) +
        geom_point(aes(color=factor(city)),size = 3)+
        xlab('Year') + ylab('PM2.5 Emissions (tons)') + 
        ggtitle('Motor Vehicle Emissions: Baltimore v.s. Los Angeles') 
dev.off()