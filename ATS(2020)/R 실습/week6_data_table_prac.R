#data.table 예제

require(data.table) 
mydata = fread("https://github.com/arunsrinivasan/satrdays-workshop/raw/master/flights_2014.csv")

nrow(mydata)
ncol(mydata)
names(mydata)
head(mydata)

"""
DT[i,j,by]
    1.  i refers to rows. It implies subsetting rows. It is equivalent to WHERE clause in SQL.
    2. j refers to columns. It implies subsetting columns (dropping / keeping). It is equivalent to SELECT clause in SQL.
    3. by refers to adding a group so that all calculations would be done within a group. Equivalent to SQL's GROUP BY clause.
"""
#select columns
dat1 = mydata[, origin] # vector
nrow(dat1) #벡터기때문에 null
length(dat1)
dat1 = mydata[, .(origin)] #returns a data.table(컬럼을 하나만 가지는 데이터테이블로 가져오고 싶을때)

#select rows 
dat1 = mydata[1, ] #모든 컬럼, 첫번쨰 행 추출
dat1 = mydata[1:10, ] #모든 컬럼, 1~10 행 추출
dat1 = mydata[1:10, .(origin)] #origin만 보고 싶을 떄

#keeping multiple columns 
dat3 = mydata[, .(origin, year, month, hour)]
dat4 = mydata[, c(2:4)]

dat5 = mydata[, !c("origin")] #origin 컬럼만 빼고 가져온다
dat6 = mydata[, !c("origin", "year", "month")] #이것들만 빼고 가져온다

dat3 = mydata[, .(origin, year, day, hour), by=month] #gorup by month
dat3[253300:253316]
dat3[1:10]
