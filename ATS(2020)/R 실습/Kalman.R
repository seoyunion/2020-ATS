#week 12

#Kalman filter 실습

ts.length = 100 #길이
a = rep(0.5, ts.length) #가속도
x = rep(0, ts.length) #시작 position
v = rep(0, ts.length) #시작 속도

#모델링
for (ts in 2:ts.length){
    x[ts] = v[ts-1]*2 +x[ts-1]+1/2*a[ts-1]^2 #Ft 위치 계산 공식
    x[ts] = x[ts] + rnorm(1, sd=20) #노이즈 더해줌
    v[ts] = v[ts-1]+2*a[ts-1] #속도 업데이트
}

par(mfrow=c(3,1))
plot(x, main='Position', type='l') #position 증가
plot(v, main='Velocity', type='l') #속도: 선형 증가
plot(a, main='Acceleration', type='l') #가속도 일정

#Filter
#필터 사용하여 실제값과 비슷하게 추정해보자
z = x+rnorm(ts.length, sd=300) #노이즈 섞어서
plot(x, ylim=range(c(x,z))) #플로팅: simulation한 y값
lines(z, col='blue') #노이즈가 있는 값 플로팅: 이 값이 우리가 앞에서 가정한 오류 가지고 있는 측정값임.

#이 노이즈가 있는 값(lien)을 필터링을 해서 최대한 실제 값과 가까운 값을 모델링 해볼 것
kalman.motion = function(z, Q, R, A, H){ #각각 모두 행렬로 정의됨
    dimstate = dim(Q)[1]
    xhatminus = array(rep(0, ts.length*dimstate), c(ts.length, dimstate)) #0으로 채워진 100차원의 행렬
    xhat = array(rep(0, ts.length*dimstate), c(ts.length, dimstate)) #추정값: 그 전단계 값*A행렬
    pminus = array(rep(0, ts.length*dimstate*dimstate), c(ts.length, dimstate, dimstate))
    P = array(rep(0, ts.length*dimstate*dimstate), c(ts.length, dimstate, dimstate))
    K = array(rep(0, ts.length*dimstate), c(ts.length, dimstate))
  
    xhat[1, ] = rep(0, dimstate)
    P[1, ,] = diag(dimstate)
######교안 7-1 34페이지 참고######
    for (k in 2:ts.length){ #행렬의 곱하기 연산자 %*%
        xhatminus[k, ] = A %*% matrix(xhat[k-1,]) #prediction 단계
        pminus[k, , ] = A %*% P[k-1, ,] %*% t(A) +Q #predicrion 단계
        K[k, ] = pminus[k, , ] %*% H %*% solve(t(H) %*% pminus[k, , ] %*% H+R)#Kalman gain
        xhat[k, ] = xhatminus[k, ] +K[k, ] %*% (z[k]-t(H) %*% xhatminus[k,])#Kalman gain 업데이트
        P[k, ,] = (diag(dimstate)-K[k,] %*% t(H)) %*% pminus[k, , ]#최종 상태 추정값
    }
    return(list(xhat=xhat, xhatminus=xhatminus)) #예측된 Xhat을 리턴해줌
} #칼만 필터에서 정의해준 값으로 계속해서 업데이트 해나가게 됨

R = 10^2 
Q = 10

A = matrix(1)
H  = matrix(1)
# 각각이 행렬로 정의되었고,,
xhat = kalman.motion(z, diag(1)*Q, R, A, H)[[1]] #각 값을 이렇게 넣어주고, 각각의 행렬의 dimension을 정해주어야 함
lines(xhat, col='red')
#빨강: 우리가 예측한 값
#파랑: 에러가 섞인 측정값을 사용하여 정의한 값?
#-> 실제 값과 비슷하게 예측했음을 볼 수 있음

#이 단원은 중점을 두지는 않을 것. 알고리즘이 수학적으로 어떻게 작동을 하는지 정도만 알아두어도 ㄱㅊ