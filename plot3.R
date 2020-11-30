# load data
data <- read.table("household_power_consumption.txt", 
                   header=TRUE, sep=";", na.strings = "?", 
                   colClasses = c('character',
                                  'character',
                                  'numeric',
                                  'numeric',
                                  'numeric',
                                  'numeric',
                                  'numeric',
                                  'numeric',
                                  'numeric'))


# format dates
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$DateTime <- strptime(paste(data$Date,data$Time),format = "%Y-%m-%d %H:%M:%S")

# filter data from the dates 2007-02-01 and 2007-02-02
sub_data <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# Combine date and time
datetime <- paste(sub_data$Date, sub_data$Time)
datetime <- setNames(datetime, "datetime")
sub_data <- cbind(datetime, sub_data)
sub_data$datetime <- as.POSIXct(datetime)

# plot
with(sub_data, plot(Sub_metering_1~datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab=""))
with(sub_data,lines(Sub_metering_2~datetime,col='Red'))
with(sub_data,lines(Sub_metering_3~datetime,col='Blue'))

legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# save
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()
