library(treemap)
library(tidyverse)
library(packcircles)
library(ggplot2)
library(viridis)
library(ggiraph)
library(wordcloud2)



#AVGDAYFINE - PIGoutput1.1
AvgDayfine <- read.delim("C:/Users/sindh/Desktop/PDA/Pig_cmd.pig - Task 4/AvgDayfine", header=FALSE)
colnames(AvgDayfine) <- c('Day','AVGFine')
plot(AvgDayfine,type = 'o',lwd=5, pch=15,xlab="Day of month",ylab="Average fine amount",
     col = "blue",main = "Average fine on every day of a month(2010-2018)")

#AVGMONTHFINE - PIGoutput1.2
AvgMonthfine <- read.delim("C:/Users/sindh/Desktop/PDA/Pig_cmd.pig - Task 4/AvgMonthfine", header=FALSE)
colnames(AvgMonthfine) <- c('Month','AVGFine')
plot(AvgMonthfine,type = 'o',lwd=5, pch=15,xlab="Month of Year",ylab="Average fine amount", 
     col = "blue",main = "Average fine on every month of a year(2010-2018)")

#AVGYEARFINE - Pigoutput1.3
AvgYearfine <- read.delim("C:/Users/sindh/Desktop/PDA/Pig_cmd.pig - Task 4/AvgYearfine", header=FALSE)
colnames(AvgYearfine) <- c('Year','AVGFine')
plot(AvgYearfine,type = 'o',lwd=5, pch=15,xlab="Year",ylab="Average fine amount", 
     col = "blue",main = "Average fine on every year from 2010-2018")
AvgYearfine
#Bodystylecount - Pigoutput 2.1
Bodystylecount <- read.delim("C:/Users/sindh/Desktop/PDA/Pig_cmdcount.pig - Task 5/Bodystylecount", header=FALSE)
colnames(Bodystylecount) <- c('Body-style','Number of Incidents')
Bodystylecount
a <- Bodystylecount %>% filter(Bodystylecount$`Number of Incidents` > 46)
treemap(a,index=c("Body-style","Number of Incidents"),vSize="Number of Incidents",align.labels = list(c("centre","centre"),
      c("left","top")),fontsize.labels = c(12,12),type="index", palette = "Reds", fontsize.title = 15,
      title="Top 10 Bodystyle of vehicles charged with parking violations(2018)")

#Colourcount - Pigoutput 2.2
#code source : https://www.r-graph-gallery.com/307-add-space-in-circle-packing/
Colourcount <- read.delim("C:/Users/sindh/Desktop/PDA/Pig_cmdcount.pig - Task 5/ColourCount", header=FALSE)
colnames(Colourcount) <- c('colour','value')
data <- Colourcount %>% filter(Colourcount$`value` > 2000)
data$colour <- c('Black','Blue','Grey','Silver','White')
packing <- circleProgressiveLayout(data$value, sizetype='area')
data = cbind(data, packing)
plot(data$radius, data$value)
dat.gg <- circleLayoutVertices(packing, npoints=50)
ggplot() + 
  geom_polygon(data = dat.gg, aes(x, y, colour = id, fill=as.factor(id)), colour = "black", alpha = 0.6) +
   geom_text(data = data, aes(x, y, size=10, label = colour)) +
  scale_size_continuous(range = c(1,4)) +
    theme_void() + 
  theme(legend.position="none") +
  coord_equal() 

#Makecount - Pigout 2.3
Makecount <- read.delim("C:/Users/sindh/Desktop/PDA/Pig_cmdcount.pig - Task 5/MakeCount", header=FALSE)
colnames(Makecount) <- c('Make','value')
data <- Makecount %>% filter(Makecount$`value` > 650)
barplot(data$`value` ,names=data$`Make` ,xlab="Make of Vehicles",ylab="Number of Incidents",col="blue",main="Top 10 Brands of vehicles involved in parking violation(2018)",border="Black", col.main="red", col.lab="blue", col.sub="black" )

#Routecount - Pigout 2.4
#Source code: https://www.r-graph-gallery.com/lollipop-plot/
Routecount <- read.delim("C:/Users/sindh/Desktop/PDA/Pig_cmdcount.pig - Task 5/Routecount", header=FALSE)
colnames(Routecount) <- c('x','y')
Routecount
data <- Routecount %>% filter(Routecount$`y` > 212)
data

ggplot(data, aes(x=x, y=y)) +
  geom_segment( aes(x=x, xend=x, y=0, yend=y)) +
  geom_point( size=2, color="blue", fill=alpha("orange", 0.3), alpha=0.7, shape=21, stroke=2) +
theme_light() +
  theme(
    panel.grid.major.x = element_blank(),
    panel.border = element_blank(),
    axis.ticks.x = element_blank()
  ) +
  labs(x = "Route ID", y = "Number of incidents" , title = "Top 10 Routes with most parking violations-2018" ) 

#Monthvioroute - Mapreduce output 3.3
#Source code : http://www.dataanalytics.org.uk/Data%20Analysis/R%20Monographs/Legends.htm
Monthvioroute <- read.delim("C:/Users/sindh/Desktop/PDA/Eclipse - Mapreduce - Task 3 - Monthvioroute/Monthvioroute", header=FALSE)
colnames(Monthvioroute) <- c('Description(Month,Violation & Route)','count')
Monthvioroute
data <- Monthvioroute %>% filter(Monthvioroute$`count` > 900) 
data
mycols = c("blue", "red", "orange", "green", "pink")
barplot(data$`count`,beside = TRUE,
        horiz=T,xlab="Number of Incidents",ylab="Description(Month,Violation & Route",col= mycols,
        main="Top 5 routes with most parking violation with Violation description and Month(2010-2018)",
        border="Black", col.main="red", col.lab="blue", font.axis = 5, 
        col.axis = "Blue", col.lab = "Blue", cex.lab = 1.5  )
        
       legend(x = "topright", legend =data$`Description(Month,Violation & Route)`, fill = mycols,
               bty = "n", pch=20 , cex = 0.8, horiz = FALSE, inset = c(0.05, 0.05))

#Statefine - Mapreduce output 3.1
       Statefine <- read.delim("C:/Users/sindh/Desktop/PDA/Eclipse - Mapreduce - Task 1 - Statefine/Statefine", header=FALSE)
       colnames(Statefine) <- c('State','Fine')
       Statefine      
       data <- Statefine %>% filter(Statefine$`Fine` > 29)
       data <- data %>% filter(data$Fine < 20000)
       data
       wordcloud2(data, size=1, color='random-dark')
       
#Makeyear - Mapreduce output 3.2
       Makeyear <- read.delim("C:/Users/sindh/Desktop/PDA/Eclipse - Mapreduce - Task 2 - Makeyear/Makeyear", header=FALSE)
       colnames(Makeyear) <- c('Make & Year','Count')
       Makeyear      
       data <- Makeyear %>% filter(Makeyear$`Count` > 100)
       data <- data %>% filter(data$Fine < 20000)
       data
       wordcloud2(data, size=1, color='random-dark')
       
  
       
