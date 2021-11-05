plot(USAccDeaths)

data = USAccDeaths

data.differenced = diff(diff(log(data)))

plot(data.differenced)
acf(data.differenced)
pacf(data.differenced)


### 기말 코드 정리 ###

################ file_io ################################

# week 9
# Ch06: feather 데이터 타입 실습

# chooseCRANmirror(ind=47) -- 경산시
# install.packages("feather")
library(feather)
print(mtcars) #내장 데이터 불러옴. 이걸 저장할 것임.

# mtcars data
path <- "C:/Users/김서윤/Documents/2020 2학기 강의/응용시계열분석(임미영)/R 실습/mtcars.feather"
write_feather(mtcars, path) #데이터 저장
df = read_feather(path) # 저장한 데이터 읽어들임

# RDS data 
path <- "C:/Users/김서윤/Documents/2020 2학기 강의/응용시계열분석(임미영)/R 실습/mtcars.RDS"
saveRDS(mtcars, path)
readRDS(path) #R의 기본형식이기 때문에 동일하게 저장됨
# feather는 파이썬/R 둘다 사용 가능

# 이번엔 save와 load를 사용해보자!(가장 기본적인 내장 함수)
mycars = mtcars
save(mycars, file=path)
print(load(path)) #mycars -> save와 load만 사용하면 그냥 변수 자체를 저장
#rm(mycars) #변수 삭제하고 다시 로드하고 mycars 프린트해보자
print(mycars) #데이터가 출력된다

# RData 형식
path <- "./mtcars.RData"
mycars2 = mycars
save(mycars2, file=path)
print(load(path))
print(mycars2)
rm(mycars2)
print(mycars2) # 다시 로딩 해주고 프린트하면 다시 출력된다

# rda 형식
path <- "./mtcars.rda"
mycars2 = mycars
save(mycars2, file=path)
print(load(path))
print(mycars2)


################################## ar ################################

# week 10

#### AR model simulation ####
set.seed(2016)
N =1000
phi =1 #0.4 -> 1(랜덤워크)
z=rnorm(N, 0, 1) #et 정의
x=NULL
x[1]=z[1]

#2~n까지 for문으로 xt를 채워줌
for (t in 2:N){
  x[t] = z[t] + phi*x[t-1] #AR모델과 동일
} #x를 얻어냄
x.ts = ts(x) #x를 time series로 변환
par(mfrow=c(2,1)) #그릴 plot 개수 정해준다음
plot(x.ts, main=paste("AR(1) time series on white noise, phi=",toString(phi))) #plot 그려줌
x.acf = acf(x.ts, main=paste("AR(1) time series on white noise, phi=",toString(phi))) 
# paste함수: 해당 문자열과 뒤의 값을 붙여줌(자동으로 값이 바뀌도록)
# phi=1이면 정상성 X, 평균도 일정하지 않고 acf도 cutoff되지 않음
# -> 계수가 일정 범위 안에 있을 때만 정상 시계열이 된다!(-1<phi<1)
# x.coef = x.acf$acf
# mean(x.coef)


#### AR(2) model simulation ####
#plot 그리는 함수
plot_function <- function(x.ts, phi1, phi2) {
  par(mfrow=c(2,1))
  title=paste("AR(2) time series, phi1=", toString(phi1), "phi2=", toString(phi2))
  plot(x.ts, main=title)
  x.acf = acf(x.ts, main=title)
}

set.seed(2017)
phi1 = 0.7
phi2 = 0.2
x.ts = arima.sim(list(ar=c(phi1, phi2)), n=1000)

plot_function(x.ts, phi1, phi2)


phi1 = 0.5
phi2 = -0.4 #음수 값으로 정의
x.ts = arima.sim(list(ar=c(phi1, phi2)), n=1000) 

plot_function(x.ts, phi1, phi2) #acf가 음수 값을 가지게 된다

# 이 두 AR 모델이 다 stationary한 범위에 있기 때문에 어느 정도 lag를 지나면 유의수준 안에 acf가 위치함을 확인할 수 있다.


#week 10

# https://archive.ics.uci.edu/ml/datasets/Daily+Demand+Forecasting+Orders
# 여기서 데이터 정보 확인 가능
require(stats)
require(data.table)
demand = fread('C:/Users/김서윤/Documents/2020 2학기 강의/응용시계열분석(임미영)/Daily_Demand_Forecasting_Orders.csv')
demand = ts(demand[['Banking orders (2)']]) #실습에서는 데이터의 이 부분을 사용할거다
head(demand)
plot(demand)
pacf(demand) #lag=3 -> AR(3) 모댈

