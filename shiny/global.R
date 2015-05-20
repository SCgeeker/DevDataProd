
wd.init = getwd()
setwd(wd.init)

CoffData <- read.csv("CoffData.csv", header = TRUE)[,-c(1,3)]
names(CoffData) <- c("region","Year","Unit","Value","variable","Category")
CoffData$Year <- as.factor(CoffData$Year)
CoffData$Value <- as.numeric(CoffData$Value)
