x=NULL
x[1]=0

for(i in 2:1000){
    x[i]=x[i-1]+rnorm(1) #rnorm(): 랜덤 변수 생성
}
head(x)
random_walk = ts(x) #time series 함수로 변환
par(mfrow=c(2,1)) #두개 그래프 그릴 것
plot(random_walk, main='A random walk', ylab=' ', 
xlab='Days',col='blue', lwd=2)


acf(random_walk)
# diff(): 이 함수를 사용해 랜덤위크에서 정상성을 갖도록 만들어보겠다(뒤의 값에서 앞의 값 덜어내는 것)
random_walk.no.tr = diff(random_walk)
plot(random_walk.no.tr)
acf(random_walk.no.tr)