#ar
fit <- ar(demand, method='mle') #order를 지정해주지 않으면 이 함수가 자체적으로 지정해줌
fit # fitting된 결과가 나옴. 이런 계수들을 가진다. 이 데이터로 여러 모델링을 할 수 있을 것이다?
# 세 개의 coefficient: 각각 Xt-1, Xt-2, Xt-3에  대한 계수

#airima 모델을 사용할 수도 있다 -> order 3
est = arima(x=demand, order=c(3,0,0)) #order(arima,differencing degree,ma)
est #확인해보면 앞에서 봤던 것과 거의 비슷한 결과가 coefficient로 fitting되어서 나옴
est.1 = arima(x=demand, order=c(3,0,0), fixed=c(0,NA,NA,NA)) #fixed: 첫번째 codfficient를 무조건 0으로 지정
est.1 #Xt-1의 coefficient를 0으로 지정해놓고 나머지 값들을 찾아나간 결과 반환

# 훈련 데이터셋에 대해 모델성능을 검사해 이 데이터셋에 대해 어떤 모델이 적합한지 평가 가능
# 잔차의 acf를 살펴봄
# 1. est.1$residuals
acf(est.1$residuals) #유의수준을 넘어가는 잔차가 관측되면 모델 수정
# 2. LB test
Box.test(est.1$residuals, lag=10, type='Ljung', fitdf=3) #lag10안에서 correlation이 있는지 확인
# -> p-value = 0.2301 : 직렬상관관계X

# AR(p)모델을 사용한 예측
require(forecast)
plot(demand, type='l')
lines(fitted(est.1), col=3, lwd=2) #예측된 그래프
lines(fitted(est), col=2, lwd=2)

# correlation
# 예측을 했을 떄 예측한 값의 형질을 살펴보자. 
# 실제 값과 예측 값의 상관관계: 높을수록 좋다.(단, 사전에 트렌드 등을 충분히 잘 제거해주어야 함)
est.vals = fitted(est) #예측된 값들
est.1.vals = fitted(est.1)
cor(diff(est.vals), diff(demand))
cor(diff(est.1.vals), diff(demand))

plot(demand, type='l')
lines(fitted(est), col=2, lwd=2) #실제 데이터의 큰 편차들을 예측하지 못하는 것을 확인

# many steps forecast
# 여러 단계를 예측해보고, 그것의 분산을 확인해보자
var(fitted(est.1,  h=3), na.rm=TRUE)
var(fitted(est.1, h=10), na.rm=TRUE)
var(fitted(est.1, h=20), na.rm=TRUE)
var(fitted(est.1, h=30), na.rm=TRUE) # 여러 단계가 될 수록 variance가 작아짐
# 구간이 많아질수록, 모델이 정확도를 높이기 위해 무조건 수렴되는 값으로 예측을 하게 됨.
# 무조건적으로 평균값으로 예측하는 경향을 띄게 됨. -> 먼 값보다는 가까운 곳의 값들을 예측하기에 적합.

########################## ma ##########################

# week 10

# Genenrate noise 
noise = rnorm(10000) #노이즈 생성

# Introduce a var 
ma_2 = NULL #ma_2 정의

# Loop for generatring MA(2) : ma_2이기 떄문에 세번쨰 값부터 채워짐
for (i in 3:10000){
  ma_2[i] = noise[i] +0.7*noise[i-1]+0.2*noise[i-2] #가중치 각각 0.7, 0.2 
}

# Shift data to left by 2 units 
ma_process = ma_2[3:10000] #마찬가지로 앞의 두개 지우고 세번째 값부터 ma process 정의
head(ma_process) #값들이 정의되었음을 확인

# Put time series structure on a vanilla data
ma_process = ts(ma_process) #정의된 sequence를 시계열 데이터로 변환

# Partition output graphics as a multi frame of 2 rows and 1 col
par(mfrow=c(2,1))

# Plot the process and plot in ACF 
plot(ma_process, main = 'A MA(2) process', ylab=' ', col='blue')
acf(ma_process, main = 'Corellogram of a MA(2) process') #lag=2에서 acf값이 cutoff됨을 확인
#앞의 두 단계 노이즈까지 영향을 받는다.


# week 10

require(stats)
require(data.table)
require(forecast)

demand = fread('C:/Users/김서윤/Documents/2020 2학기 강의/응용시계열분석(임미영)/Daily_Demand_Forecasting_Orders.csv')
demand = ts(demand[['Banking orders (2)']])

acf(demand) #lag=3, 10일 때 유의수준에 접근하는 양상을 보임
# lag=10일 때 유의수준 넘어감 -> order=10로 세팅해주자

