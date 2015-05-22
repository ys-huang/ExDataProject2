#How have emissions from motor vehicle sources changed 
#from 1999¡V2008 in Baltimore City?

#Read raw data in
NEI <- readRDS("./ExDataProject2/Raw/summarySCC_PM25.rds")
SCC <- readRDS("./ExDataProject2/Raw/Source_Classification_Code.rds")

#Sum up the emission in Baltimore by year
baltimore<- NEI[NEI$fips == "24510",]

#find out the SCC relating to vehicle
vehicle.scc <- SCC$SCC[ grepl("vehicle", SCC$Short.Name, ignore.case=TRUE) |
                             grepl("motor | vehicle", SCC$EI.Sector, ignore.case=TRUE) |
                             grepl("motor | vehicle", SCC$SCC.Level.One, ignore.case=TRUE) |
                             grepl("motor | vehicle", SCC$SCC.Level.Two, ignore.case=TRUE) |
                             grepl("motor | vehicle", SCC$SCC.Level.Three, ignore.case=TRUE) |
                             grepl("motor | vehicle", SCC$SCC.Level.Four, ignore.case=TRUE) ]

# select data according coal related SCC
vehicle <- subset(baltimore, baltimore$SCC %in% vehicle.scc)
total <- tapply(vehicle$Emissions, vehicle$year, sum, na.rm = TRUE)
years = as.numeric(names(total))


#plotting the sum up data

png("./ExDataProject2/plot5.png")
plot(years, total, xlab='Year', ylab='PM2.5 emissions (tons)',
     main='Motor vehicle emissions in Baltimore', pch=19)
lines(years, total)

dev.off()