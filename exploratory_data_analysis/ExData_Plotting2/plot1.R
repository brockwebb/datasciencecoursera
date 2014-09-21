## Plot1.R seeks to answer the question: "Have total emissions from PM2.5 
## decreased in the United States from 1999 to 2008? Using the base plotting system, 
## make a plot showing the total PM2.5 emission from all sources for each of the years 
## 1999, 2002, 2005, and 2008."

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

# Summarize the data into a neat table, there are probably lots of ways
# to do this, ddply as discussed in the lectures has a lot of power
summary_data <- ddply(NEI, 'year', summarize, tot=sum(Emissions))

# The basic plot with labels. For bonus points, I added a linear with a linear regression.
# I found this page helpful: http://stackoverflow.com/questions/15102254/how-do-i-add-different-trend-lines-in-r
png('plot1.png', width=480, height=480)
plot(summary_data, 
     xlab='Year', 
     ylab='PM-2.5 Emissions (tons)', 
     main='US PM-2.5 Emissions from all Sources',
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