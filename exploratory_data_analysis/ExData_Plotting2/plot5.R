## Across the United States, how have emissions from coal combustion-related 
## sources changed from 1999–2008?

library(plyr)

#Loading the data
# These take awhile to load, if I've already done that in my R environment,
# check to see, it is a convenient time saver if you are itterating on exploring the data 
if (!exists('NEI')) { 
       NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
}

if (!exists('SCC')){
       SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")  
}

# Merge the SCC data with the NEI data, this will add the description (which will 
# include "coal") this step can take a really (I mean *really*) long time 
# on my old 2008 powerbook...
if (!exists('sccnei')) {
       sccnei <- merge(NEI,SCC,by='SCC')
}

# Retrieve just the vehicle related data from the merged table
# I had to look at the data to find that the SCC.Level.Two field contained a reliable
# "vehicle" to search for...
sccnei.vehicle = sccnei[grepl("vehicle", sccnei$SCC.Level.Two,ignore.case=TRUE),]

# Now subset the data for Baltimore City
sccnei.vehicle.BaltimoreCityMD <- subset(sccnei.vehicle, fips==24510)

# This takes us back to plot1.R, where I can just use the plot() function to 
# display the data, but just use "sccnei.vehicle" instead...

# Summarize the data into a neat table, there are probably lots of ways
# to do this, ddply as discussed in the lectures has a lot of power
summary_data <- ddply(sccnei.vehicle.BaltimoreCityMD, 'year', summarize, tot=sum(Emissions))

# The basic plot with labels. For bonus points, I added a linear with a linear regression.
# I found this page helpful: http://stackoverflow.com/questions/15102254/how-do-i-add-different-trend-lines-in-r
png('plot5.png', width=480, height=480)
plot(summary_data, 
     xlab='Year', 
     ylab='PM-2.5 Emissions (tons)', 
     main='Baltamore City PM-2.5 Emissions from Motor Vehicles',
     type='l',
     col=1,
     lwd=2
)

# linear regression
regressionline <- lm(summary_data$tot~summary_data$year)
abline(regressionline, col="red",lwd=2)

# Adding a legend
legend("topright",
       legend=c("Emissions","Trendline"),
       col=c("black","red"),
       lwd=2,
)
dev.off()