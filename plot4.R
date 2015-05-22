#Across the United States, how have emissions from 
#coal combustion-related sources changed from 1999¡V2008?

#Read raw data in
NEI <- readRDS("./ExDataProject2/Raw/summarySCC_PM25.rds")
SCC <- readRDS("./ExDataProject2/Raw/Source_Classification_Code.rds")

#find out the SCC relating to coal
coal.scc <- SCC$SCC[ grepl("coal", SCC$Short.Name, ignore.case=TRUE) |
                 grepl("coal", SCC$EI.Sector, ignore.case=TRUE) |
                 grepl("coal", SCC$SCC.Level.One, ignore.case=TRUE) |
                 grepl("coal", SCC$SCC.Level.Two, ignore.case=TRUE) |
                 grepl("coal", SCC$SCC.Level.Three, ignore.case=TRUE) |
                 grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) ]

# select data according coal related SCC
coal <- subset(NEI, NEI$SCC %in% coal.scc)
total <- tapply(coal$Emissions, coal$year, sum, na.rm = TRUE)
years = as.numeric(names(total))


#plotting the sum up data

png("./ExDataProject2/plot4.png")
plot(years, total, xlab='Year', ylab='PM2.5 emissions (tons)',
     main='Coal combustion-related emissions', pch=19)
lines(years, total)

dev.off()