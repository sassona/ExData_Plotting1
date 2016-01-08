# Get column names because I'm too lazy to type them

colNames <- names(read.table("household_power_consumption.txt", 
                             nrow=1, header=TRUE, sep=";"))


#get desired data
household <- read.table("household_power_consumption.txt",
                        na.strings = "?",
                        sep = ";",
                        header = FALSE,
                        col.names = colNames,
                        skip = grep("^[1,2]/2/2007", readLines("household_power_consumption.txt"))-1,
                        nrow = 2879
)

#generate column with DateTime field
x <- paste(household$Date,household$Time)
DateTime<-strptime(x, "%d/%m/%Y %H:%M:%S")
household_fixed<-cbind(DateTime,household)           

#plot generation
png("plot1.png",width = 480, height = 480)
hist(household_fixed$Global_active_power,xlab = "Global Active Power (kilowatts)",main="Global Active Power",col="red")
dev.off()