ma.est = arima(x=demand, 
               order=c(0,0,10),#마지막 값이 MA process order
               fixed=c(0,0,NA,rep(0,6),NA,NA) #-> 0  0 NA  0  0  0  0  0 NA NA (fixed coefficient)
) #아까 3,9번째 값이 유의수준 접근 -> NA로 세팅, 마지막 값은 intercept(절편)

#모델링된 MA3, MA9, ntercept의 coefficient 확인
print(ma.est)

#LB test
Box.test(ma.est$residuals, lag=10, type='Ljung', fitdf=3) #잔차를 이용해 Boxtest
# fitdf: 모델링을 했을 때 free variable 개수(number of degrees of freedom) -> 3개(NA)
# p-value = 0.3643 -> 가설 기각 X(자기상관 없음)

# 예측
ma.est.val.h1 = fitted(ma.est, h=1) #1개 구간에 대해 예측
ma.est.val.h10 = fitted(ma.est, h=10) #10개 구간에 대해 예측

plot(demand)
lines(ma.est.val.h1, col=3, lwd=2)
lines(ma.est.val.h10, col=2, lwd=2) #평균에 매우 근접하게 예측 -> 이러한 통계적 모델은 긴 구간 예측에는 적합 X

#ma.est.val.h1 #값 확인 가능
#ma.est.val.h10


################ AIC ##########################

# week 10

# Example of Loblolly pine trees 
plot(height~age, data=Loblolly)

# Simulate data 
set.seed(43)
data=arima.sim(list(order=c(2,0,0), ar=c(0.7,-0.2)), n=2000) #AR(2)모델을 사용해서 데이터를 얻어냄, 데이터 수:2000
par(mfrow=c(1,2))
acf(data) #lag=3~4까지는 영향을 줌
pacf(data) #lag=2이후에는 현저하게 작아짐
#우리는 이미 이 데이터가 AR(2)모델, 계수는 0.7,-0.2이 가장 적합함을 알고 있지만,
#만약 이 데이터만 주어졌을 떄 어떤 모델이 가장 적합한지 알아보기 위해 SSE값을 살펴보자


# compare models
# 모델 4개 준비
ar1 = arima(data, order=c(1,0,0), include.mean=FALSE)
ar2 = arima(data, order=c(2,0,0), include.mean=FALSE) 
ar3 = arima(data, order=c(3,0,0), include.mean=FALSE)
ar4 = arima(data, order=c(4,0,0), include.mean=FALSE)
#ar2 #: coefficient 볼 수 있음. 

#각 모델의 SSE값
sse1 = sum(resid(ar1)^2)
sse2 = sum(resid(ar2)^2)
sse3 = sum(resid(ar3)^2)
sse4 = sum(resid(ar4)^2)
print(c(sse1, sse2, sse3, sse4))
#두번쨰 모델에서 오류값 급격히 낮아짐, 3일 떄는 아주 조금 감소

#파라미터 많을수록 패널티를 준 aic값은 어떨까
aics <- c(ar1$aic, ar2$aic, ar3$aic, ar4$aic)
plot(aics)
print(aics)
#aic값이 2일 떄 가장 낮다. 3,4 일 때 패널티를 더 줬기 때문


####################### ARMA ################

# week 11

set.seed(500)
# Beginning of Heptarchy: Kent, Essex, Sussex,
# Wessex, East Anglia, Mercia, and Northumbria.

# 데이터 생성
data = arima.sim(list(order=c(1,0,1), ar=0.7, ma=0.2), n=1000000)#ARorder(p)=1, MAorder(q)=1
par(mfcol=c(3,1))
plot(data,main="ARMA(1,1) Time Series: phi1=.7, theta1=.2", xlim=c(0,400))
acf(data, main="Autocorrelation of ARMA(1,1), phi1=.7, theta1=.2") #acf: lag가 길게 이어짐. 좋지 않아...
acf(data, type="partial", main="Partial Autocorrelation of ARMA(1,1), phi1=.7, theta1=.2") #partial: pacf

# 내장 데이터 discoveries
plot(discoveries,main = "Time Series of Number of Major Scientific Discoveries in a Year")#내장데이터
stripchart(discoveries, method = "stack", offset=.5, at=.15,pch=19,
           main="Number of Discoveries Dotplot",
           xlab="Number of Major Scientific Discoveries in a Year",
           ylab="Frequency")

par(mfcol = c(2,1))
acf(discoveries, main="ACF of Number of Major Scientific Discoveries in a Year") #lag=3까지 유의수준 넘어감
acf(discoveries, type="partial", main="PACF of Number of Major Scientific Discoveries in a Year") #lag=2에서유의수준 근접

