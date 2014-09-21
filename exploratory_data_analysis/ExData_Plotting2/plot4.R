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

# It might have been more efficient to first create a data set that used only
# the "coal" description from the SCC table. 
# i.e. SCC.coal = SCC[grepl("coal", SCC$Short.Name,ignore.case=T]
# however, my approach would then allow subsetting of the data to any type
# without having to redo that  long and expensive merge I just did which would have taken 
# just as long and returned less data. I hope I have enough memory to do this all ;)

# Retrieve just the coal related data from the merged table
sccnei.coal = sccnei[grepl("coal", sccnei$Short.Name,ignore.case=TRUE),]

# This takes us back to plot1.R, where I can just use the plot() function to 
# display the data, but just use "sccnei.coal" instead...

# Summarize the data into a neat table, there are probably lots of ways
# to do this, ddply as discussed in the lectures has a lot of power
summary_data <- ddply(sccnei.coal, 'year', summarize, tot=sum(Emissions))

# The basic plot with labels. For bonus points, I added a linear with a linear regression.
# I found this page helpful: http://stackoverflow.com/questions/15102254/how-do-i-add-different-trend-lines-in-r
png('plot4.png', width=480, height=480)
plot(summary_data, 
     xlab='Year', 
     ylab='PM-2.5 Emissions (tons)', 
     main='US PM-2.5 Emissions from Coal',
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