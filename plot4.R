
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

datetime <- paste(as.Date(data$Date),data$Time)
data$Datetime <- as.POSIXct(datetime)
## plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0)) 
 with(data, { 
     plot(Global_active_power~Datetime, type="l",  
          ylab="Global Active Power (kilowatts)", xlab="") 
     plot(Voltage~Datetime, type="l",  
          ylab="Voltage (volt)", xlab="") 
     plot(Sub_metering_1~Datetime, type="l",  
          ylab="Global Active Power (kilowatts)", xlab="") 
     lines(Sub_metering_2~Datetime,col='Red') 
     lines(Sub_metering_3~Datetime,col='Blue') 
     legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", 
            legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 
     plot(Global_reactive_power~Datetime, type="l",  
          ylab="Global Rective Power (kilowatts)",xlab="") 
 }) 

dev.copy(png, file="plot4.png", height=480, width=480) 
dev.off() 
