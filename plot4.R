
# Get the columns names
tmp         <- read.csv("household_power_consumption.txt", sep = ";",nrows = 1, header = TRUE)
col_names   <- colnames(as.data.frame(tmp))

# Read the dataset for days 01/02/2007 and 02/02/2007
h_p_c       <- read.csv("household_power_consumption.txt", 
                        sep = ";",
                        dec = ".",
                        na.strings = "?",
                        skip   = 66637,
                        nrows  = 2880,
                        header = FALSE
                        )
colnames(h_p_c) <- col_names

# Convert Date and Time to proper POSIXlt & POSIXt format
h_p_c$Date_Time <- strptime(paste(as.character(h_p_c$Date), 
                                  as.character(h_p_c$Time)),
                                  "%d/%m/%Y %H:%M:%S", 
                                  tz = "")

# Switch "LC_TIME" system parameter to USA to get the weekday names right
Sys.setlocale("LC_TIME", "USA")

# Open the pnj file device & create the plot with lines
png(file = "plot4.png", width = 480, height = 480, bg = "transparent")

par(mfrow = c(2,2))

with(h_p_c, {
      plot(Date_Time, Global_active_power, 
           type = "l",
           xlab = "",
           ylab = "Gobal Active Power"
          )
      plot(Date_Time, Voltage, 
           type = "l",
           xlab = "datetime",
           ylab = "Voltage"
          )
      plot(Date_Time, Sub_metering_1,
           type = "n",
           xlab = "",
           ylab = "Energy sub metering"
           )
      points(Date_Time , Sub_metering_1, col = "black", type = "l")
      points(Date_Time , Sub_metering_2, col = "red"  , type = "l")
      points(Date_Time , Sub_metering_3, col = "blue" , type = "l")
      legend("topright", lty =1, col = c("black", "red", "blue"),
             bty = "n",
             seg.len = 1,
             legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
      plot(Date_Time, Global_reactive_power, 
           type = "l",
           xlab = "datetime",
           ylab = "Global_reactive_power"
      )
      })

dev.off()

