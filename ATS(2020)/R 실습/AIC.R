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

