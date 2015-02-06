# Exploratory Data Analysis
# Course Project 1
# Plot 1
# dataset url: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
filename <- "household_power_consumption.zip"
if(!file.exists(filename))
{
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile=filename, method="curl")
}
unzip(filename,exdir="./data")

#Data for 2/1/07 starts on row 66638
#Data for 2/2/07 ends on row 69517
varnames <- read.csv("./data/household_power_consumption.txt",header=TRUE,sep=";",nrows=1,stringsAsFactors=FALSE)
data <- read.csv("./data/household_power_consumption.txt",header=FALSE,sep=";",
                 na.strings="?",stringsAsFactors=FALSE,skip=66638-1,nrows=(69517-66638+1))
varnames <- colnames(varnames)
setnames(data,varnames)

width <- 480
height <- 480

GAP <- data$Global_active_power
xlabel <- "Global Active Power (kilowatts)"
title <- "Global Active Power"
hist(GAP, main = title, xlab = xlabel, xlim = range(0,6), col = "red")
