## Read the data
p <- read.table("./household_power_consumption.txt", header=TRUE, sep=';', na.strings="?")
                  
p$Date <- as.Date(p$Date, format="%d/%m/%Y")

## Subsetting the data
psub <- subset(p, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Plot...
hist(psub$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", 
   ylab="Frequency", col="Red")

## Save to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()

