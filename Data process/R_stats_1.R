##session1

library(ggplot2)
library(Rmisc)

mat<-matrix(c(50,64,64,74,81,74,71,79,84,89,90,82,101,108,109,108,108,107,
            114,109,99,109,114,126,116,123,125,131,137,136,132,101,164,2,
            3,4,5,6,7,8,9,10,11,12,2,3,4,5,6,7,8,9,10,11,12,
            2,3,4,5,6,7,8,9,10,11,12),nrow = 33,ncol = 2)
colnames(mat)<-c("no_of_chunks","block")
data <- data.frame(mat)

data <- data.frame(
  block = factor(c("B02","B03","B04","B05","B06","B07","B08","B09","B10","B11","B12","B13","B14",
                   "B02","B03","B04","B05","B06","B07","B08","B09","B10","B11","B12","B13","B14",
                   "B02","B03","B04","B05","B06","B07","B08","B09","B10","B11","B12","B13","B14")),
  no_of_chunks = c(50,64,64,74,81,74,71,79,84,89,90,90,92,82,101,108,109,108,108,107,
                 114,109,99,109,117,120,114,126,116,123,125,131,137,136,132,101,164,164,164))

matc <- summarySE(data,measurevar="no_of_chunks",groupvars = c("block"))

p<- ggplot(data=matc, aes(x=block, y=no_of_chunks, group=1)) +
       geom_errorbar(aes(ymin=no_of_chunks-se, ymax=no_of_chunks+se),width=.2) +
       geom_line() +
       geom_point() +
       xlab("Block") + ylab("Number of chunks/block") +
       ggtitle("FFT performance")

##session2

data2 <- data.frame(
  block = factor(c("B13","B14",
                   "B13","B14",
                   "B13","B14")),
  no_of_chunks = c(90,92,117,120,164,164))

matc2 <- summarySE(data2,measurevar="no_of_chunks",groupvars = c("block"))

p<- p+ggplot(data=matc2, aes(x=block, y=no_of_chunks, group=1)) +
  geom_errorbar(aes(ymin=no_of_chunks-se, ymax=no_of_chunks+se),width=.2) +
  geom_line() +
  geom_point() +
  xlab("Block") + ylab("Number of chunks/block") +
  ggtitle("FFT performance")

