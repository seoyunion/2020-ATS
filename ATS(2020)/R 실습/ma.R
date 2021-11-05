# week 10

# Genenrate noise 
noise = rnorm(10000) #노이즈 생성

set.seed=1
model=arima.sim(n=1000, model=list(ma=c(0.5,0.5)))
acf(model)

# Introduce a va
r 
ma_2 = NULL #ma_2 정의

# Loop for generatring MA(2) : ma_2이기 떄문에 세번쨰 값부터 채워짐
for (i in 3:10000){
    ma_2[i] = noise[i] +0.5*noise[i-1]+0.5*noise[i-2] #가중치 각각 0.7, 0.2 
}

# Shift data to left by 2 units 
ma_process = ma_2[3:10000] #마찬가지로 앞의 두개 지우고 세번째 값부터 ma process 정의
head(ma_process) #값들이 정의되었음을 확인

# Put time series structure on a vanilla data
ma_process = ts(ma_process) #정의된 sequence를 시계열 데이터로 변환

# Partition output graphics as a multi frame of 2 rows and 1 col
par(mfrow=c(2,1))

# Plot the process and plot in ACF 
plot(ma_process, main = 'A MA(2) process', ylab=' ', col='blue')
acf(ma_process, main = 'Corellogram of a MA(2) process') #lag=2에서 acf값이 cutoff됨을 확인
#앞의 두 단계 노이즈까지 영향을 받는다.

