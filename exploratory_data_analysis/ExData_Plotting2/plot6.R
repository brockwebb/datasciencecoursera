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

# Now subset the data for Baltimore City and LA
# Because of the leading zero, fips is text... so quotes were necessary...
sccnei.vehicle.BaltimoreCity.LA <- subset(sccnei.vehicle, fips=="24510" | fips=="06037")

# Just a quick value change for graphing and names
sccnei.vehicle.BaltimoreCity.LA$fips[sccnei.vehicle.BaltimoreCity.LA$fips=="06037"] <- "Los Angeles CA"
sccnei.vehicle.BaltimoreCity.LA$fips[sccnei.vehicle.BaltimoreCity.LA$fips=="24510"] <- "Baltimore MD"

# Column name change (thanks, http://stackoverflow.com/questions/7531868/how-to-rename-a-single-column-in-a-data-frame-in-r)
names(sccnei.vehicle.BaltimoreCity.LA)[names(sccnei.vehicle.BaltimoreCity.LA) == 'fips'] <- 'City'


# This takes us back to plot1.R, where I can just use the plot() function to 
# display the data, but just use "sccnei.vehicle" instead...

# Summarize the data into a neat table, there are probably lots of ways
# to do this, ddply as discussed in the lectures has a lot of power.
# This essentially follows plot3.R from here... (but on City, not type)
summary_data <- ddply(sccnei.vehicle.BaltimoreCity.LA, .(year, City), summarize, tot=sum(Emissions))

png('plot6.png', width=480, height=480)

plot6 <- ggplot(summary_data, aes(x=year, y=tot, color=City)) + 
       facet_grid(. ~ City) + 
       geom_point() + 
       geom_smooth(method="lm") +
       xlab('Year') + 
       ylab('PM2.5 Emissions (tons)') +
       ggtitle("Baltamore MD vs Los Angeles CA; Vehicle PM-2.5 Emissions") +
       theme(legend.position = 'bottom')

print(plot6)

dev.off()
