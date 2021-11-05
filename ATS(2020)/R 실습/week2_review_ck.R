data(package='faraway') #what's in faraway

data(coagulation, package='faraway') #get coagulation data from faraway package

ls() #[1] "coalgulation

coagulation
#coagulation & diet
#coag
#Blood coagulation time(혈액 응고 시간)

#diet
#Which diet they were on either A,B,C,D (식단 타입)

plot(coag~diet)#데이터 지정해주지 않아 오류 발생
plot(coag~diet, data=coagulation)

summary(coagulation)
