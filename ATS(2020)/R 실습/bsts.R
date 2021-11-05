# week 13

#데이터 못찾은 관계로 항공데이터 사용
require(bsts)

data(AirPassengers)

plot(AirPassengers)
y <- log(AirPassengers) #log transformation->분산 안정화
plot(y) #격차 줄어듬
#증가 트렌드, 연도별 계절성 보임(주기 12)
#따라서 구조모델에 트렌드, 연간 계절성 추가
ss <- AddLocalLinearTrend(list(), y)
ss <- AddSeasonal(ss, y, nseasons = 12)
training = window(y, end=c(1959, 12)) #train데이터로는 59년도까지 데이터만 사용하고 나머지 부분은 예측을 해보자
model = bsts(training, state.specification=ss, niter=100)#학습데이터 넣어주고, 파라미터 업데이트 100번 돌아라

plot(model, 'seasonal', nseasons=12) #각각의 season에 대해 대체적으로 안정된 값 보임
#모델링이 대체적으로 잘 맞아떨어졌다는 뜻
#이 모델로 예측을 해보자
pred = predict(model, horizon=12)#horizon에는 계절성 정해준 값 넣으면 됨
plot(pred)#추론된 값 그래프로 확인
pred#수치로 확인

