
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

# Open the pnj file device & plot the histogram
png(file = "plot1.png", width = 480, height = 480, bg = "transparent")


with(h_p_c, {
     hist(Global_active_power, 
          main ="Global Active Power",
          xlab = "Gobal Active Power (kilowatts)",
          col = "red"
      )}
)

dev.off()

