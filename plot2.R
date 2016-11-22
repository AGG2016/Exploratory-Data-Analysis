##Plot 2
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

#Let's make sure the variable we are interested in, is numeric
power_sub$Global_active_power=as.numeric(power_sub$Global_active_power)

#Finally, let's produce and save the plot
png(filename = "plot2.png",width = 480, height = 480)
with(power_sub,plot(dt,Global_active_power,type = "n",ylab = "Global Active Power (kilowatts)"))
with(power_sub,lines(dt,Global_active_power,ylab="Global Active Power (kilowatts)"))
dev.off()

#AGG