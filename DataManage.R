## This script demonstrates how we get the raw data for this project.

## 1. Retrive dataset from opendataforafrica.org
library(jsonlite)
sourceurl <- "http://opendataforafrica.org/api/1.0/data/CBIMISUCBAPHLE2012?Time=1951,1952,1953,1954,1955,1956,1957,1958,1959,1960,1961,1962,1963,1964,1965,1966,1967,1968,1969,1970,1971,1972,1973,1974,1975,1976,1977,1978,1979,1980,1981,1982,1983,1984,1985,1986,1987,1988,1989,1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013&region=1000000,1000010,1000020,1000030,1000040,1000050,1000060,1000070,1000080,1000090,1000100,1000110,1000120,1000130,1000140,1000150,1000160,1000170,1000180,1000190,1000200,1000210,1000220,1000230&variable=1000020,1000030,1000040,1000050,1000060,1000070,1000080,1000090,1000100,1000110,1000120,1000130,1000140,1000150,1000160,1000170,1000180,1000190,1000200,1000210,1000220,1000230,1000240,1000250,1000260,1000270,1000280,1000290,1000300,1000310,1000320,1000330,1000340,1000360,1000370,1000380,1000400,1000410,1000420,1000440,1000450,1000460,1000480,1000490,1000520,1000530,1000540,1000550,1000560,1000570,1000580,1000590,1000640,1000650,1000660,1000670,1000680,1000690,1000700,1000710,1000730,1000740,1000750,1000760,1000770,1000780,1000790,1000800,1000810,1000820,1000830,1000840,1000850,1000860,1000870,1000880,1000600,1000610,1000620,1000900,1000910,1000920,1000930,1000940,1000950,1000960,1000970,1001030,1001040&Frequencies=A"
jsonAll <- stream_in(url(sourceurl))
OBS <- jsonAll$data[[1]][,c(2:3,5:8)]
OBS <- OBS[!is.na(OBS$Value),]
OBS$Time <- gsub("-01-01T00:00:00Z", "", OBS$Time)
rm(sourceurl, jsonAll)

## 2. Truncate the observations marked "Arabica" and "Robusta" in variable column
OBSArab <- OBS[grep("Arabica", OBS$variable),]
OBSArab$variable <- gsub(", Arabica", "", OBSArab$variable)
OBSArab <- data.frame(OBSArab, Category = rep("Arabica", dim(OBSArab)[1]))
OBSRobu <- OBS[grep("Robusta", OBS$variable),]
OBSRobu$variable <- gsub(", Robusta", "", OBSRobu$variable)
OBSRobu <- data.frame(OBSRobu, Category = rep("Robusta", dim(OBSRobu)[1]))
CoffData <- rbind(OBSArab, OBSRobu)
rm(OBSArab, OBSRobu)

CoffData$region <- factor(CoffData$region)
CoffData$variable <- factor(CoffData$variable)
CoffData$Unit <- factor(CoffData$Unit)

write.csv(CoffData, file = "CoffData.csv")

## 3. Set up the index of data set
ReginIDS <- levels(as.factor(CoffData$RegionId))
ReginNAMES <- levels(as.factor(CoffData$region))
PriRegions <- levels(as.factor(CoffData$region))[c(7,8,17)]
SubRegions <- levels(as.factor(CoffData$region))[-c(6,7,8,12,13,17,18)]
variableNAMES <- levels(as.factor(CoffData$variable))
##  variable 1, 13, 14 are the critical dependent variables
##  "Bearing Area (ha.)" , Production of Coffee" , "Productivity (kg/ha)"


## 4. Draw the overall production since records began
# require('rCharts')
# CoffIndia <- CoffData[ (CoffData$variable == variableNAMES[13]) & (CoffData$region == "India"), ]
# CoffIndia1 <- data.frame(Year = levels(as.factor(CoffIndia$Time)), Arabica = levels(as.factor(CoffIndia$Value[CoffIndia$Category == "Arabica"])), Robusta = levels(as.factor(CoffIndia$Value[CoffIndia$Category == "Robusta"])) )
# Coff1 <- mPlot(x = "Year", y = c("Arabica", "Robusta"), type = "Line", data = CoffIndia1)
# Coff1$set(pointSize = 0, lineWidth = 1)
# Coff1$save("Coff1.html")

## 5. Draw the least productions of the provinces 
# CoffProv <- CoffData[ (CoffData$variable == variableNAMES[13]) & 
#                           (CoffData$region == PriRegions[1] | 
#                            CoffData$region == PriRegions[2] |
#                            CoffData$region == PriRegions[3]), ]
# CoffProv$region_year <- paste0(CoffProv$region,"(",CoffProv$Time,")")
# Coff2 <- nPlot(Value ~ region_year, group = "Category", data = CoffProv, type = "multiBarChart")
# Coff2$save("Coff2.html")