#p와 q를 넣어서 가장 작은 aic값을 가지는 모델을 선택해보자
for (p in 0:3){
  for (q in 0:3){
    print(c(p, q, AIC(arima(discoveries, order=c(p, 0, q)))))
  }
}
# p=1, q=1일 떄 aic 값이 440.198으로 가장 작다
arima(discoveries, order=c(1,0,1)) #모델링

plot(discoveries)

# 자동화
library(forecast)
auto.arima(discoveries, d=0) #ARIMA(1,0,1) with non-zero mean  찾아냄

#default = 'aicc'
auto.arima(discoveries, d=0, ic="bic") #bic 기반 탐색 -> 잘 찾아냄
auto.arima(discoveries, d=0, ic="aic") #aic 기반 탐색(기본값은 aicc) -> aic:잘 찾아내지 못함
#오토 모델이 항상 최적 값을 찾아내는 것은 아니다. 대체적으로 비슷한 값 찾긴 함
#매뉴얼, 자동화 검증 필요

######################### ARIMA #################

# week 11

#Simulation: generate the data from an ARMA process

# ARMA + 차분 = ARIMA 모델
require(forecast)

# ARMA모델로 시뮬레이션 데이터 만들어줌
set.seed(1017)
phi1 = 0.8
phi2 = -0.4
x.ts = arima.sim(list(ar=c(phi1, phi2), ma=c(0.2)), n=1000) #모델 정의: AR(2), MA(1) ARIMA 모델
plot(x.ts) #대체적으로 평균 일정, 트렌드도 없음. 
acf(x.ts) #4까지 유의수준 넘어감, 12,24에서도
pacf(x.ts) #3, 21에서 유의수준 넘어감

#아무것도 모른다고 치고 order를 1부터 넣어서 살펴보자
ar1.ma1.md = Arima(x.ts, order=c(1,0,1)) #대체적으로 평균 일정, 트렌드 없으니 d=0
par(mfrow=c(2,1))
acf(ar1.ma1.md$residuals) #모델의 잔차를 살펴봐서 자기상관을 가지고 있으면 모델의 변수를 조정해줘야 함
pacf(ar1.ma1.md$residuals)
# 둘 다 유의수준을 넘어가는 값들이 보임. -> order 조정해줘야 함
ar2.ma1.md =Arima(x.ts, order=c(2,0,1))
plot(x.ts, type='l') #실제 데이터
lines(ar2.ma1.md$fitted, col=2) #피팅된 데이터

plot(x.ts, ar2.ma1.md$fitted)
par(mfrow=c(2,1))
acf(ar2.ma1.md$residuals) #잔차의 acf
pacf(ar2.ma1.md$residuals) #잔차의 pacf
#대체적으로 유의수준 안으로 들어옴을 확인

#aic값 확인
ar1.ma1.md$aic
ar2.ma1.md$aic #훨씬 작다

#얘네도 모델링을 해보자
ar2.ma2.md = Arima(x.ts, order=c(2,0,2))
plot(x.ts, type='l')
lines(ar2.ma2.md$fitted, col=2)

par(mfrow=c(2,1))
acf(ar2.ma2.md$residuals)
pacf(ar2.ma2.md$residuals)
#얘도 나쁘지 않음

ar1.ma1.md$aic
ar2.ma1.md$aic #얘가 그래도 쪼끔 더 낮음(학습할 파라미터가 더 적음->선호)
ar2.ma2.md$aic
#aic값이 크지 않을 경우 파라미터가 더 적은 모델 선택
# 모델의 complexity도 매우 중요하다.

#모델 비교 방법2: 실제데이터와 피팅된 데이터 상관관계 확인
cor(x.ts, ar1.ma1.md$fitted)
cor(x.ts, ar2.ma1.md$fitted) 
cor(x.ts, ar2.ma2.md$fitted) #얘가 가장 비슷. 그러나 두번째 모델과 큰 차이 없으므로 두번째 모델 선택

ar2.ma1.md$coef
#x.ts = arima.sim(list(ar=c(0.8, -0.4), ma=c(0.2)), n=1000)
#처음 정의한 모델의 coefficient를 나름 비슷하게 예측함을 확인


##################### autoARIMA ########################

# week 11

# 1. 교재에서 준 예시: 좋지 않지만 일단 해보자
library(forecast)
library(data.table)
demand = fread('C:/Users/김서윤/Documents/2020 2학기 강의/응용시계열분석(임미영)/Daily_Demand_Forecasting_Orders.csv') 
demand = demand[['Banking orders (2)']]
est = auto.arima(demand, ic="aic",
                 max.p=3, max.q=9) #최대값 정해줌. 이 값 넘어가게는 order예측하지 말라는 뜻
