# Exploratory Data Analysis
# Course Project 1
# Plot 3
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

#Plot lines for Sub_metering_1, Sub_metering_2, Sub_metering_3
ylabel <- "Energy sub metering"
png(file = "plot3.png")
plot(data$DateTime,data$Sub_metering_1, xlab = "", ylab = ylabel, type = "l")
points(data$DateTime,data$Sub_metering_2, xlab = "", ylab = ylabel, type = "l", col = "red")
points(data$DateTime,data$Sub_metering_3, xlab = "", ylab = ylabel, type = "l", col = "blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"), cex = 0.75, xjust = 1, lty = 1)
dev.off()