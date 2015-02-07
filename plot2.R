# Exploratory Data Analysis
# Course Project 1
# Plot 2
# dataset url: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
filename <- "household_power_consumption.zip"
if(!file.exists(filename))
{
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile=filename, method="curl")
}
if(!file.exists("./data/household_power_consumption.txt"))
{
  unzip(filename,exdir="./data")
}

#Data for 2/1/07 starts on row 66638
#Data for 2/2/07 ends on row 69517
varnames <- read.csv("./data/household_power_consumption.txt",header=TRUE,sep=";",
                     nrows=1,stringsAsFactors=FALSE)
data <- read.csv("./data/household_power_consumption.txt",header=FALSE,sep=";",
                 na.strings="?",stringsAsFactors=FALSE,skip=66638-1,nrows=(69517-66638+1))
varnames <- colnames(varnames)
setnames(data,varnames)

#Construct a DateTime column and append it to data so we can plot chronologically
DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data <- cbind(data,DateTime)

width <- 480
height <- 480

GAP <- data$Global_active_power
ylabel <- "Global Active Power (kilowatts)"
png(file = "plot2.png")
plot(data$DateTime,data$Global_active_power, xlab = "", ylab = ylabel, type = "l")
dev.off()