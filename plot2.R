#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

#Read raw data in
NEI <- readRDS("./ExDataProject2/Raw/summarySCC_PM25.rds")
SCC <- readRDS("./ExDataProject2/Raw/Source_Classification_Code.rds")

#Sum up the emission in Baltimore by year
baltimore<- NEI[NEI$fips == "24510",]
total <- tapply(baltimore$Emissions, baltimore$year, sum, na.rm = TRUE)
years = as.numeric(names(total))

#plotting the sum up data
png("./ExDataProject2/plot2.png")
plot(years, total,
     xlab='Year', ylab='PM2.5 emissions (tons)', 
     main='Total Emissions in Baltimore by Year',
     pch = 19)
lines(years, total)
dev.off()