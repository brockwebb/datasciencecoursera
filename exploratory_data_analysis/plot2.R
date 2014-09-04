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

## Plot... type = line. x=time, y=power
plot(psub$day_minute, psub$Global_active_power, type="l", 
     xlab="", ylab="Global Active Power (kilowatts)")

## Save to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
