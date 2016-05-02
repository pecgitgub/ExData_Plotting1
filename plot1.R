setwd("c://ds");

library("ggplot2")
if(!file.exists("exdata-data-household_power_consumption.zip")) {
         temp <- tempfile()
         download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
         file <- unzip(temp)
         unlink(temp)
 }
 
## Getting full dataset 
 data_full <- read.csv("./Data/household_power_consumption.txt", header=T, sep=';', na.strings="?",  
                       nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"') 
 data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y") 
 
 
## Subsetting the data 
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02")) 
 rm(data_full) 
 
 
 ## Converting dates 
 datetime <- paste(as.Date(data$Date), data$Time) 
 data$Datetime <- as.POSIXct(datetime) 
 
 
 ## Plot 1 
 hist(data$Global_active_power, main="Global Active Power",  
      xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red") 
 
 
 ## Saving to file 
 dev.copy(png, file="plot1.png", height=480, width=480) 
 dev.off() 
