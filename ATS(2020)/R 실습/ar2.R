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