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


## Reference: Base plotting demonstration lecture
## First we dimension out our plot to be a 2x2 table canvas
## We can also reduce the label size for each axis label as well (cex.lab)
## Margins (oma, mar) are being messed with to format more like the example
## pin is setting a square plot area, so I can get the legend to format correctly
par(mfrow = c(2,2), cex.lab=.75, oma=c(0,0,0,0), mar=c(4,4,4,4) , pin=c(2,2))

## Next we add our plots, top left, top right, bottom left, bottom right
## First is the one from plot2.R
plot(psub$day_minute, psub$Global_active_power, type="l", 
     xlab="", ylab="Global Active Power (kilowatts)")

## voltage vs. day_minute (datetime is x-axis label)
plot(psub$day_minute, psub$Voltage, type="l", xlab="datetime", ylab="Voltage")

## Sub meter plot from plot3.R
with(psub, plot(day_minute,Sub_metering_1, type="n", ylab="Energy sub metering", xlab=""))
with(psub, points(day_minute,Sub_metering_1, type="l", col="black"))
with(psub, points(day_minute,Sub_metering_2, type="l", col="red"))
with(psub, points(day_minute,Sub_metering_3, type="l", col="blue"))

## the graph in the assignment has no box around the legend.... use bty="n" to achieve it
legend("topright",lty=1, bty="n", col=c("black","red","blue"), cex=.5, 
legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## Global_reactive_power vs. day_minute (datetime is x-axis label)
plot(psub$day_minute, psub$Global_reactive_power, type="l", xlab="datetime", 
     ylab="Global_reactive_power")


## Save to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
