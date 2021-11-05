# rnorm(n=100, mean=0, sd=10) + [1,2,3,4,5,6,7,8,9,10] * (100/10)
x <- rnorm(n=100, mean=0, sd=10) + 1 : 10  #각 원소에 1부터 10까지 순서대로 반복해서 더해 줌
##x=NULL #3번쨰 실습 때 사용
##x[1] = rnorm(1)  #3번째 실습 떄 사용(x를 random walk로 변환)

for(i in 2:1000){
    x[i]=x[i-1]+rnorm(1)
}
mn = function(n) {rep(1/n, n)} #mn(2) -> 0.5, 0.5

# filter() function 
# a = 1:20 
# filter(a, mn(2))  -- window size: 2, base: middle

# line() : add line to the current plotting  
plot(x, type='l', lwd=1)
lines(filter(x, mn(5)), col=2, lwd=3, lty=2) #filter(x), mn(n)): n개 원소의 moving average ##window size:5
lines(filter(x, mn(50)), col='green', lwd=3, lty=3) ##window size: 50
### moving average 값을 통해 누락된 값을 채워줄 수도 있고, 스무딩을 해줄 수도 있다. 
### moving average에서 window size가 커지면, 한 번에 많은 값을 포괄하기 때문에 좀 더 평균에 가까운 값들 생성


##선형조합이 아닐 경우 filter함수 사용 불가 -> rollapply() 함수 사용
require(zoo)
# zoo() : zoo object 
# rollapply() explained in missing data imputting using MA 
# sum(w)/length(w)
f1 <- rollapply(zoo(x), 20, function(w) min(w), #x를 벡터가 아닌 zoo객체로 변환하여 rollapply적용해야 함, 함수 정의(각각의 window 내에서의 최솟값)
            align="left", partial=TRUE) #align='left': 롤링조인은 미래의 데이터포인트를 보게 됨(lookahead)-미리 주어진 데이터의 시각화이므로 룩어헤드 ok

#align="right"로 설정하면 과거의 데이터만 보기 때문에 룩어헤드 피할 수 있다(예측모델 구현할 경우)
f2 <- rollapply(zoo(x), 20, function(w) min(w), 
            align="right", partial=TRUE)
plot(x, lwd=1, type='l')
lines(f1, col=2, lwd=2, lty=2)
lines(f2, col=3, lwd=2, lty=3)


# Expending window 
# cummulated max, mean, etc.
plot(x, type='l', lwd=1)
lines(cummax(x), col=2, lwd=3, lty=2) # max
lines(cumsum(x)/1:length(x), col=3, lwd=3, lty=3) # mean : 누적평균. 시간이 지날수록 전체평균에 가까워짐

lines(rollapply(zoo(x), seq_along(x), function(w) {max(w)}, #seq_along(): 매 단계마다에서의 window size 나타냄. 단계에 따라서 window size가 하나씩 늘어나므로, cumsum, cummax와 똑같은 작용
                partial=TRUE, align='right'), 
                col='blue', lwd=3, lty=2)
lines(rollapply(zoo(x), seq_along(x), function(w) {mean(w)}, 
                partial=TRUE, align='right'), 
                col='pink', lwd=3, lty=3)
