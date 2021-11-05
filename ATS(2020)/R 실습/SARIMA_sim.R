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


