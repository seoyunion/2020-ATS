####ck week 3####
###Missing Data Construction###
getwd()
setwd("C:/Users/김서윤/Documents/2020 2학기 강의/응용시계열분석(임미영)/R 실습")


#Imputation : 결측값 대체
#Interpolation : 인접 데이터포인트 사용하여 누락된 값 추정
#Deletion of affected time periods: 비추천

#install.packages("devtools")
library(devtools)

require(data.table)
require(zoo)

unemp <- fread("UNRATE.csv")
unemp[, DATE := as.Date(DATE)]
head(unemp) #DATE 열을 날짜 형식으로 변환

## generate a data set where data is randomly missing
rand.unemp.idx <- sample(1:nrow(unemp), .1*nrow(unemp)) #1부터 전체 행 개수 중 10% 만큼의 개수를 샘플링
rand.unemp <- unemp[-rand.unemp.idx] #랜덤한 unemp데이터에서 방금 샘플링 한 데이터를 빼줌
nrow(unemp)
nrow(rand.unemp)

## generate a data set
## where data is more likely to be missing if it's high
high.unemp.idx <- which(unemp$UNRATE > 8) #8보다 높은 실업률 갖는 데이터 중 반 샘플링
high.unemp.idx <- sample(high.unemp.idx, .5*length(high.unemp.idx))
bias.unemp <- unemp[-high.unemp.idx]
nrow(bias.unemp)


#######[data.table Package]#######
##dt[, new.col := old.col + 7]
##dt[, .(col1, col2, col3)]   #######열을 둘러싸는 ".()" : 리스트를 빨리 작성하는 법

##dt[col1 < 3 & col2 >5]
##dt[col1 < 3 & col2>5,. (col1, col2, col3)]
##dt[, .N, col1]  ##### ".N" : 행 계수 계산

all.dates <- seq(from = unemp$DATE[1], to=tail(unemp$DATE, 1), #DATE변수의 첫번째부터 마지막까지
                 by="month") #월별로 추출
#확인
head(unemp)
tail(unemp)
unemp$DATE[1]

rand.unemp = rand.unemp[J(all.dates), on='DATE', roll=0] #DATE라는 변수에 대해서
bias.unemp = bias.unemp[J(all.dates), on='DATE', roll=0] ###????### roll??
rand.unemp[, rpt := is.na(UNRATE)] #rpt라는 이름으로 rand.unemp변수 바로 뒤에 is.na(T or F)값을 부착하라


#확인
nrow(rand.unemp)
nrow(bias.unemp)
head(rand.unemp)
head(bias.unemp)



##-------------------DANATION DATA AS EXAMPLE---------------
###Missing Data Interpolation####

#Forward fill
#Moving average
#Interpolation


donations <- data.table(
  amt = c(99,100,5,15,11,1200),
  dt = as.Date(c("2019-2-27", "2019-3-2", "2019-6-13", "2019-8-1", "2019-8-31", "2019-9-15"))
)

publicity <- data.table(
  identifier = c("q4q42", "4299hj", "bbg2"), #캠페인 아이디
  dt = as.Date(c("2019-1-1", "2019-4-1", "2019-7-1")) #캠페인이 시작된 날짜
)

#확인
donations
publicity
#rolling join 2번째 방법
setkey(publicity, 'dt')
setkey(donations, 'dt')
publicity[donations, roll=TRUE] #이벤트를 기부에 대해 롤링: 각각의 캠페인 별로 기부금이 얼마나 들어왔는 지 확인 가능
##------------------------------------------



## ------ FORWARD fill --------

#누락된 값 채우는 가장 간단한 방법
#바로 앞의 값으로 채워줌
rand.unemp[, impute.ff := na.locf(UNRATE, na.rm=FALSE)] #impute.ff 열 추가, UNRATE변수를 na.locf함수로 forwardfill해줌
bias.unemp[, impute.ff := na.locf(UNRATE, na.rm=FALSE)]

#확인
head(rand.unemp) #열 추가됨
head(bias.unemp)

#plotting
unemp[350:400, plot(DATE, UNRATE, col=1, lwd=2, type='b')] #range=350~400, col=색깔, lwd=line width
rand.unemp[350:400, lines(DATE, impute.ff, col=1, lwd=2, lty=2)] #
rand.unemp[350:400][rpt==TRUE, points(DATE, impute.ff, col=2, pch=6, cex=2)] #rpt==TRUE: NA값이었던 것들 표시


## ------- Simple MOVING Average -----

#주변의 평균이나 중앙값으로 데이터 대치
#잡음이 많은 데이터셋에 대해서 더 적합
#Lookahead 방지

rand.unemp <- rand.unemp[, impute.rm.nolkh := rollapply(c(NA,NA,UNRATE), 3, #없는 값 앞의 두개를 보겠다
                                                        function(x) {
                                                          if (!is.na(x[3])) x[3] else mean(x, na.rm = TRUE) #NA값 무시하고 세 개의 값의 평균 구하기 위함
                                                        })]
bias.unemp <- bias.unemp[, impute.rm.nolkh := rollapply(c(NA,NA,UNRATE), 3,
                                                        function(x) {
                                                          if (!is.na(x[3])) x[3] else mean(x, na.rm = TRUE)
                                                        })]

#확인                                       
head(rand.unemp)
head(bias.unemp)


##누락된 데이터 이전, 이후 데이터의 값을 통해 계산하는 것이 더 좋은 경우도 있다.(예측 모델에는 적함X)
##-------- Lookahead MA --------
rand.unemp[, complete.rm := rollapply(c(NA, UNRATE, NA), 3, #룩어헤드가 있는 이동평균
                                      function(x) {
                                        if (!is.na(x[2]))
                                          x[2]
                                        else {
                                          mean(x, na.rm=TRUE)
                                        }
                                      })]
head(rand.unemp)
rand.unemp[350:400][rpt==TRUE, points(DATE, complete.rm, col=2, pch=6, cex=2)]

## -------linear interpolation --------
rand.unemp[, impute.li := na.approx(UNRATE)]
bias.unemp[, impute.li := na.approx(UNRATE)]

## ------ Ploynomial interpolation --------
rand.unemp[, impute.sp := na.spline(UNRATE)]
bias.unemp[, impute.sp := na.spline(UNRATE)]

head(rand.unemp)

#plotting
use.idx = 90:120 #인덱스로 사용할 범위
unemp[use.idx, plot(DATE, UNRATE, col=1, type='b')]
rand.unemp[use.idx, lines(DATE, impute.li, col=2, lwd=2, lty=2)]
rand.unemp[use.idx, lines(DATE, impute.sp, col=3, lwd=2, lty=3)]


#####overall comparison

##rand.unemp[which(rand.unemp$rpt == TRUE)]

sort(rand.unemp[, lapply(.SD, #표준편차 SD를 기준으로 정렬
                         function(x)
                           mean((x -unemp$UNRATE)^2, na.rm=TRUE)),
                .SDcols = c("impute.ff", "impute.rm.nolkh", "impute.li", "impute.sp", "complete.rm")
                ]) #표준편차를 구할 컬럼들

#간단하게 비교 가능









