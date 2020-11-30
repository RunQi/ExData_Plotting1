
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

# plot

hist(sub_data$Global_active_power,
     xlab = "Global Active Power (kilowatts)",
     col  = "red",
     main = "Global Active Power")

# save
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()