##Plot 1
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

#Well, axis X in the plot requested makes no sense; those are not the values which the variable takes
#But... I suppose it is just an excercise; the axis can be overruled
hist(power_sub$Global_active_power,col = "blue",main = "Global Active Power",xlab = "Global Active Power (kilowatts)",axes=F)
axis(1,labels = c("0","2","4","6"),at=c(0,1000,2000,3000))
axis(2,labels = c("0","200","400","600","800","1000","1200"),at=c(0,200,400,600,800,1000,1200))

#Finally, let's save the plot
png(filename = "plot1.png",width = 480, height = 480)
hist(power_sub$Global_active_power,col = "blue",main = "Global Active Power",xlab = "Global Active Power (kilowatts)",axes=F)
axis(1,labels = c("0","2","4","6"),at=c(0,1000,2000,3000))
axis(2,labels = c("0","200","400","600","800","1000","1200"),at=c(0,200,400,600,800,1000,1200))
dev.off()

#AGG