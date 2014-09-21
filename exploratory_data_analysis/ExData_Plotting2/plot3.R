## Plot3.R seeks to answer the question: "Of the four types of sources indicated 
## by the type (point, nonpoint, onroad, nonroad) variable, which of these four 
## sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008? 
## Use the ggplot2 plotting system to make a plot answer this question."

# Note: This builds on plot2.R, now extending the look into the various types
# of emmision sources (point, nonpoint, onroad, nonroad)

library(plyr)
library(ggplot2)

#Loading the data
# These take awhile to load, if I've already done that in my R environment,
# check to see, it is a convenient time saver if you are itterating on exploring the data 
if (!exists('NEI')) { 
       NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
}

if (!exists('SCC')){
       SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")  
}

# Subset the data
BaltimoreCityMD <- subset(NEI, fips==24510)


# Summarize the data into a neat table, there are probably lots of ways
# to do this, ddply as discussed in the lectures has a lot of power
summary_data <- ddply(BaltimoreCityMD, .(year, type), summarize, tot=sum(Emissions))

# I watched the week 2 lectures on ggplot many times, it was helpful. 
# The trendline is important as only the "point" type actually 
# increases, this not visually obvious for "point" so a trendline works...
png('plot3.png', width=480, height=480)

plot3 <- ggplot(summary_data, aes(x=year, y=tot, col=type)) + 
       facet_grid(. ~ type) + 
       geom_point() + 
       geom_smooth(method="lm") +
       xlab('Year') + 
       ylab('PM2.5 Emissions (tons)') +
       ylim(0,2250) +
       ggtitle("Emissions by Type in Baltimore City, MD")
       
       # Using the trendline forced me to set the ylim to avoid
       # the scale showing negative values due to error bars around the 
       # linear trend line.

print(plot3)

dev.off()