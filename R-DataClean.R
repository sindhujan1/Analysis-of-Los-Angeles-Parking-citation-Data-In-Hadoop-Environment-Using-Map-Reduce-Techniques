library(readr)
PC <- read_csv("parking-citations.csv", 
                              col_types = cols(`Issue time` = col_skip(), 
                                               Latitude = col_skip(), Longitude = col_skip(), 
                                               `Marked Time` = col_skip(), `Meter Id` = col_skip(), 
                                               `Plate Expiry Date` = col_skip(), 
                                               VIN = col_skip(), `Violation code` = col_skip()))
PC$Location <- NULL
K <- PC
PC <- PC[complete.cases(PC), ]
colnames(PC) <- c('Ticket ID','Issue Date','State plate','Make','Body style','Colour','Route','Agency','Violation Description','Fine amount')
PC$`Issue Date` <- as.Date(PC$`Issue Date`)
df <- data.frame(
                 Year = as.numeric(format(PC$`Issue Date`, format = "%Y")),
                 Month = as.numeric(format(PC$`Issue Date`, format = "%m")),
                 Day = as.numeric(format(PC$`Issue Date`, format = "%d")))
PC <- cbind(PC,df)
summary(PC)
write.csv(PC,file='C:/Users/sindh/Desktop/Parking.csv', row.names = FALSE)

