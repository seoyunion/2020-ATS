##탐색 데이터 분석##

# EU stock price data 
eu.st = EuStockMarkets
head(eu.st)
plot(eu.st)
class(eu.st) #mts:다중시계열, ts:단일시계열

frequency(eu.st) #데이터의 연간 빈도
start(eu.st) #데이터의 시작
end(eu.st) #데이터의 끝
window(eu.st, start=1997, end=1997.050) #데이터의 서브셋 뽑아낼 수 있음. 50개만 뽑음


#histogram
head(eu.st)
head(eu.st[, "SMI"])
head(diff(eu.st[, "SMI"]))

# diff() FUNCTION : 시계열 데이터셋을 변환하는 방식. 조금 더 유의미한 히스토그램 위함
# diff(c(5, 2, 10, 1, 3)) -> -3 8 -9 2: 뒤의 값에서 앞의 값을 덜어낸 값들 반환(시간의존성을 제거; 시계열 데이터의 평균 안정화)
#(첨언): 로그변환은 시계열 데이터의 분산 안정화에 도움을 준다

par(mfrow=c(2,1)) #par(mfrow=c([row], [col])): 한 패널에 히스토드램 두개를 같이 보여주는 코드
hist(eu.st[, "SMI"], 30)
hist(diff(eu.st[, "SMI"],  30))
#이 두 개 그래프가 같이 보여짐
#주식 시장은 항상 증가 추세를 보인다. 수익/손실을 파악하기 위해 differencing을 통해 추세 제거를 함.


#scatter plot
par(mfrow=c(2,1))
plot(eu.st[, 'SMI'], eu.st[, 'DAX']) #스위스 데이터와 독일 데이터의 상관관계를 살펴보자: 강력한 상관관계!
plot(diff(eu.st[, 'SMI']), diff(eu.st[, 'DAX'])) #differencing을 해도 비슷한 결과 보여줌


#spurious correlation: 가짜 상관관계; hidden varioble의 교란을 고려하지 못했을 경우
##하나의 주식 변화로다른 주식의 변화를 예측할 수 있다면 두 주식 사이에는 상관관계가 존재할 것.
plot(lag(diff(eu.st[, 'SMI']), 1), diff(eu.st[, 'DAX'])) #lag함수 이용하여 스위스 데이터 한 시점 앞으로 이동.
#진짜 상관관계가 있다면 시점이 이동한다고 해서 상관관계가 사라지지 않을 것이다.
#상관관계가 없음을 그래프를 통해 확인할 수 있다. 스위스데이터는 독일 데이터를 예측하지 않음!

# lag(_data, _#timestamps) FUNCTION : 데이터 시간순서를 앞으로 이동시킴
# ldeaths
# lag(ldeaths, 12) 데이터, 이동하려는 타임스탬프 개수

#lag함수
ldeaths
lag(ldeaths, 1)
lag(ldeaths, 12) #1년 앞으로 이동

#래그 함수 사용 실수 사례

