###2021.8.13###
setwd("~/Desktop")
library(readxl)
data1 = read_excel('behaviour_data.xlsx',sheet = 3,col_names = TRUE);
x <- c(1:14)
y <- t(data1[,2:15])
meany <- apply(y,1,mean)
matplot(x, y, type="l", lty=1, xlab="Blocks",
        ylab=expression(paste("Number of chunks/block")),
        xaxt="n")
axis(side=1,at=x)
matpoints(x,y,type="p",pch=1)
title(main="Finger Tapping Task performance")
lines(x,meany,type="l",lwd=3)
###########
data2 = read_excel('behaviour_data.xlsx',sheet = 3,col_names = TRUE);
x <- c(1:14)
y <- t(data2[,2:15])
meany <- apply(y,1,mean)
matplot(x, y, type="l", lty=1, xlab="Blocks",
        ylab=expression(paste("Accurancy")),
        xaxt="n")
axis(side=1,at=x)
matpoints(x,y,type="p",pch=1)
title(main="Finger Tapping Task performance")
lines(x,meany,type="l",lwd=3)
##########
data3 = read_excel('time_course2.xlsx',sheet = 7,col_names = TRUE);
x <- c(1:14)
y <- t(data3[,2:15])
meany <- apply(y,1,mean)
matplot(x, y, type="l", lty=1, xlab="Blocks",
        ylab=expression(paste("MD value")),
        xaxt="n")
axis(side=1,at=x)
matpoints(x,y,type="p",pch=1)
title(main="Cere_VI's MD value v.s. Blocks")
lines(x,meany,type="l",lwd=3)