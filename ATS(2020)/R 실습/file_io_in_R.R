# week 9
# Ch06: feather 데이터 타입 실습

# chooseCRANmirror(ind=47) -- 경산시
# install.packages("feather")
library(feather)
print(mtcars) #내장 데이터 불러옴. 이걸 저장할 것임.

# mtcars data
path <- "C:/Users/김서윤/Documents/2020 2학기 강의/응용시계열분석(임미영)/R 실습/mtcars.feather"
write_feather(mtcars, path) #데이터 저장
df = read_feather(path) # 저장한 데이터 읽어들임

# RDS data 
path <- "C:/Users/김서윤/Documents/2020 2학기 강의/응용시계열분석(임미영)/R 실습/mtcars.RDS"
saveRDS(mtcars, path)
readRDS(path) #R의 기본형식이기 때문에 동일하게 저장됨
# feather는 파이썬/R 둘다 사용 가능

# 이번엔 save와 load를 사용해보자!(가장 기본적인 내장 함수)
mycars = mtcars
save(mycars, file=path)
print(load(path)) #mycars -> save와 load만 사용하면 그냥 변수 자체를 저장
#rm(mycars) #변수 삭제하고 다시 로드하고 mycars 프린트해보자
print(mycars) #데이터가 출력된다

# RData 형식
path <- "./mtcars.RData"
mycars2 = mycars
save(mycars2, file=path)
print(load(path))
print(mycars2)
rm(mycars2)
print(mycars2) # 다시 로딩 해주고 프린트하면 다시 출력된다

# rda 형식
path <- "./mtcars.rda"
mycars2 = mycars
save(mycars2, file=path)
print(load(path))
print(mycars2)