est #est를 살펴보면 ARIMA(0,0,0) with non-zero mean 로 아무런 order가 없는 process모델. 좋지 않은 예제ㅠㅠ
plot(demand)
acf(demand) #이미 유의수준 안에 들어가있음


# 2.두 번째 데이터 사용 
plot(discoveries) #내장되어있는 데이터: 트렌드 없다 -> d=0

library(forecast)
auto.arima(discoveries, d=0, approximation=FALSE) #approximation: 근사값을 취하는 과정을 시행할지말지(시행하면 더 빨라짐)
auto.arima(discoveries, d=0, approximation=TRUE) #두가지 다 해보고 더 좋은 모델 선택
#둘 다 잘 찾음

#다양한 평가지표를 사용해보자
auto.arima(discoveries, d=0, ic="bic", approximation=FALSE)
auto.arima(discoveries, d=0, ic="aic", approximation=FALSE) #잘 못 찾음
auto.arima(discoveries, d=0, ic="aic", approximation=TRUE) #잘 찾음


# 3. 앞에서 시뮬레이션 했던 데이터를 사용해보자
set.seed(1017)
phi1 = 0.8
phi2 = -0.4
x.ts = arima.sim(list(ar=c(phi1, phi2), ma=c(0.2)), n=1000)
plot(x.ts)

auto.model = auto.arima(x.ts, max.p=3) #잘 못 찾음..
auto.model #자동화 과정이  대체적으로 좋은 모델을 찾아주긴 하지만 항상 최고 모델을 찾아주진 않는다


################ ARIMA bith rate #######################

# week 11

#실제 데이터를 사용한 ARIMA 실습

library(data.table)
birth.data <- fread('C:/Users/김서윤/Documents/2020 2학기 강의/응용시계열분석(임미영)/daily-total-female-births-CA.csv')
head(birth.data) #데이터 구조 확인(1998년 일별 여아 출생 수)

# pull out number of births column
num_births = birth.data$births #출생수(행렬)

birth.data$date <- as.Date(birth.data$date) #날짜로 바꿔줌
head(birth.data$date)

plot(num_births ~ birth.data$date, type='l',
     main='Daily total female births in CA, 1959',
     ylab="number of births"
) #대체적으로 평균 일정해보임
Box.test(num_births, lag=log(length(num_births))) #lag는 전체 데이터 개수의log로 많이 정함
# p-value = 2.088e-06 -> 매우 낮음. 트렌드가 있을 수 있다. 상관관계 있다 -> 차분 

#differencing 한 후 그래프 그려서 여전히 상관관계 있는지 확인
plot(diff(num_births) ~ birth.data$date[1:364], type='l',
     main='Differenced birth data',
     ylab="number of births"
) #아까보다 평균이 대체적으로 일정해짐
Box.test(diff(num_births), lag=log(length(diff(num_births))))
# 아까보다 p값 더 작게 나옴.. 흠... diff=0으로 두고 해야겠다 ㅠㅠ

#differencing한 결과 확인해보자
acf(diff(num_births), main='ACF of diff data', 50) # lag 1 lag 21
pacf(diff(num_births), main='PACF of diff data', 50) # lag 7까지, 20

#다음과 같이 4개 모델 가정해보고 골라보자 
model1 = arima(num_births, order=c(1,0,1)) #d=0로 두고 모델링
sse1 = sum(model1$residuals^2) #SSE구해봄
model1.test = Box.test(model1$residuals, lag=log(length(model1$residuals))) #p값 확인

model2 = arima(num_births, order=c(0,1,2))
sse2 = sum(model2$residuals^2)
model2.test = Box.test(model2$residuals, lag=log(length(model2$residuals)))

model3 = arima(num_births, order=c(7,1,1)) #pacf찍었을 때 lag=7이었으니까
sse3 = sum(model3$residuals^2)
model3.test = Box.test(model3$residuals, lag=log(length(model3$residuals)))

model4 = arima(num_births, order=c(7,1,2))
sse4 = sum(model4$residuals^2)
model4.test = Box.test(model4$residuals, lag=log(length(model4$residuals)))

#한눈에 보기 위해 데이터프레임 만듦듦
df = data.frame(row.names=c('AIC','SSE','p-value'), 
                c(model1$aic, sse1, model1.test$p.value), 
                c(model2$aic, sse2, model2.test$p.value), 
                c(model3$aic, sse3, model3.test$p.value), 
                c(model4$aic, sse4, model4.test$p.value) 
)
colnames(df) = c('arima(0,1,1)', 'arima(0,1,2)', 
                 'arima(7,1,1)', 'arima(7,1,2)')

