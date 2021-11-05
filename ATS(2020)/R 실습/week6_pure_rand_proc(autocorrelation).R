#week6 자기상관#

##[covariance]
purely_random_process = ts(rnorm(100)) #정규분포에서 백개의 데이터포인트 생성
print(purely_random_process)

#acf: auto correlation function(자기상관함수) -> type을 지정해주지 않고 돌리면 자기상관을 구한다
acf(purely_random_process, type='covariance') #covariance라고 type을 지정해서 공분산을 구한다
(acf(purely_random_process, type='covariance')) #괄호를 씌워서 공분산 개수까지 알아본다


##[correlation]
acf(purely_random_process, 
        main='Correlogram of a purely random process ') #파란 선: 여러 학자들이 연구해 지정한 유의미한 범위
#대부분이 이 구간 안에 위치 -> 서로 다른 시점 간에 관계가 별로 없다
acf(purely_random_process, lag.max=12, #lag 지정(k=12까지 나옴)
        main='Correlogram of a purely random process ')
acf(purely_random_process, lag.max=10, plot=FALSE,#그래프를 그리고 싶지 않을 떄 plot=FALSE
        main='Correlogram of a purely random process ')#값만 나온다

(acf(purely_random_process, lag.max=10,
        main='Correlogram of a purely random process '))#괄호 씌움: 플로팅+값
