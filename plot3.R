#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999¡V2008 for Baltimore City? 
#Which have seen increases in emissions from 1999¡V2008? 
#Use the ggplot2 plotting system to make a plot answer this question.

#Read raw data in
NEI <- readRDS("./ExDataProject2/Raw/summarySCC_PM25.rds")
SCC <- readRDS("./ExDataProject2/Raw/Source_Classification_Code.rds")

#Sum up the emission in Baltimore by year
library(reshape2)
baltimore<- NEI[NEI$fips == "24510",]
total <- dcast(baltimore,  year ~ type, sum, value.var='Emissions')
total.long <- melt(total, id = "year", value.name = "emissions", variable.name = "type")


#plotting the sum up data

library(ggplot2)
png("./ExDataProject2/plot3.png")
ggplot(total.long, aes(year, emissions)) + 
        geom_line(aes(color=type)) +
        geom_point(aes(color=type),size = 3) +
        xlab('Year') + ylab('Emissions (tons)') + 
        ggtitle('Emissions in Baltimore by Type')
dev.off()
