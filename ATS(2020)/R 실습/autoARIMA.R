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
