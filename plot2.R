
library("ggplot2")
if(!file.exists("exdata-data-household_power_consumption.zip")) {
         temp <- tempfile()
         download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
         file <- unzip(temp)
         unlink(temp)
 }
## Getting full dataset 
datafull <- read.csv("./Data/household_power_consumption.txt", header=T, sep=';', na.strings="?",  
                        check.names=F, stringsAsFactors=F, comment.char="", quote='\"') 
datafull$Date <- as.Date(datafull$Date, format = "%d/%m/%Y")
data <- subset(datafull,subset=(Date>= "2007-02-01" & Date <= "2007-02-02"))
rm(datafull)

## Converting dates 
datetime <- paste(as.Date(data$Date),data$Time)
data$Datetime <- as.POSIXct(datetime)

## Plot 2 
plot(data$Global_active_power~data$DateTime,type="l", ylab="Global Active Power(kilowatts)", xlab="")


## Plot 2 
plot(data$Global_active_power~data$Datetime, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="") 
dev.copy(png, file="plot2.png", height=480, width=480) 
dev.off() 