format(df, scientific=FALSE) #scientific=FALSE : 사람이 보기 쉽게 표현해서 보여줌
# arima(0,1,1) 모델에서만 p-value 0.5971592로 낮다.  전체적으로 유의수준 넘어감을 확인
# AIC값은 arima(0,1,2)에서 가장 낮음 -> 이 모델 선택
library(astsa)
sarima(num_births, 0,1,2,0,0,0) #뒤에 3개는 신경쓰지 말고. 사리마 모델 돌려봄
#그래프 확인. 해당 모델이 데이터에 괜찮에 피팅되고 있다: acf는 유의 수준 안으로 대부분 들어옴 / p값은 유의수준 모두 넘어감


################ VAR ###########################

# week 11

# chooseCRANmirror(ind=47) 
# install.packages("vars")

library(data.table)
library(vars)
demand = fread('C:/Users/김서윤/Documents/2020 2학기 강의/응용시계열분석(임미영)/Daily_Demand_Forecasting_Orders.csv')
head(demand)

VARselect(demand[, 11:12], lag.max=4, type='const') # Banking orders (2)와 Banking orders (3)를 선택한 데이터
# type='const': 평균이 0이 아니어도 수용하겠다는 뜻
#VAR select를 통해 여기서 사용할 매개변수를 살펴볼 수 있음
#AIC=3: lag를 3까지 살펴보라는 뜻

est.var = VAR(demand[, 11:12], p=3, type='const') #lag=3로 해서 모델링
est.var

#예측값과 실제값이 얼마나 차이가 나는지 확인해보자
par(mfrow=c(2,1))
plot(demand$`Banking orders (2)`, type="l") #변수 명에 space가 있을 경우`사용
lines(fitted(est.var)[, 1], col=2) #예측된 값. 별로 좋지 않음
plot(demand$`Banking orders (3)`, type='l')
lines(fitted(est.var)[,2], col=2) # 2보다 잘 예측됨
#-> 2가 3를 leading하고 있다. 즉, 2는 3를 예측하는데 도움을 주지만 반대는 아니다

#잔차의 acf, pacf확인: 거의다 유의수준 안에 위치 -> 더이상의 상관관계는 없어보임
par(mfrow =c(2,1))
acf(demand$`Banking orders (2)` - fitted(est.var)[, 1])
acf(demand$`Banking orders (3)` - fitted(est.var)[, 2])

# 더 정확하게 테스트 해보자
serial.test(est.var, lags.pt=8, type='PT.asymptotic') #p-value = 0.4293: 유의수준 밖이다 = 잔차 correlation이 없다. 모델이 잘 예측했다.
#포트만태우 테스트
#잔차를 lag=8까지 테스트해봤을 떄 귀무가설 기각 X

######################## SARIMA simulation #############################

# week 12

# SARIMA simulation
x=NULL
z=NULL
n=10000 #데이터 개수

z=rnorm(n) #데이터 개수만큼 z 샘플링
x[1:13]=1 #우선 모두 1로 값을 채워줌

for(i in 14:n){
  x[i]<-z[i]+0.7*z[i-1]+0.6*z[i-12]+0.42*z[i-13]
} #앞은 다 1로 채우고, 14번째 부터는 주기를 갖게 정의(주기=12인 001001 MA1모델)
plot.ts(x[1:1000])

par(mfrow=c(2,1))
plot.ts(x[12:120], main='The first 10 months of simulation SARIMA(0,0,1,0,0,1)_12', ylab='') 
#MA term만 갖는 SARIMA모델, 주기는 12

acf(x, main='SARIMA(0,0,1,0,0,1)_12 Simulation') #주기를 12로 해서 유의수준 넘어가는 값 확인


####################### SARIMA ############################

# week 12

# SARIMA modeling

library(astsa)
plot(jj)

x = diff(diff(log(jj)),4) #seasonal differencing: 분산 안정화, 트렌드 제거
Box.test(x, lag=log(length(x))) #p-value = 0.0004658: 이전 시차간 자기상관 없다는 귀무가설 기각 -> AR프로세스 들어감
plot.ts(x)
acf(x) #lag=1 유의수준 접근(간결성 원칙에 따라서 0~1사이에서만 테스트 해볼 것임)
pacf(x) #lag=1 유의수준 넘어감
d=1
D = 1

