####week4_smoothing1####

require(data.table)
require(zoo)

AirPassengers <- fread("AirPassengers.csv")
head(AirPassengers)

#Plotting하기 위해 Time Series data로 변환(ts)
AirPassengers.ts = ts(
    data=AirPassengers$V2,
    start=as.yearmon(AirPassengers[1]$V1),  #날짜 형식으로 변환해주는 zoo 안의 함수 "as.yearmon"
    end=as.yearmon(tail(AirPassengers)[6]$V1),
    frequency=12
)


# stl(): 계절성과 트렌드를 분리해주는 함수(Loess 사용)
plot(stl(AirPassengers.ts, 'periodic'))

#s.window : "periodic" 넣어주면 평균값 취해줌(?)

#seasonal ts(계절성) vs cyclical ts(주기적)