# install.packages("timevis") 

require(timevis)
require(data.table)

donations <- fread("C:/Users/김서윤/Documents/2020 2학기 강의/응용시계열분석(임미영)/ch02/donations.csv")
# https://www.rdocumentation.org/packages/data.table/versions/1.8.0/topics/data.table

####[1D Visualization]
d <- donations[, .(min(timestamp), max(timestamp)), user]
# 최소 타임스탬프부터 최대 타임스탬프까지. group_by user를 하겠다!
#처음 기부 날짜, 마지막 기부 날짜가 각 컬럼별로 나타남. user를 기준으로
names(d)<-c("content", 'start', 'end') #컬럼에 이름 넣어주기

# filter
d <- d[start != end] #star와 end가 같지 않은 것들만 필터링해서 가져옴(가입 후 한 번만 기부한 사람들 제외)
# gantt chart 
timevis(d[sample(1:nrow(d), 20)]) #1~487개의 데이터 중에서 20개를 무작위로 뽑아 샘플링 후, timevis를 찍어보겠다
#스무 명의 유저에 대한 정보 차트

####[2D Visualization]
# AIR Passengers data 
require(zoo)

ap <- fread("C:/Users/김서윤/Documents/2020 2학기 강의/응용시계열분석(임미영)/ch02/AirPassengers.csv")
ap.ts = ts(
    data=ap$V2,
    start=as.yearmon(ap[1]$V1),
    end=as.yearmon(tail(ap)[6]$V1),
    frequency=12
) #시계열 데이터로 변환

colors <- c('green', 'red', 'pink', 'blue', 'yellow', 
            'lightsalmon', 'black', 'gray', 'cyan',
            'lightblue', 'maroon', 'purple')

matplot(matrix(ap.ts,nrow=12, ncol=12), 
        type='l', col=colors, lty=1, lwd=2.5, 
        xaxt='n', ylab='Passengers Count')

legend('topleft', legend=1949:1960, lty=1, lwd=2.5,
        col=colors) #legend 함수로 label표시
#연도가 증가함에 따라 전체적 승객 수도 증가함을 확인
axis(1, at=1:12, labels=c('Jan', 'Feb', 'Mar', 'Apr', 
                        'May', 'Jun', 'Jul', 'Aug', 
                        'Sep', 'Oct', 'Nov', 'Dec'))        

###forecast 패키지 사용으로 더 쉽게 그래프 그리기
# install.packages("forecast")
require(forecast)
seasonplot(ap.ts)

months = c('Jan', 'Feb', 'Mar', 'Apr', 
            'May', 'Jun', 'Jul', 'Aug', 
            'Sep', 'Oct', 'Nov', 'Dec')

matplot(t(matrix(ap.ts,nrow=12, ncol=12)), type='l', 
            col=colors, lty=1, lwd=2.5)

legend('topleft', legend=months, col=colors, lty=1, lwd=2.5) 

monthplot(ap.ts)

#2D histogram
hist2d <-function(data, nbins.y, xlabels){
                    ymin = min(data)
                    ymax = max(data) * 1.0001
                    ybins = seq(from=ymin, to=ymax, length.out=nbins.y + 1) #y의 범위 지정. 

                    hist.matrix = matrix(0, nrow=nbins.y, ncol=ncol(data)) #히트맵. 처음엔 0으로 초기화. 
                    #print(hist.matrix)
                    
                    for (i in 1:nrow(data)){
                        ts = findInterval(data[i,], ybins)
                        for (j in 1:ncol(data)){
                            hist.matrix[ts[j], j] = hist.matrix[ts[j], j] +1 
                        }
                    }
                    print(hist.matrix)
                    }

h = hist2d(t(matrix(ap.ts, nrow=12, ncol=12)), 5, months) #몇 개 데이터 셀렉?, 무엇으로 label을 만들것이냐?
image(1:ncol(h), 1:nrow(h), t(h), col=heat.colors(5), 
        axes=FALSE, xlab="Time", ylab='Passenger Count')
