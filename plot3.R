##Plot 3
#Let's load the original file
power=read.csv2("household_power_consumption.txt")

#We merge data & time columns, in this way 
power <- within(power,  dt <- paste(Date,Time,sep=" "))

#The resulting string converted to object class "POSIXlt"
power$dt=strptime(power$dt,format = "%d/%m/%Y %H:%M:%S")
power$day<-weekdays(power$dt)

#Now we take the subset containing only data for February 1st & 2nd - 2007
prueba=subset(power,Date=="1/2/2007")
prueba2=subset(power,Date=="2/2/2007")
power_sub=rbind(prueba,prueba2)

#I noticed that R is considering the "sub-metering" variables as factors
#I hacked the problem by changing the variable types directly on Excel
write.csv(power_sub,"prueba.csv")
#And then I reloaded the file
test=read.csv("prueba.csv")

#A drawback is the passing through Excel format messed the dates :/
#So I re-processed the date & time variables
test <- within(test,  dt <- paste(Date,Time,sep=" "))
test$dt=strptime(test$dt,format = "%d/%m/%Y %H:%M:%S")
#I use a different name just in case; I only write on the database I am using when I am sure about
#the outcome
#Now that I have numeric variables and dates in the proper format, I compound the whole
#plot
power_sub=test
png(filename = "plot3.png",width = 480, height = 480)
with(power_sub,plot(dt,Sub_metering_1,type = "n",ylab = "Energy sub metering"))
with(power_sub,lines(dt,Sub_metering_1,col="black"))
with(power_sub,lines(dt,Sub_metering_2,col="red"))
with(power_sub,lines(dt,Sub_metering_3,col="blue"))
legend("topright",lwd=1,col=c("black","red","blue"),legend = c("Sub metering 1","Sub metering 2","Sub metering 3"),cex = 0.8)
dev.off()

#AGG