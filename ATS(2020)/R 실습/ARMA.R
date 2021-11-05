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