#p,q,P,Q에 대해 4중 for문 돌려줌
for (p in 0:1){
  for (q in 0:1){
    for (P in 0:1){
      for (Q in 0:1){
        model<-arima(x=log(jj), order = c(p,d,q), seasonal = list(order=c(P,D,Q), period=4))
        pval<-Box.test(model$residuals, lag=log(length(model$residuals)))
        sse<-sum(model$residuals^2)
        cat(p,d,q,P, D, Q ,4, 'AIC=', model$aic, ' SSE=',sse,' p-VALUE=', pval$p.value,'\n')
      }
    }
  }
} 
#0 1 1 1 1 0 4모델이 가장 작은 AIC값 가짐
est = arima(x=log(jj), order=c(0,1,1), 
            seasonal=list(order=c(1,1,0),period=4))
est

#sarima()함수로 모델링도 가능
sarima(log(jj), 0,1,1,1,1,0,4)
# 잔차 ACF값이 유의수준 벗어나지 않음, p-value도 모두 유의수준 넘어감
#-> 잔차 간 자기상관이 없다는 자기상관 기각X. 이모델로 fix
# z의 근사값 sigma^2
#ma1, sar1에 대한 coef, 그것들의 p값(유의수준 안에 있음=significant하다)까지 확인 가능 -> 식을 만들어 보자


################# Kalman filter ##############################

#week 12

#Kalman filter 실습

ts.length = 100 #길이
a = rep(0.5, ts.length) #가속도
x = rep(0, ts.length) #시작 position
v = rep(0, ts.length) #시작 속도

#모델링
for (ts in 2:ts.length){
  x[ts] = v[ts-1]*2 +x[ts-1]+1/2*a[ts-1]^2 #Ft 위치 계산 공식
  x[ts] = x[ts] + rnorm(1, sd=20) #노이즈 더해줌
  v[ts] = v[ts-1]+2*a[ts-1] #속도 업데이트
}

par(mfrow=c(3,1))
plot(x, main='Position', type='l') #position 증가
plot(v, main='Velocity', type='l') #속도: 선형 증가
plot(a, main='Acceleration', type='l') #가속도 일정

#Filter
#필터 사용하여 실제값과 비슷하게 추정해보자
z = x+rnorm(ts.length, sd=300) #노이즈 섞어서
plot(x, ylim=range(c(x,z))) #플로팅: simulation한 y값
lines(z, col='blue') #노이즈가 있는 값 플로팅: 이 값이 우리가 앞에서 가정한 오류 가지고 있는 측정값임.

#이 노이즈가 있는 값(lien)을 필터링을 해서 최대한 실제 값과 가까운 값을 모델링 해볼 것
kalman.motion = function(z, Q, R, A, H){ #각각 모두 행렬로 정의됨
  dimstate = dim(Q)[1]
  xhatminus = array(rep(0, ts.length*dimstate), c(ts.length, dimstate)) #0으로 채워진 100차원의 행렬
  xhat = array(rep(0, ts.length*dimstate), c(ts.length, dimstate)) #추정값: 그 전단계 값*A행렬
  pminus = array(rep(0, ts.length*dimstate*dimstate), c(ts.length, dimstate, dimstate))
  P = array(rep(0, ts.length*dimstate*dimstate), c(ts.length, dimstate, dimstate))
  K = array(rep(0, ts.length*dimstate), c(ts.length, dimstate))
  
  xhat[1, ] = rep(0, dimstate)
  P[1, ,] = diag(dimstate)
  ######교안 7-1 34페이지 참고######
  for (k in 2:ts.length){ #행렬의 곱하기 연산자 %*%
    xhatminus[k, ] = A %*% matrix(xhat[k-1,]) #prediction 단계
    pminus[k, , ] = A %*% P[k-1, ,] %*% t(A) +Q #predicrion 단계
    K[k, ] = pminus[k, , ] %*% H %*% solve(t(H) %*% pminus[k, , ] %*% H+R)#Kalman gain
    xhat[k, ] = xhatminus[k, ] +K[k, ] %*% (z[k]-t(H) %*% xhatminus[k,])#Kalman gain 업데이트
    P[k, ,] = (diag(dimstate)-K[k,] %*% t(H)) %*% pminus[k, , ]#최종 상태 추정값
  }
  return(list(xhat=xhat, xhatminus=xhatminus)) #예측된 Xhat을 리턴해줌
} #칼만 필터에서 정의해준 값으로 계속해서 업데이트 해나가게 됨

R = 10^2 
Q = 10

A = matrix(1)
H  = matrix(1)
# 각각이 행렬로 정의되었고,,
xhat = kalman.motion(z, diag(1)*Q, R, A, H)[[1]] #각 값을 이렇게 넣어주고, 각각의 행렬의 dimension을 정해주어야 함
lines(xhat, col='red')
#빨강: 우리가 예측한 값
#파랑: 에러가 섞인 측정값을 사용하여 정의한 값?
#-> 실제 값과 비슷하게 예측했음을 볼 수 있음

