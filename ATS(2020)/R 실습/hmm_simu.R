# week 13

#Hidden Marcov Models

require(depmixS4)
set.seed(123)

# set parameters for the distribution of each of the four market states we want to represent.
# 네 가지 상태의 평균과 표준편차 미리 정의해줌
bull_mu = 0.1
bull_sd = 0.1 

neutral_mu = 0.02
neutral_sd = 0.08

bear_mu = -0.03
bear_sd = 0.2

panic_mu = -0.1
panic_sd = 0.3

# collect these parameters in vectors for easy indexing 

mus = c(bull_mu, neutral_mu, bear_mu, panic_mu)
sds = c(bull_sd, neutral_sd, bear_sd, panic_sd)

# set some constants discribing the time series we will generate 
# 매개상태가 지속되는 기간들 샘플링
NUM_PERIODS = 10 #기간 개수
SMALLEST_PERIOD = 20 #최소 지속 기간
LONGEST_PERIOD = 40 #최대 지속 기간

# stochastically determine a series of day counts with 
# each day count indicating one 'run' or one stte of the market. 
days = sample(SMALLEST_PERIOD:LONGEST_PERIOD, NUM_PERIODS, replace=TRUE)
days # days 샘플링
#해당 기간동안 어떠한 상태가 지속될 것이라는 뜻

# for each number of days in the vector of days 
# we generate a time series for that run of days in a particualr 
# state of the market and add this to our overall time series 

returns = numeric()
true.mean = numeric()
for (d in days){
    idx = sample(1:4, 1, prob=c(0.2, 0.6, 0.18, 0.02)) #4가지 상태 중 하나 선택, 각 상태의 확률
    returns = c(returns, rnorm(d, mean=mus[idx], sd=sds[idx])) #days라는 기간 내에서 상태에 따른 어떤 값들 d개 생성, 각 상태의 평균과 분포를 가지는 값
    true.mean = c(true.mean, rep(mus[idx], d)) #해당 상태의 평균값을 d만큼 rep 해서 생성
}

table(true.mean) #상태의 빈도: 각 상태에 몇 개 days가 할당되었는지 확인

 
## generate distribution 
hmm.model = depmix(returns~1, family=gaussian(), nstates=4, data=data.frame(returns=returns)) #모델링
#returns~1: 하나의 변수와 매치 된다는 관계
model.fitted = fit(hmm.model) #모델 피팅-> converged at iteration 357 with logLik: 265.7247 
post_prob = posterior(model.fitted) #데이터(상태 래이블)에 맞는 확률분포 생성 위함
post_prob[319,] #데이터 모두 319개였기 때문(마지막 데이터 확인). 각 상태별 확률 보여줌


# visualization 
plot(returns, type='l', lwd=2, col=1, xlab="", ylab="", ylim=c(-0.6, 0.6))
lapply(0:(length(returns)-1), function(i){
    ## add a background rectangle of the appropriate color 
    ## to indicate the state during a given time step 
    rect(i, 0.6, (i+1), 0.5, 
        col=rgb(0.0, 0.0, 0.0, alpha=(0.2 * post_prob$state[i+1])), border=NA)
})

attr(model.fitted, "response") #가정된 변수의 매개변수 살펴볼 수 있음
#각각 상태의 coef 등을 확인할 수 있다. 
