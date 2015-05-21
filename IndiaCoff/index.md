---
title       : Explore India Coffee Production 1950 - 2013
subtitle    : Course Project for Developing Data Products
author      :
job         : 
framework   : io2012        # 
highlighter : highlight.js  # 
hitheme     : tomorrow      # 
url         : {lib: "libraries"}
widgets     : [bootstrap, interactive]            # 
ext_widgets : {rCharts: ["libraries/widgets/nvd3", "/libraries/widgets/leaflet"]}
mode        : selfcontained # 
# {rCharts: ["/librariesNew/highcharts","/librariesNew/nvd3", "/librariesNew/morris","/libraries/leaflet", "/librariesNew/rickshaw"]}
---

## Background
1. **Arabica** and **Robusta** are the two primary spices in the world wide coffee market.
2. We explore the coffee production in South India from [Open Data for Africa](http://opendataforafrica.org/). Check our R markdown you will see [the codes](index.Rmd) accessed the raw data.

3. In the report [Starbucks in India now!! Should they produce India coffee beans?](http://opendataforafrica.org/ozaowvd/starbucks-is-in-india-now-should-they-procure-indian-coffee-beans), it is showed that India has a increasing production for Robusta since 1990. The production of Arabica has changed smoothly so far.
<iframe src="http://opendataforafrica.org/resource/embed/ozaowvd/first?noHeader=1" style="height:300px; width:800px" scrolling="no" frameborder="0"/></iframe>  

---
## Codes for this project
You will explore the overall change from 1950 to 2013:  

```r
require('rCharts')
CoffIndia <- CoffData[ (CoffData$variable == variableNAMES[13]) & (CoffData$region == "India"), ]
CoffIndia1 <- data.frame(Year = CoffIndia$Time, Arabica = CoffIndia$Value[CoffIndia$Category == "Arabica"], Robusta = CoffIndia$Value[CoffIndia$Category == "Robusta"] )
Coff1 <- mPlot(x = "Year", y = c("Arabica", "Robusta"), type = "Line", data = CoffIndia1)
Coff1$set(pointSize = 0, lineWidth = 2)
#Coff1$print("chart1")
Coff1$save("coff1.html")
cat('<iframe src="coff1.html" width=100%, height=100%></iframe>')
```
You will compare the production in the primary areas during the least two years:  

```r
CoffProv <- CoffData[ (CoffData$variable == variableNAMES[13]) & 
                          (CoffData$region == PriRegions[1] | 
                           CoffData$region == PriRegions[2] |
                           CoffData$region == PriRegions[3]), ]
CoffProv$region_year <- paste0(CoffProv$region,"(",CoffProv$Time,")")
Coff2 <- nPlot(Value ~ region_year, group = "Category", data = CoffProv, type = "multiBarChart") 
#Coff2$print("chart1")
Coff2$save("coff2.html")
cat('<iframe src="coff2.html" width=100%, height=100%></iframe>')
```

---
## Coffee production through 1951-2012
<iframe src="coff1.html" width=100%, height=100%></iframe>

---
## Coffee productino in the primary areas
<iframe src="coff2.html" width=100%, height=100%></iframe>
