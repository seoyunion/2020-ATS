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