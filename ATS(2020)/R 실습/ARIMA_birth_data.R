# week 11

#실제 데이터를 사용한 ARIMA 실습

library(data.table)
birth.data <- fread('C:/Users/김서윤/Documents/2020 2학기 강의/응용시계열분석(임미영)/daily-total-female-births-CA.csv')
head(birth.data) #데이터 구조 확인(1998년 일별 여아 출생 수)

# pull out number of births column
num_births = birth.data$births #출생수(행렬)

birth.data$date <- as.Date(birth.data$date) #날짜로 바꿔줌
head(birth.data$date)

plot(num_births ~ birth.data$date, type='l',
    main='Daily total female births in CA, 1959',
    ylab="number of births"
    ) #대체적으로 평균 일정해보임
Box.test(num_births, lag=log(length(num_births))) #lag는 전체 데이터 개수의log로 많이 정함
# p-value = 2.088e-06 -> 매우 낮음. 트렌드가 있을 수 있다. 상관관계 있다 -> 차분 

#differencing 한 후 그래프 그려서 여전히 상관관계 있는지 확인
plot(diff(num_births) ~ birth.data$date[1:364], type='l',
    main='Differenced birth data',
    ylab="number of births"
    ) #아까보다 평균이 대체적으로 일정해짐
Box.test(diff(num_births), lag=log(length(diff(num_births))))
# 아까보다 p값 더 작게 나옴.. 흠... diff=0으로 두고 해야겠다 ㅠㅠ

#differencing한 결과 확인해보자
acf(diff(num_births), main='ACF of diff data', 50) # lag 1 lag 21
pacf(diff(num_births), main='PACF of diff data', 50) # lag 7까지, 20

#다음과 같이 4개 모델 가정해보고 골라보자 
model1 = arima(num_births, order=c(1,0,1)) #d=0로 두고 모델링
sse1 = sum(model1$residuals^2) #SSE구해봄
model1.test = Box.test(model1$residuals, lag=log(length(model1$residuals))) #p값 확인

model2 = arima(num_births, order=c(0,1,2))
sse2 = sum(model2$residuals^2)
model2.test = Box.test(model2$residuals, lag=log(length(model2$residuals)))

model3 = arima(num_births, order=c(7,1,1)) #pacf찍었을 때 lag=7이었으니까
sse3 = sum(model3$residuals^2)
model3.test = Box.test(model3$residuals, lag=log(length(model3$residuals)))

model4 = arima(num_births, order=c(7,1,2))
sse4 = sum(model4$residuals^2)
model4.test = Box.test(model4$residuals, lag=log(length(model4$residuals)))

#한눈에 보기 위해 데이터프레임 만듦듦
df = data.frame(row.names=c('AIC','SSE','p-value'), 
                c(model1$aic, sse1, model1.test$p.value), 
                c(model2$aic, sse2, model2.test$p.value), 
                c(model3$aic, sse3, model3.test$p.value), 
                c(model4$aic, sse4, model4.test$p.value) 
                )
colnames(df) = c('arima(0,1,1)', 'arima(0,1,2)', 
                    'arima(7,1,1)', 'arima(7,1,2)')

format(df, scientific=FALSE) #scientific=FALSE : 사람이 보기 쉽게 표현해서 보여줌
# arima(0,1,1) 모델에서만 p-value 0.5971592로 낮다.  전체적으로 유의수준 넘어감을 확인
# AIC값은 arima(0,1,2)에서 가장 낮음 -> 이 모델 선택
library(astsa)
sarima(num_births, 0,1,2,0,0,0) #뒤에 3개는 신경쓰지 말고. 사리마 모델 돌려봄
#그래프 확인. 해당 모델이 데이터에 괜찮에 피팅되고 있다: acf는 유의 수준 안으로 대부분 들어옴 / p값은 유의수준 모두 넘어감