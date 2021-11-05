####week4####
###Upsampling & Downsampling###


setwd("C:/Users/김서윤/Documents/2020 2학기 강의/응용시계열분석(임미영)/R 실습")

library(devtools)

require(data.table)
require(zoo)

unemp <- fread("UNRATE.csv")
unemp[, DATE := as.Date(DATE)]
head(unemp) #DATE 열을 날짜 형식으로 변환

#Downsampling
unemp.jan = unemp[seq.int(from=1, to=nrow(unemp), by=12)] #12개씩 건너뛴다는 소리
# seq: sequence generator
# seq.int: integer sequence generator
head(unemp.jan) #매년 1월 데이터만!
unemp.avg <- unemp[, round(mean(UNRATE),2), by=format(DATE, "%Y")] #by year
head(unemp.avg)

#Upsampling
all.dates <- seq(from=unemp$DATE[1], to=tail(unemp$DATE, 1), by='day')
head(all.dates)

daily.unemp = unemp[J(all.dates),  on='DATE',roll=31]
head(daily.unemp)











