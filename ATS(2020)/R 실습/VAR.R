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