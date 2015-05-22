#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission 
#from all sources for each of the years 1999, 2002, 2005, and 2008.

#Read raw data in
NEI <- readRDS("./ExDataProject2/Raw/summarySCC_PM25.rds")
SCC <- readRDS("./ExDataProject2/Raw/Source_Classification_Code.rds")

#Sum up the emission by year
total <- tapply(NEI$Emissions, NEI$year, sum, na.rm = TRUE)
years = as.numeric(names(total))

#plotting the sum up data
png("./ExDataProject2/plot1.png")
plot(years, total,
     xlab='Year', ylab='PM2.5 emissions (tons)', 
     main='Total Emissions by Year',
     pch = 19)
lines(years, total)
dev.off()