#이 단원은 중점을 두지는 않을 것. 알고리즘이 수학적으로 어떻게 작동을 하는지 정도만 알아두어도 ㄱㅊ

####################### HMM ################################

# week 13

#Hidden Marcov Models

require(depmixS4)
set.seed(123)

# set parameters for the distribution of each of the four market states we want to represent.
# 네 가지 상태의 평균과 표준편차 미리 정의해줌
bull_mu = 0.1
bull_sd = 0.1 

neutral_mu = 0.02
neutral_sd = 0.08

bear_mu = -0.03
bear_sd = 0.2

panic_mu = -0.1
panic_sd = 0.3

# collect these parameters in vectors for easy indexing 

mus = c(bull_mu, neutral_mu, bear_mu, panic_mu)
sds = c(bull_sd, neutral_sd, bear_sd, panic_sd)

# set some constants discribing the time series we will generate 
# 매개상태가 지속되는 기간들 샘플링
NUM_PERIODS = 10 #기간 개수
SMALLEST_PERIOD = 20 #최소 지속 기간
LONGEST_PERIOD = 40 #최대 지속 기간

# stochastically determine a series of day counts with 
# each day count indicating one 'run' or one stte of the market. 
days = sample(SMALLEST_PERIOD:LONGEST_PERIOD, NUM_PERIODS, replace=TRUE)
days # days 샘플링
#해당 기간동안 어떠한 상태가 지속될 것이라는 뜻

# for each number of days in the vector of days 
# we generate a time series for that run of days in a particualr 
# state of the market and add this to our overall time series 

returns = numeric()
true.mean = numeric()
for (d in days){
  idx = sample(1:4, 1, prob=c(0.2, 0.6, 0.18, 0.02)) #4가지 상태 중 하나 선택, 각 상태의 확률
  returns = c(returns, rnorm(d, mean=mus[idx], sd=sds[idx])) #days라는 기간 내에서 상태에 따른 어떤 값들 d개 생성, 각 상태의 평균과 분포를 가지는 값
  true.mean = c(true.mean, rep(mus[idx], d)) #해당 상태의 평균값을 d만큼 rep 해서 생성
}

table(true.mean) #상태의 빈도: 각 상태에 몇 개 days가 할당되었는지 확인


## generate distribution 
hmm.model = depmix(returns~1, family=gaussian(), nstates=4, data=data.frame(returns=returns)) #모델링
#returns~1: 하나의 변수와 매치 된다는 관계
model.fitted = fit(hmm.model) #모델 피팅-> converged at iteration 357 with logLik: 265.7247 
post_prob = posterior(model.fitted) #데이터(상태 래이블)에 맞는 확률분포 생성 위함
post_prob[319,] #데이터 모두 319개였기 때문(마지막 데이터 확인). 각 상태별 확률 보여줌


# visualization 
plot(returns, type='l', lwd=2, col=1, xlab="", ylab="", ylim=c(-0.6, 0.6))
lapply(0:(length(returns)-1), function(i){
  ## add a background rectangle of the appropriate color 
  ## to indicate the state during a given time step 
  rect(i, 0.6, (i+1), 0.5, 
       col=rgb(0.0, 0.0, 0.0, alpha=(0.2 * post_prob$state[i+1])), border=NA)
})

attr(model.fitted, "response") #가정된 변수의 매개변수 살펴볼 수 있음
#각각 상태의 coef 등을 확인할 수 있다. 

################### BST ########################

# week 13

#데이터 못찾은 관계로 항공데이터 사용
require(bsts)

data(AirPassengers)

plot(AirPassengers)
y <- log(AirPassengers) #log transformation->분산 안정화
plot(y) #격차 줄어듬
#증가 트렌드, 연도별 계절성 보임(주기 12)
#따라서 구조모델에 트렌드, 연간 계절성 추가
ss <- AddLocalLinearTrend(list(), y)
ss <- AddSeasonal(ss, y, nseasons = 12)
training = window(y, end=c(1959, 12)) #train데이터로는 59년도까지 데이터만 사용하고 나머지 부분은 예측을 해보자
model = bsts(training, state.specification=ss, niter=100)#학습데이터 넣어주고, 파라미터 업데이트 100번 돌아라

plot(model, 'seasonal', nseasons=12) #각각의 season에 대해 대체적으로 안정된 값 보임
#모델링이 대체적으로 잘 맞아떨어졌다는 뜻
#이 모델로 예측을 해보자
pred = predict(model, horizon=12)#horizon에는 계절성 정해준 값 넣으면 됨
plot(pred)#추론된 값 그래프로 확인
pred#수치로 확인

