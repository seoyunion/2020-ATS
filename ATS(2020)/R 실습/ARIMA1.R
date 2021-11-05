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
