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
