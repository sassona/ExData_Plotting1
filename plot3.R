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
png("plot3.png",width = 480, height = 480)
plot(household_fixed$DateTime,household_fixed$Sub_metering_1,type = "n",
        ylab ="Energy sub metering",xlab="")
lines(household_fixed$DateTime,household_fixed$Sub_metering_1)
lines(household_fixed$DateTime,household_fixed$Sub_metering_2,col="red")
lines(household_fixed$DateTime,household_fixed$Sub_metering_3,col="blue")
legend("topright",col=c("black","red","blue"),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1))
dev.off()

