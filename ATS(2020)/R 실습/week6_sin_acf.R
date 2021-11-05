## R uses radians so to set frequency we'll do radians
require(data.table)
x = 1:100

## Noiseless series
y = sin(x * pi / 4) #sin함수 생성
par(mfrow=c(3,1)) #세 개의 plot 찍겠다는 뜻
plot(y, type = 'b', xlim=c(0,20)) #오리지날 plot
acf(y) #유의수준 넘는 값들이 보인다. 사인 함수는 앞의 시점과 어느정도 연관이 있다는 것 확인
pacf(y)

#
y = sin(x * pi / 10) #주기 길어짐
plot(y, type = 'b', xlim=c(0,20))
(acf(y)) #autocorrelation 보여줌
pacf(y)

#shift()함수 이용해서 ACF를 구할 수도 있다
for (i in 1:10){
    print(cor(y, shift(y,i), use="pairwise.complete.obs"))
    }

x = 1:100
y = sin(x * pi / 4) #sin함수 생성
par(mfrow=c(3,1)) #세 개의 plot 찍겠다는 뜻
plot(y, type = 'b', xlim=c(0,20)) #오리지날 plot
acf(y) #유의수준 넘는 값들이 보인다. 사인 함수는 앞의 시점과 어느정도 연관이 있다는 것 확인
pacf(y)


## sin함수 안의 개수가 달라질 때의 경우------
par(mfrow = c(3, 1))

plot(sin(x*pi/2), type='b',xlim=c(0,40))
plot(sin(x*pi/4), type='b',xlim=c(0,40))
plot(sin(x*pi/10), type='b',xlim=c(0,40)) #주기가 점점 길어짐

## ------ periodic function ----
par(mfrow = c (2,3))
y1 <- sin(x*pi/3)
plot(y1, type='b')
acf(y1)
pacf(y1)

y2 <-sin(x*pi/10)
plot(y2, type='b')
acf(y2)
pacf(y2)

par(mfrow = c(3, 1))
y = sin(x * pi / 4) + sin(x * pi / 10) #두 주기함수의 합으로 이루어지는 함수
plot(y, type = 'b', xlim=c(0,21))
acf(y)
pacf(y)
#주기가 다른 두 주기함수의 합
#pacf를 통해, 어느 시점까지 영향을 주는지 확인해볼 수 있다(8까지)

par(mfrow = c(3, 3))
## Somewhat noisy series
noise1 = rnorm(100, sd = 0.05) #sd로 노이즈 생성
noise2 = rnorm(100, sd = 0.05)
par(mfrow = c(3, 3))
y = sin(x * pi / 4) + noise1 #노이즈 추가
plot(y, type = 'b')
acf(y)
pacf(y)

y = sin(x * pi / 10) + noise2
plot(y, type = 'b')
acf(y)
pacf(y)

y = sin(x * pi / 4) + sin(x * pi / 10) + noise1 + noise2
plot(y, type = 'b')
acf(y)
pacf(y)

## Very noisy series
noise1 = rnorm(100, sd = 0.3) #노이즈 크기를 크게 함
noise2 = rnorm(100, sd = 0.3)
par(mfrow = c(3, 3))
y = sin(x * pi / 4) + noise1
plot(y, type = 'b')
acf(y)
pacf(y)

y = sin(x * pi / 10) + noise2
plot(y, type = 'b')
acf(y)
pacf(y)

y = sin(x * pi / 4) + sin(x * pi / 10) + noise1 + noise2
plot(y, type = 'b')
acf(y)
pacf(y)


## very very noisy 
## Very noisy series
noise1 = rnorm(100, sd = 1) #표준편차가 무려 1
noise2 = rnorm(100, sd = 1)
par(mfrow = c(3, 3))
y = sin(x * pi / 4) + noise1
plot(y, type = 'b')
acf(y)
pacf(y)

y = sin(x * pi / 10) + noise2
plot(y, type = 'b')
acf(y)
pacf(y)

y = sin(x * pi / 4) + sin(x * pi / 10) + noise1 + noise2
plot(y, type = 'b')
acf(y)
pacf(y)
#더 어려워짐.... 어느 시점에서 끝나는 게 아니라.. 뒤에서도 반복이 되고 있다..
#함수가 복잡할수록, pacf가 딱 어느 수준까지 영향을 준다고 말하기가 어려워진다

## nonstationary, trend, linear : 비정상, 추세가 있는 선형 모델
x<- 1:100
par(mfrow = c(3, 1))
plot(x)
acf(x)
pacf(x) #바로 앞 데이터와만 연관이 있음을 알려줌


require(data.table)
require(zoo)
AirPassengers <- fread("C:/Users/김서윤/Documents/2020 2학기 강의/응용시계열분석(임미영)/ch02/AirPassengers.csv")
AirPassengers.ts = ts(
    data=AirPassengers$V2,
    start=as.yearmon(AirPassengers[1]$V1),
    end=as.yearmon(tail(AirPassengers)[5]$V1),
    frequency=12 #1년 주기
) #time series data로 바꿔줌
par(mfrow = c(3, 1))
plot(AirPassengers.ts)
acf(AirPassengers.ts) #추세가 있기 때문에, ACF는 모든 수준에서 유의하다고 나온다
pacf(AirPassengers.ts) #PACF는 x축을 보면, 1년쯤 됐을 때 비슷하게 반복됨을 보여줌
#앞의 데이터가, 바로 뒤, 그리고 12개월 뒤까지 영향을 주더라.....