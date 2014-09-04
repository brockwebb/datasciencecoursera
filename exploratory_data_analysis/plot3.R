## Read the data
p <- read.table("./household_power_consumption.txt", header=TRUE, sep=';', na.strings="?")

## making sure date is understood as a date...
p$Date <- as.Date(p$Date, format="%d/%m/%Y") 

## Subsetting the data
psub <- subset(p, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))


## Combine date/time to plot each minute for each day
## then add the vector as a column to the subset
day_minute <- paste(as.Date(psub$Date), psub$Time)
psub$day_minute <- as.POSIXct(day_minute)

## Create a base plot with annotation (lecture: base plotting system part 2)
## type=n creates and empty graph, then we add data to it, then include a legend 
with(psub, plot(day_minute,Sub_metering_1, type="n", ylab="Energy sub metering", xlab=""))

with(psub, points(day_minute,Sub_metering_1, type="l", col="black"))
with(psub, points(day_minute,Sub_metering_2, type="l", col="red"))
with(psub, points(day_minute,Sub_metering_3, type="l", col="blue"))

## Legend uses "line type" or lty to specify the symbol, instead of pch for scatterplots
## cex will resize the legend so it fits better. I had to add blank characters to the  
## legend string to shift the text over so it didn't get cut off in the 480x480 pcx save
legend("topright", lty=1, col=c("black","red","blue"), cex=.75, legend=c("Sub_metering_1          ",
       "Sub_metering_2          ","Sub_metering_3          "))

## Save to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
