#연습

textdata <- file("#saddummy.txt", encoding="UTF-8")
logData <- readLines(textdata, encoding="UTF-8")
head(logData)
logData

#1번 재외하고 for문 돌리기
levData<-logData[[3]]
date <- substr(levData, 2,12)
#as.date
time <- substr(levData, 14,21)
text <- substr(levData, 24,-1)
data <- data.frame(date, time,text)
data
library(tidyverse)
data_t <- as_tibble(data)
data_t

df4
plot(df4)
df4[[1]]
df4lev<-df4[[1]]
age<-substr(df4lev,1,2)
gender<-substr(df4lev,3,3)
income<-substr(df4lev,4,7)
df4frame <- data.frame(age,gender,income)
library(tidyverse)
df4frame_t <- as_tibble(df4frame)
df4frame_t


########[데이터 전처리]##########

textdata <- file("data_tw.txt", encoding="UTF-8")
logData <- readLines(textdata, encoding="UTF-8")
head(logData)
logData 
#전체 데이터를 캐릭터형으로 받아옴.

log_time<-substr(logData, start=1, stop=21)
log_time_d<-data.frame(log_time)
#전체 데이터에서 날짜/시간 추출후 데이터프레임으로 저장

log_txt<-strsplit(logData, split=">")
log_txt
for (i in 1:length(log_txt)){print(log_txt[[i]][2])}
log_txt_r<-names(log_txt)
for (i in 1:length(log_txt)){log_txt_r[i]<-log_txt[[i]][2]}
log_txt_t<-data.frame(log_txt_r)
log_txt_t
#log_txt_r에 텍스트 데이터만 추출후 데이터프레임으로 저장

cdata<-cbind(log_time_d, log_txt_t)
cdata_df<-data.frame(cdata)
#시간과 텍스트를 각각의 column으로 추출한 데이터 프레임 cdata

cdata_t<-as_tibble(cdata)

cdata_t[[1]][[100]] #100번쨰 줄 시간
cdata_t[[2]][100]   #100번째 줄 텍스트
cdata[[2]][1000]    #1000번째 줄 텍스트


#########[데이터 15초 단위로 구간 나누기 + "ㅋㅋㅋㅋ" 빈도수 계산]###########

library(dplyr)

a <- cdata_t
head(a)
cdata_t$log_time

acs$group2=Hmisc::cut2(cdata_t$log_time,g=5)

cdata_t$log_time_g1=Hmisc::cut2(cdata_t$log_time,g=4)
validateGroup(cdata_t,Group1,log_time,4)


#1. 시간 읽어와
#2. 텍스트 파일을 쭉 읽어와서 특정 그룹을 컬러으로 하는 열에 저장
#3. 만약 분이 +1 된다면 다음 그룹으로 저장(분 단위로 저장): "분 위치에 있는 숫자가 달라지면"을 기준으로 해도 될 듯(아니면 60 기준으로 round 함수로 반올림)
#4. 그렇게 for 반복문 이용해서 약 300개의 그룹 만듦
#5. 각 그룹의 원소인 텍스트파일을 각각 포문 분석하여 "ㅋㅋㅋㅋ"를 포함하는 원소의 개수를 셈(if문) -> for문(모든 그룹에서 for문): 이중 반복문
#6. 각 빈도수를 세서 새로운 데이터프레임 만들고, 300개의 x 포인트를 갖는 히스토르램으로 그래프 표현



head(time)
#채팅 로그 날짜/시간 time변수에 정수로 받기 

log_txt<-strsplit(logData, split=">") 
log_txt_r<-names(log_txt)
for (i in 1:length(log_txt)){log_txt_r[i]<-log_txt[[i]][2]}
log_txt_t<-data.frame(log_txt_r)
head(log_txt_t)
#log_txt_r에 텍스트 데이터만 추출후 데이터프레임으로 저장

cdata<-cbind(time, log_txt_t)
colnames(cdata)<-c("time","txt")
#열이름 추가 
cdata_df<-data.frame(cdata)
#시간과 텍스트를 각각의 column으로 추출한 데이터 프레임 cdata_df
cdata_t<-as_tibble(cdata)
#cdata를 tibble형태로 변환한 cdata_t
head(cdata_t)

#count ㅋ
numk<-str_count(cdata$txt, "ㅋ")
numk_g<-ggplot(data=cdata,mapping=aes(x=time,y=numk))+
  geom_point()+
  geom_smooth()


#####구간 나누기(11-12)####
#hour==11 구간나누기
p106<-div_t$hour=='11'&div_t$min=='0'
p107<-div_t$hour=='11'&div_t$min=='1'
p108<-div_t$hour=='11'&div_t$min=='2'
p109<-div_t$hour=='11'&div_t$min=='3'
p110<-div_t$hour=='11'&div_t$min=='4'
p111<-div_t$hour=='11'&div_t$min=='5'
p112<-div_t$hour=='11'&div_t$min=='6'
p113<-div_t$hour=='11'&div_t$min=='7'
p114<-div_t$hour=='11'&div_t$min=='8'
p115<-div_t$hour=='11'&div_t$min=='9'
p116<-div_t$hour=='11'&div_t$min=='10'
p117<-div_t$hour=='11'&div_t$min=='11'
p118<-div_t$hour=='11'&div_t$min=='12'
p119<-div_t$hour=='11'&div_t$min=='13'
p120<-div_t$hour=='11'&div_t$min=='14'
p121<-div_t$hour=='11'&div_t$min=='15'
p122<-div_t$hour=='11'&div_t$min=='16'
p123<-div_t$hour=='11'&div_t$min=='17'
p124<-div_t$hour=='11'&div_t$min=='18'
p125<-div_t$hour=='11'&div_t$min=='19'
p126<-div_t$hour=='11'&div_t$min=='20'
p127<-div_t$hour=='11'&div_t$min=='21'
p128<-div_t$hour=='11'&div_t$min=='22'
p129<-div_t$hour=='11'&div_t$min=='23'
p130<-div_t$hour=='11'&div_t$min=='24'
p131<-div_t$hour=='11'&div_t$min=='25'
p132<-div_t$hour=='11'&div_t$min=='26'
p133<-div_t$hour=='11'&div_t$min=='27'
p134<-div_t$hour=='11'&div_t$min=='28'
p135<-div_t$hour=='11'&div_t$min=='29'
p136<-div_t$hour=='11'&div_t$min=='30'
p137<-div_t$hour=='11'&div_t$min=='31'
p138<-div_t$hour=='11'&div_t$min=='32'
p139<-div_t$hour=='11'&div_t$min=='33'
p140<-div_t$hour=='11'&div_t$min=='34'
p141<-div_t$hour=='11'&div_t$min=='35'
p142<-div_t$hour=='11'&div_t$min=='36'
p143<-div_t$hour=='11'&div_t$min=='37'
p144<-div_t$hour=='11'&div_t$min=='38'
p145<-div_t$hour=='11'&div_t$min=='39'
p146<-div_t$hour=='11'&div_t$min=='40'
p147<-div_t$hour=='11'&div_t$min=='41'
p148<-div_t$hour=='11'&div_t$min=='42'
p149<-div_t$hour=='11'&div_t$min=='43'
p150<-div_t$hour=='11'&div_t$min=='44'
p151<-div_t$hour=='11'&div_t$min=='45'
p152<-div_t$hour=='11'&div_t$min=='46'
p153<-div_t$hour=='11'&div_t$min=='47'
p154<-div_t$hour=='11'&div_t$min=='48'
p155<-div_t$hour=='11'&div_t$min=='49'
p156<-div_t$hour=='11'&div_t$min=='50'
p157<-div_t$hour=='11'&div_t$min=='51'
p158<-div_t$hour=='11'&div_t$min=='52'
p159<-div_t$hour=='11'&div_t$min=='53'
p160<-div_t$hour=='11'&div_t$min=='54'
p161<-div_t$hour=='11'&div_t$min=='55'
p162<-div_t$hour=='11'&div_t$min=='56'
p163<-div_t$hour=='11'&div_t$min=='57'
p164<-div_t$hour=='11'&div_t$min=='58'
p165<-div_t$hour=='11'&div_t$min=='59'

#hour==12 구간 나누기 
p166<-div_t$hour=='12'&div_t$min=='00'
p167<-div_t$hour=='12'&div_t$min=='01'
p168<-div_t$hour=='12'&div_t$min=='02'
p169<-div_t$hour=='12'&div_t$min=='03'
p170<-div_t$hour=='12'&div_t$min=='04'
p171<-div_t$hour=='12'&div_t$min=='05'
p172<-div_t$hour=='12'&div_t$min=='06'
p173<-div_t$hour=='12'&div_t$min=='07'
p174<-div_t$hour=='12'&div_t$min=='08'
p175<-div_t$hour=='12'&div_t$min=='09'
p176<-div_t$hour=='12'&div_t$min=='10'
p177<-div_t$hour=='12'&div_t$min=='11'
p178<-div_t$hour=='12'&div_t$min=='12'
p179<-div_t$hour=='12'&div_t$min=='13'
p180<-div_t$hour=='12'&div_t$min=='14'
p181<-div_t$hour=='12'&div_t$min=='15'
p182<-div_t$hour=='12'&div_t$min=='16'
p183<-div_t$hour=='12'&div_t$min=='17'
p184<-div_t$hour=='12'&div_t$min=='18'
p185<-div_t$hour=='12'&div_t$min=='19'
p186<-div_t$hour=='12'&div_t$min=='20'
p187<-div_t$hour=='12'&div_t$min=='21'
p188<-div_t$hour=='12'&div_t$min=='22'
p189<-div_t$hour=='12'&div_t$min=='23'
p190<-div_t$hour=='12'&div_t$min=='24'
p191<-div_t$hour=='12'&div_t$min=='25'
p192<-div_t$hour=='12'&div_t$min=='26'
p193<-div_t$hour=='12'&div_t$min=='27'
p194<-div_t$hour=='12'&div_t$min=='28'
p195<-div_t$hour=='12'&div_t$min=='29'
p196<-div_t$hour=='12'&div_t$min=='30'
p197<-div_t$hour=='12'&div_t$min=='31'
p198<-div_t$hour=='12'&div_t$min=='32'
p199<-div_t$hour=='12'&div_t$min=='33'
p200<-div_t$hour=='12'&div_t$min=='34'
p201<-div_t$hour=='12'&div_t$min=='35'
p202<-div_t$hour=='12'&div_t$min=='36'
p203<-div_t$hour=='12'&div_t$min=='37'
p204<-div_t$hour=='12'&div_t$min=='38'
p205<-div_t$hour=='12'&div_t$min=='39'
p206<-div_t$hour=='12'&div_t$min=='40'
p207<-div_t$hour=='12'&div_t$min=='41'
p208<-div_t$hour=='12'&div_t$min=='42'
p209<-div_t$hour=='12'&div_t$min=='43'
p210<-div_t$hour=='12'&div_t$min=='44'
p211<-div_t$hour=='12'&div_t$min=='45'
p212<-div_t$hour=='12'&div_t$min=='46'
p213<-div_t$hour=='12'&div_t$min=='47'
p214<-div_t$hour=='12'&div_t$min=='48'
p215<-div_t$hour=='12'&div_t$min=='49'
p216<-div_t$hour=='12'&div_t$min=='50'
p217<-div_t$hour=='12'&div_t$min=='51'
p218<-div_t$hour=='12'&div_t$min=='52'
p219<-div_t$hour=='12'&div_t$min=='53'
p220<-div_t$hour=='12'&div_t$min=='54'
p221<-div_t$hour=='12'&div_t$min=='55'
p222<-div_t$hour=='12'&div_t$min=='56'
p223<-div_t$hour=='12'&div_t$min=='57'
p224<-div_t$hour=='12'&div_t$min=='58'
p225<-div_t$hour=='12'&div_t$min=='59'

sec<-c(p106,p107,p108,p109,p110,p111,p112,p113,p114,p115,p116,p117,p118,p119,p120,p121,p122,p123,p124,p125,p126,p127,p128,p129,p130,p131,p132,p133,p134,p135,p136,p137,p138,p139,p140,p141,p142,p143,p144,p145,p146,p147,p148,p149,p150,p151,p152,p153,p154,p155,p156,p157,p158,p159,p160,p161,p162,p163,p164,p165,p166,p167,p168,p169,p170,p171,p172,p173,p174,p175,p176,p177,p178,p179,p180,p181,p182,p183,p184,p185,p186,p187,p188,p189,p190,p191,p192,p193,p194,p195,p196,p197,p198,p199,p200,p201,p202,p203,p204,p205,p206,p207,p208,p209,p210,p211,p212,p213,p214,p215,p216,p217,p218,p219,p220,p221,p222,p223,p224,p225)
res<-cbind(sec,numk)
res_d<-data.frame(res)
head(res)



######최종 시각화 코드###

textdata <- file("data.txt", encoding="UTF-8")
logData <- readLines(textdata, encoding="UTF-8")
head(logData)
#전체 데이터를 캐릭터형으로 받아옴.

library(tidyverse)

log_time<-substr(logData, start=13, stop=20)
h<-substr(logData, start=13, stop=14)
m<-substr(logData, start=16, stop=17)
s<-substr(logData, start=19, stop=20)
h_d<-data.frame(h)
m_d<-data.frame(m)
s_d<-data.frame(s)
#전체 데이터에서 시간을 h/m/s 별로 추출후 각각 데이터프레임(*_d)으로 저장

log_txt<-strsplit(logData, split=">")
txt<-names(txt)
for (i in 1:length(log_txt)){txt[i]<-log_txt[[i]][2]}
#텍스트만 추출하여 저장한 txt 변수 
numk<-str_count(txt, "ㅋ")
#텍스트 한줄 별"ㅋ"개수 세기

data1<-cbind(h,m,numk)
data2<-data.frame(data1)
data09<-data2[data2$h=="09",]
data10<-data2[data2$h=="10",]
data11<-data2[data2$h=="11",]
data12<-data2[data2$h=="12",]
data13<-data2[data2$h=="13",]
data14<-data2[data2$h=="14",]

data0915<-data09[data09$m=="15",]
data0916<-data09[data09$m=="16",]
data0917<-data09[data09$m=="17",]
data0918<-data09[data09$m=="18",]
data0919<-data09[data09$m=="19",]
data0920<-data09[data09$m=="20",]
data0921<-data09[data09$m=="21",]
data0922<-data09[data09$m=="22",]
data0923<-data09[data09$m=="23",]
data0924<-data09[data09$m=="24",]
data0925<-data09[data09$m=="25",]
data0926<-data09[data09$m=="26",]
data0927<-data09[data09$m=="27",]
data0928<-data09[data09$m=="28",]
data0929<-data09[data09$m=="29",]
data0930<-data09[data09$m=="30",]
data0931<-data09[data09$m=="31",]
data0932<-data09[data09$m=="32",]
data0933<-data09[data09$m=="33",]
data0934<-data09[data09$m=="34",]
data0935<-data09[data09$m=="35",]
data0936<-data09[data09$m=="36",]
data0937<-data09[data09$m=="37",]
data0938<-data09[data09$m=="38",]
data0939<-data09[data09$m=="39",]
data0940<-data09[data09$m=="40",]
data0941<-data09[data09$m=="41",]
data0942<-data09[data09$m=="42",]
data0943<-data09[data09$m=="43",]
data0944<-data09[data09$m=="44",]
data0945<-data09[data09$m=="45",]
data0946<-data09[data09$m=="46",]
data0947<-data09[data09$m=="47",]
data0948<-data09[data09$m=="48",]
data0949<-data09[data09$m=="49",]
data0950<-data09[data09$m=="50",]
data0951<-data09[data09$m=="51",]
data0952<-data09[data09$m=="52",]
data0953<-data09[data09$m=="53",]
data0954<-data09[data09$m=="54",]
data0955<-data09[data09$m=="55",]
data0956<-data09[data09$m=="56",]
data0957<-data09[data09$m=="57",]
data0958<-data09[data09$m=="58",]
data0959<-data09[data09$m=="59",]

k9<-c(sum(as.numeric(data0915$numk), na.rm=TRUE),
      sum(as.numeric(data0916$numk), na.rm=TRUE), 
      sum(as.numeric(data0917$numk), na.rm=TRUE),
      sum(as.numeric(data0918$numk), na.rm=TRUE),
      sum(as.numeric(data0919$numk), na.rm=TRUE),
      sum(as.numeric(data0920$numk), na.rm=TRUE),
      sum(as.numeric(data0921$numk), na.rm=TRUE),
      sum(as.numeric(data0922$numk), na.rm=TRUE),
      sum(as.numeric(data0923$numk), na.rm=TRUE),
      sum(as.numeric(data0924$numk), na.rm=TRUE),
      sum(as.numeric(data0925$numk), na.rm=TRUE),
      sum(as.numeric(data0926$numk), na.rm=TRUE),
      sum(as.numeric(data0927$numk), na.rm=TRUE),
      sum(as.numeric(data0928$numk), na.rm=TRUE),
      sum(as.numeric(data0929$numk), na.rm=TRUE),
      sum(as.numeric(data0930$numk), na.rm=TRUE),
      sum(as.numeric(data0931$numk), na.rm=TRUE),
      sum(as.numeric(data0932$numk), na.rm=TRUE),
      sum(as.numeric(data0933$numk), na.rm=TRUE),
      sum(as.numeric(data0934$numk), na.rm=TRUE),
      sum(as.numeric(data0935$numk), na.rm=TRUE),
      sum(as.numeric(data0936$numk), na.rm=TRUE),
      sum(as.numeric(data0937$numk), na.rm=TRUE),
      sum(as.numeric(data0938$numk), na.rm=TRUE),
      sum(as.numeric(data0939$numk), na.rm=TRUE),
      sum(as.numeric(data0940$numk), na.rm=TRUE),
      sum(as.numeric(data0941$numk), na.rm=TRUE),
      sum(as.numeric(data0942$numk), na.rm=TRUE),
      sum(as.numeric(data0943$numk), na.rm=TRUE),
      sum(as.numeric(data0944$numk), na.rm=TRUE),
      sum(as.numeric(data0945$numk), na.rm=TRUE),
      sum(as.numeric(data0946$numk), na.rm=TRUE),
      sum(as.numeric(data0947$numk), na.rm=TRUE),
      sum(as.numeric(data0948$numk), na.rm=TRUE),
      sum(as.numeric(data0949$numk), na.rm=TRUE),
      sum(as.numeric(data0950$numk), na.rm=TRUE),
      sum(as.numeric(data0951$numk), na.rm=TRUE),
      sum(as.numeric(data0952$numk), na.rm=TRUE),
      sum(as.numeric(data0953$numk), na.rm=TRUE),
      sum(as.numeric(data0954$numk), na.rm=TRUE),
      sum(as.numeric(data0955$numk), na.rm=TRUE),
      sum(as.numeric(data0956$numk), na.rm=TRUE),
      sum(as.numeric(data0957$numk), na.rm=TRUE),
      sum(as.numeric(data0958$numk), na.rm=TRUE),
      sum(as.numeric(data0959$numk), na.rm=TRUE))
k9
t9<-c(00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,24,25,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59)
kk9<-cbind(t9, k9)
g9<-ggplot(data.frame(kk9), aes(x=t9, y=k9))+geom_line()
g9


data1000<-data10[data10$m=="00",]
data1001<-data10[data10$m=="01",]
data1002<-data10[data10$m=="02",]
data1003<-data10[data10$m=="03",]
data1004<-data10[data10$m=="04",]
data1005<-data10[data10$m=="05",]
data1006<-data10[data10$m=="06",]
data1007<-data10[data10$m=="07",]
data1008<-data10[data10$m=="08",]
data1009<-data10[data10$m=="09",]
data1010<-data10[data10$m=="10",]
data1011<-data10[data10$m=="11",]
data1012<-data10[data10$m=="12",]
data1013<-data10[data10$m=="13",]
data1014<-data10[data10$m=="14",]
data1015<-data10[data10$m=="15",]
data1016<-data10[data10$m=="16",]
data1017<-data10[data10$m=="17",]
data1018<-data10[data10$m=="18",]
data1019<-data10[data10$m=="19",]
data1020<-data10[data10$m=="20",]
data1021<-data10[data10$m=="21",]
data1022<-data10[data10$m=="22",]
data1023<-data10[data10$m=="23",]
data1024<-data10[data10$m=="24",]
data1025<-data10[data10$m=="25",]
data1026<-data10[data10$m=="26",]
data1027<-data10[data10$m=="27",]
data1028<-data10[data10$m=="28",]
data1029<-data10[data10$m=="29",]
data1030<-data10[data10$m=="30",]
data1031<-data10[data10$m=="31",]
data1032<-data10[data10$m=="32",]
data1033<-data10[data10$m=="33",]
data1034<-data10[data10$m=="34",]
data1035<-data10[data10$m=="35",]
data1036<-data10[data10$m=="36",]
data1037<-data10[data10$m=="37",]
data1038<-data10[data10$m=="38",]
data1039<-data10[data10$m=="39",]
data1040<-data10[data10$m=="40",]
data1041<-data10[data10$m=="41",]
data1042<-data10[data10$m=="42",]
data1043<-data10[data10$m=="43",]
data1044<-data10[data10$m=="44",]
data1045<-data10[data10$m=="45",]
data1046<-data10[data10$m=="46",]
data1047<-data10[data10$m=="47",]
data1048<-data10[data10$m=="48",]
data1049<-data10[data10$m=="49",]
data1050<-data10[data10$m=="50",]
data1051<-data10[data10$m=="51",]
data1052<-data10[data10$m=="52",]
data1053<-data10[data10$m=="53",]
data1054<-data10[data10$m=="54",]
data1055<-data10[data10$m=="55",]
data1056<-data10[data10$m=="56",]
data1057<-data10[data10$m=="57",]
data1058<-data10[data10$m=="58",]
data1059<-data10[data10$m=="59",]

k10<-c(sum(as.numeric(data1000$numk), na.rm=TRUE),
       sum(as.numeric(data1001$numk), na.rm=TRUE),
       sum(as.numeric(data1002$numk), na.rm=TRUE),
       sum(as.numeric(data1003$numk), na.rm=TRUE),
       sum(as.numeric(data1004$numk), na.rm=TRUE),
       sum(as.numeric(data1005$numk), na.rm=TRUE),
       sum(as.numeric(data1006$numk), na.rm=TRUE),
       sum(as.numeric(data1007$numk), na.rm=TRUE),
       sum(as.numeric(data1008$numk), na.rm=TRUE),
       sum(as.numeric(data1009$numk), na.rm=TRUE),
       sum(as.numeric(data1010$numk), na.rm=TRUE),
       sum(as.numeric(data1011$numk), na.rm=TRUE),
       sum(as.numeric(data1012$numk), na.rm=TRUE),
       sum(as.numeric(data1013$numk), na.rm=TRUE),
       sum(as.numeric(data1014$numk), na.rm=TRUE),
       sum(as.numeric(data1015$numk), na.rm=TRUE),
       sum(as.numeric(data1016$numk), na.rm=TRUE), 
       sum(as.numeric(data1017$numk), na.rm=TRUE),
       sum(as.numeric(data1018$numk), na.rm=TRUE),
       sum(as.numeric(data1019$numk), na.rm=TRUE),
       sum(as.numeric(data1020$numk), na.rm=TRUE),
       sum(as.numeric(data1021$numk), na.rm=TRUE),
       sum(as.numeric(data1022$numk), na.rm=TRUE),
       sum(as.numeric(data1023$numk), na.rm=TRUE),
       sum(as.numeric(data1024$numk), na.rm=TRUE),
       sum(as.numeric(data1025$numk), na.rm=TRUE),
       sum(as.numeric(data1026$numk), na.rm=TRUE),
       sum(as.numeric(data1027$numk), na.rm=TRUE),
       sum(as.numeric(data1028$numk), na.rm=TRUE),
       sum(as.numeric(data1029$numk), na.rm=TRUE),
       sum(as.numeric(data1030$numk), na.rm=TRUE),
       sum(as.numeric(data1031$numk), na.rm=TRUE),
       sum(as.numeric(data1032$numk), na.rm=TRUE),
       sum(as.numeric(data1033$numk), na.rm=TRUE),
       sum(as.numeric(data1034$numk), na.rm=TRUE),
       sum(as.numeric(data1035$numk), na.rm=TRUE),
       sum(as.numeric(data1036$numk), na.rm=TRUE),
       sum(as.numeric(data1037$numk), na.rm=TRUE),
       sum(as.numeric(data1038$numk), na.rm=TRUE),
       sum(as.numeric(data1039$numk), na.rm=TRUE),
       sum(as.numeric(data1040$numk), na.rm=TRUE),
       sum(as.numeric(data1041$numk), na.rm=TRUE),
       sum(as.numeric(data1042$numk), na.rm=TRUE),
       sum(as.numeric(data1043$numk), na.rm=TRUE),
       sum(as.numeric(data1044$numk), na.rm=TRUE),
       sum(as.numeric(data1045$numk), na.rm=TRUE),
       sum(as.numeric(data1046$numk), na.rm=TRUE),
       sum(as.numeric(data1047$numk), na.rm=TRUE),
       sum(as.numeric(data1048$numk), na.rm=TRUE),
       sum(as.numeric(data1049$numk), na.rm=TRUE),
       sum(as.numeric(data1050$numk), na.rm=TRUE),
       sum(as.numeric(data1051$numk), na.rm=TRUE),
       sum(as.numeric(data1052$numk), na.rm=TRUE),
       sum(as.numeric(data1053$numk), na.rm=TRUE),
       sum(as.numeric(data1054$numk), na.rm=TRUE),
       sum(as.numeric(data1055$numk), na.rm=TRUE),
       sum(as.numeric(data1056$numk), na.rm=TRUE),
       sum(as.numeric(data1057$numk), na.rm=TRUE),
       sum(as.numeric(data1058$numk), na.rm=TRUE),
       sum(as.numeric(data1059$numk), na.rm=TRUE))

k10
t10<-c(00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,24,25,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59)
kk10<-cbind(t10, k10)
g10<-ggplot(data.frame(kk10), aes(x=t10, y=k10))+geom_line()
g10

data1100<-data11[data11$m=="00",]
data1101<-data11[data11$m=="01",]
data1102<-data11[data11$m=="02",]
data1103<-data11[data11$m=="03",]
data1104<-data11[data11$m=="04",]
data1105<-data11[data11$m=="05",]
data1106<-data11[data11$m=="06",]
data1107<-data11[data11$m=="07",]
data1108<-data11[data11$m=="08",]
data1109<-data11[data11$m=="09",]
data1110<-data11[data11$m=="10",]
data1111<-data11[data11$m=="11",]
data1112<-data11[data11$m=="12",]
data1113<-data11[data11$m=="13",]
data1114<-data11[data11$m=="14",]
data1115<-data11[data11$m=="15",]
data1116<-data11[data11$m=="16",]
data1117<-data11[data11$m=="17",]
data1118<-data11[data11$m=="18",]
data1119<-data11[data11$m=="19",]
data1120<-data11[data11$m=="20",]
data1121<-data11[data11$m=="21",]
data1122<-data11[data11$m=="22",]
data1123<-data11[data11$m=="23",]
data1124<-data11[data11$m=="24",]
data1125<-data11[data11$m=="25",]
data1126<-data11[data11$m=="26",]
data1127<-data11[data11$m=="27",]
data1128<-data11[data11$m=="28",]
data1129<-data11[data11$m=="29",]
data1130<-data11[data11$m=="30",]
data1131<-data11[data11$m=="31",]
data1132<-data11[data11$m=="32",]
data1133<-data11[data11$m=="33",]
data1134<-data11[data11$m=="34",]
data1135<-data11[data11$m=="35",]
data1136<-data11[data11$m=="36",]
data1137<-data11[data11$m=="37",]
data1138<-data11[data11$m=="38",]
data1139<-data11[data11$m=="39",]
data1140<-data11[data11$m=="40",]
data1141<-data11[data11$m=="41",]
data1142<-data11[data11$m=="42",]
data1143<-data11[data11$m=="43",]
data1144<-data11[data11$m=="44",]
data1145<-data11[data11$m=="45",]
data1146<-data11[data11$m=="46",]
data1147<-data11[data11$m=="47",]
data1148<-data11[data11$m=="48",]
data1149<-data11[data11$m=="49",]
data1150<-data11[data11$m=="50",]
data1151<-data11[data11$m=="51",]
data1152<-data11[data11$m=="52",]
data1153<-data11[data11$m=="53",]
data1154<-data11[data11$m=="54",]
data1155<-data11[data11$m=="55",]
data1156<-data11[data11$m=="56",]
data1157<-data11[data11$m=="57",]
data1158<-data11[data11$m=="58",]
data1159<-data11[data11$m=="59",]

k11<-c(sum(as.numeric(data1100$numk), na.rm=TRUE),
       sum(as.numeric(data1101$numk), na.rm=TRUE),
       sum(as.numeric(data1102$numk), na.rm=TRUE),
       sum(as.numeric(data1103$numk), na.rm=TRUE),
       sum(as.numeric(data1104$numk), na.rm=TRUE),
       sum(as.numeric(data1105$numk), na.rm=TRUE),
       sum(as.numeric(data1106$numk), na.rm=TRUE),
       sum(as.numeric(data1107$numk), na.rm=TRUE),
       sum(as.numeric(data1108$numk), na.rm=TRUE),
       sum(as.numeric(data1109$numk), na.rm=TRUE),
       sum(as.numeric(data1110$numk), na.rm=TRUE),
       sum(as.numeric(data1111$numk), na.rm=TRUE),
       sum(as.numeric(data1112$numk), na.rm=TRUE),
       sum(as.numeric(data1113$numk), na.rm=TRUE),
       sum(as.numeric(data1114$numk), na.rm=TRUE),
       sum(as.numeric(data1115$numk), na.rm=TRUE),
       sum(as.numeric(data1116$numk), na.rm=TRUE), 
       sum(as.numeric(data1117$numk), na.rm=TRUE),
       sum(as.numeric(data1118$numk), na.rm=TRUE),
       sum(as.numeric(data1119$numk), na.rm=TRUE),
       sum(as.numeric(data1120$numk), na.rm=TRUE),
       sum(as.numeric(data1121$numk), na.rm=TRUE),
       sum(as.numeric(data1122$numk), na.rm=TRUE),
       sum(as.numeric(data1123$numk), na.rm=TRUE),
       sum(as.numeric(data1124$numk), na.rm=TRUE),
       sum(as.numeric(data1125$numk), na.rm=TRUE),
       sum(as.numeric(data1126$numk), na.rm=TRUE),
       sum(as.numeric(data1127$numk), na.rm=TRUE),
       sum(as.numeric(data1128$numk), na.rm=TRUE),
       sum(as.numeric(data1129$numk), na.rm=TRUE),
       sum(as.numeric(data1130$numk), na.rm=TRUE),
       sum(as.numeric(data1131$numk), na.rm=TRUE),
       sum(as.numeric(data1132$numk), na.rm=TRUE),
       sum(as.numeric(data1133$numk), na.rm=TRUE),
       sum(as.numeric(data1134$numk), na.rm=TRUE),
       sum(as.numeric(data1135$numk), na.rm=TRUE),
       sum(as.numeric(data1136$numk), na.rm=TRUE),
       sum(as.numeric(data1137$numk), na.rm=TRUE),
       sum(as.numeric(data1138$numk), na.rm=TRUE),
       sum(as.numeric(data1139$numk), na.rm=TRUE),
       sum(as.numeric(data1140$numk), na.rm=TRUE),
       sum(as.numeric(data1141$numk), na.rm=TRUE),
       sum(as.numeric(data1142$numk), na.rm=TRUE),
       sum(as.numeric(data1143$numk), na.rm=TRUE),
       sum(as.numeric(data1144$numk), na.rm=TRUE),
       sum(as.numeric(data1145$numk), na.rm=TRUE),
       sum(as.numeric(data1146$numk), na.rm=TRUE),
       sum(as.numeric(data1147$numk), na.rm=TRUE),
       sum(as.numeric(data1148$numk), na.rm=TRUE),
       sum(as.numeric(data1149$numk), na.rm=TRUE),
       sum(as.numeric(data1150$numk), na.rm=TRUE),
       sum(as.numeric(data1151$numk), na.rm=TRUE),
       sum(as.numeric(data1152$numk), na.rm=TRUE),
       sum(as.numeric(data1153$numk), na.rm=TRUE),
       sum(as.numeric(data1154$numk), na.rm=TRUE),
       sum(as.numeric(data1155$numk), na.rm=TRUE),
       sum(as.numeric(data1156$numk), na.rm=TRUE),
       sum(as.numeric(data1157$numk), na.rm=TRUE),
       sum(as.numeric(data1158$numk), na.rm=TRUE),
       sum(as.numeric(data1159$numk), na.rm=TRUE))

k11
t11<-c(00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,24,25,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59)
kk11<-cbind(t11, k11)
g11<-ggplot(data.frame(kk11), aes(x=t11, y=k11))+geom_line()
g11


data1200<-data12[data12$m=="00",]
data1201<-data12[data12$m=="01",]
data1202<-data12[data12$m=="02",]
data1203<-data12[data12$m=="03",]
data1204<-data12[data12$m=="04",]
data1205<-data12[data12$m=="05",]
data1206<-data12[data12$m=="06",]
data1207<-data12[data12$m=="07",]
data1208<-data12[data12$m=="08",]
data1209<-data12[data12$m=="09",]
data1210<-data12[data12$m=="10",]
data1211<-data12[data12$m=="11",]
data1212<-data12[data12$m=="12",]
data1213<-data12[data12$m=="13",]
data1214<-data12[data12$m=="14",]
data1215<-data12[data12$m=="15",]
data1216<-data12[data12$m=="16",]
data1217<-data12[data12$m=="17",]
data1218<-data12[data12$m=="18",]
data1219<-data12[data12$m=="19",]
data1220<-data12[data12$m=="20",]
data1221<-data12[data12$m=="21",]
data1222<-data12[data12$m=="22",]
data1223<-data12[data12$m=="23",]
data1224<-data12[data12$m=="24",]
data1225<-data12[data12$m=="25",]
data1226<-data12[data12$m=="26",]
data1227<-data12[data12$m=="27",]
data1228<-data12[data12$m=="28",]
data1229<-data12[data12$m=="29",]
data1230<-data12[data12$m=="30",]
data1231<-data12[data12$m=="31",]
data1232<-data12[data12$m=="32",]
data1233<-data12[data12$m=="33",]
data1234<-data12[data12$m=="34",]
data1235<-data12[data12$m=="35",]
data1236<-data12[data12$m=="36",]
data1237<-data12[data12$m=="37",]
data1238<-data12[data12$m=="38",]
data1239<-data12[data12$m=="39",]
data1240<-data12[data12$m=="40",]
data1241<-data12[data12$m=="41",]
data1242<-data12[data12$m=="42",]
data1243<-data12[data12$m=="43",]
data1244<-data12[data12$m=="44",]
data1245<-data12[data12$m=="45",]
data1246<-data12[data12$m=="46",]
data1247<-data12[data12$m=="47",]
data1248<-data12[data12$m=="48",]
data1249<-data12[data12$m=="49",]
data1250<-data12[data12$m=="50",]
data1251<-data12[data12$m=="51",]
data1252<-data12[data12$m=="52",]
data1253<-data12[data12$m=="53",]
data1254<-data12[data12$m=="54",]
data1255<-data12[data12$m=="55",]
data1256<-data12[data12$m=="56",]
data1257<-data12[data12$m=="57",]
data1258<-data12[data12$m=="58",]
data1259<-data12[data12$m=="59",]

k12<-c(sum(as.numeric(data1200$numk), na.rm=TRUE),
       sum(as.numeric(data1201$numk), na.rm=TRUE),
       sum(as.numeric(data1202$numk), na.rm=TRUE),
       sum(as.numeric(data1203$numk), na.rm=TRUE),
       sum(as.numeric(data1204$numk), na.rm=TRUE),
       sum(as.numeric(data1205$numk), na.rm=TRUE),
       sum(as.numeric(data1206$numk), na.rm=TRUE),
       sum(as.numeric(data1207$numk), na.rm=TRUE),
       sum(as.numeric(data1208$numk), na.rm=TRUE),
       sum(as.numeric(data1209$numk), na.rm=TRUE),
       sum(as.numeric(data1210$numk), na.rm=TRUE),
       sum(as.numeric(data1211$numk), na.rm=TRUE),
       sum(as.numeric(data1212$numk), na.rm=TRUE),
       sum(as.numeric(data1213$numk), na.rm=TRUE),
       sum(as.numeric(data1214$numk), na.rm=TRUE),
       sum(as.numeric(data1215$numk), na.rm=TRUE),
       sum(as.numeric(data1216$numk), na.rm=TRUE), 
       sum(as.numeric(data1217$numk), na.rm=TRUE),
       sum(as.numeric(data1218$numk), na.rm=TRUE),
       sum(as.numeric(data1219$numk), na.rm=TRUE),
       sum(as.numeric(data1220$numk), na.rm=TRUE),
       sum(as.numeric(data1221$numk), na.rm=TRUE),
       sum(as.numeric(data1222$numk), na.rm=TRUE),
       sum(as.numeric(data1223$numk), na.rm=TRUE),
       sum(as.numeric(data1224$numk), na.rm=TRUE),
       sum(as.numeric(data1225$numk), na.rm=TRUE),
       sum(as.numeric(data1226$numk), na.rm=TRUE),
       sum(as.numeric(data1227$numk), na.rm=TRUE),
       sum(as.numeric(data1228$numk), na.rm=TRUE),
       sum(as.numeric(data1229$numk), na.rm=TRUE),
       sum(as.numeric(data1230$numk), na.rm=TRUE),
       sum(as.numeric(data1231$numk), na.rm=TRUE),
       sum(as.numeric(data1232$numk), na.rm=TRUE),
       sum(as.numeric(data1233$numk), na.rm=TRUE),
       sum(as.numeric(data1234$numk), na.rm=TRUE),
       sum(as.numeric(data1235$numk), na.rm=TRUE),
       sum(as.numeric(data1236$numk), na.rm=TRUE),
       sum(as.numeric(data1237$numk), na.rm=TRUE),
       sum(as.numeric(data1238$numk), na.rm=TRUE),
       sum(as.numeric(data1239$numk), na.rm=TRUE),
       sum(as.numeric(data1240$numk), na.rm=TRUE),
       sum(as.numeric(data1241$numk), na.rm=TRUE),
       sum(as.numeric(data1242$numk), na.rm=TRUE),
       sum(as.numeric(data1243$numk), na.rm=TRUE),
       sum(as.numeric(data1244$numk), na.rm=TRUE),
       sum(as.numeric(data1245$numk), na.rm=TRUE),
       sum(as.numeric(data1246$numk), na.rm=TRUE),
       sum(as.numeric(data1247$numk), na.rm=TRUE),
       sum(as.numeric(data1248$numk), na.rm=TRUE),
       sum(as.numeric(data1249$numk), na.rm=TRUE),
       sum(as.numeric(data1250$numk), na.rm=TRUE),
       sum(as.numeric(data1251$numk), na.rm=TRUE),
       sum(as.numeric(data1252$numk), na.rm=TRUE),
       sum(as.numeric(data1253$numk), na.rm=TRUE),
       sum(as.numeric(data1254$numk), na.rm=TRUE),
       sum(as.numeric(data1255$numk), na.rm=TRUE),
       sum(as.numeric(data1256$numk), na.rm=TRUE),
       sum(as.numeric(data1257$numk), na.rm=TRUE),
       sum(as.numeric(data1258$numk), na.rm=TRUE),
       sum(as.numeric(data1259$numk), na.rm=TRUE))

k12
t12<-c(00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,24,25,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59)
kk12<-cbind(t12, k12)
g12<-ggplot(data.frame(kk12), aes(x=t12, y=k12))+geom_line()
g12

data1300<-data13[data13$m=="00",]
data1301<-data13[data13$m=="01",]
data1302<-data13[data13$m=="02",]
data1303<-data13[data13$m=="03",]
data1304<-data13[data13$m=="04",]
data1305<-data13[data13$m=="05",]
data1306<-data13[data13$m=="06",]
data1307<-data13[data13$m=="07",]
data1308<-data13[data13$m=="08",]
data1309<-data13[data13$m=="09",]
data1310<-data13[data13$m=="10",]
data1311<-data13[data13$m=="11",]
data1312<-data13[data13$m=="12",]
data1313<-data13[data13$m=="13",]
data1314<-data13[data13$m=="14",]
data1315<-data13[data13$m=="15",]
data1316<-data13[data13$m=="16",]
data1317<-data13[data13$m=="17",]
data1318<-data13[data13$m=="18",]
data1319<-data13[data13$m=="19",]
data1320<-data13[data13$m=="20",]
data1321<-data13[data13$m=="21",]
data1322<-data13[data13$m=="22",]
data1323<-data13[data13$m=="23",]
data1324<-data13[data13$m=="24",]
data1325<-data13[data13$m=="25",]
data1326<-data13[data13$m=="26",]
data1327<-data13[data13$m=="27",]
data1328<-data13[data13$m=="28",]
data1329<-data13[data13$m=="29",]
data1330<-data13[data13$m=="30",]
data1331<-data13[data13$m=="31",]
data1332<-data13[data13$m=="32",]
data1333<-data13[data13$m=="33",]
data1334<-data13[data13$m=="34",]
data1335<-data13[data13$m=="35",]
data1336<-data13[data13$m=="36",]
data1337<-data13[data13$m=="37",]
data1338<-data13[data13$m=="38",]
data1339<-data13[data13$m=="39",]
data1340<-data13[data13$m=="40",]
data1341<-data13[data13$m=="41",]
data1342<-data13[data13$m=="42",]
data1343<-data13[data13$m=="43",]
data1344<-data13[data13$m=="44",]
data1345<-data13[data13$m=="45",]
data1346<-data13[data13$m=="46",]
data1347<-data13[data13$m=="47",]
data1348<-data13[data13$m=="48",]
data1349<-data13[data13$m=="49",]
data1350<-data13[data13$m=="50",]
data1351<-data13[data13$m=="51",]
data1352<-data13[data13$m=="52",]
data1353<-data13[data13$m=="53",]
data1354<-data13[data13$m=="54",]
data1355<-data13[data13$m=="55",]
data1356<-data13[data13$m=="56",]
data1357<-data13[data13$m=="57",]
data1358<-data13[data13$m=="58",]
data1359<-data13[data13$m=="59",]

k13<-c(sum(as.numeric(data1300$numk), na.rm=TRUE),
       sum(as.numeric(data1301$numk), na.rm=TRUE),
       sum(as.numeric(data1302$numk), na.rm=TRUE),
       sum(as.numeric(data1303$numk), na.rm=TRUE),
       sum(as.numeric(data1304$numk), na.rm=TRUE),
       sum(as.numeric(data1305$numk), na.rm=TRUE),
       sum(as.numeric(data1306$numk), na.rm=TRUE),
       sum(as.numeric(data1307$numk), na.rm=TRUE),
       sum(as.numeric(data1308$numk), na.rm=TRUE),
       sum(as.numeric(data1309$numk), na.rm=TRUE),
       sum(as.numeric(data1310$numk), na.rm=TRUE),
       sum(as.numeric(data1311$numk), na.rm=TRUE),
       sum(as.numeric(data1312$numk), na.rm=TRUE),
       sum(as.numeric(data1313$numk), na.rm=TRUE),
       sum(as.numeric(data1314$numk), na.rm=TRUE),
       sum(as.numeric(data1315$numk), na.rm=TRUE),
       sum(as.numeric(data1316$numk), na.rm=TRUE), 
       sum(as.numeric(data1317$numk), na.rm=TRUE),
       sum(as.numeric(data1318$numk), na.rm=TRUE),
       sum(as.numeric(data1319$numk), na.rm=TRUE),
       sum(as.numeric(data1320$numk), na.rm=TRUE),
       sum(as.numeric(data1321$numk), na.rm=TRUE),
       sum(as.numeric(data1322$numk), na.rm=TRUE),
       sum(as.numeric(data1323$numk), na.rm=TRUE),
       sum(as.numeric(data1324$numk), na.rm=TRUE),
       sum(as.numeric(data1325$numk), na.rm=TRUE),
       sum(as.numeric(data1326$numk), na.rm=TRUE),
       sum(as.numeric(data1327$numk), na.rm=TRUE),
       sum(as.numeric(data1328$numk), na.rm=TRUE),
       sum(as.numeric(data1329$numk), na.rm=TRUE),
       sum(as.numeric(data1330$numk), na.rm=TRUE),
       sum(as.numeric(data1331$numk), na.rm=TRUE),
       sum(as.numeric(data1332$numk), na.rm=TRUE),
       sum(as.numeric(data1333$numk), na.rm=TRUE),
       sum(as.numeric(data1334$numk), na.rm=TRUE),
       sum(as.numeric(data1335$numk), na.rm=TRUE),
       sum(as.numeric(data1336$numk), na.rm=TRUE),
       sum(as.numeric(data1337$numk), na.rm=TRUE),
       sum(as.numeric(data1338$numk), na.rm=TRUE),
       sum(as.numeric(data1339$numk), na.rm=TRUE),
       sum(as.numeric(data1340$numk), na.rm=TRUE),
       sum(as.numeric(data1341$numk), na.rm=TRUE),
       sum(as.numeric(data1342$numk), na.rm=TRUE),
       sum(as.numeric(data1343$numk), na.rm=TRUE),
       sum(as.numeric(data1344$numk), na.rm=TRUE),
       sum(as.numeric(data1345$numk), na.rm=TRUE),
       sum(as.numeric(data1346$numk), na.rm=TRUE),
       sum(as.numeric(data1347$numk), na.rm=TRUE),
       sum(as.numeric(data1348$numk), na.rm=TRUE),
       sum(as.numeric(data1349$numk), na.rm=TRUE),
       sum(as.numeric(data1350$numk), na.rm=TRUE),
       sum(as.numeric(data1351$numk), na.rm=TRUE),
       sum(as.numeric(data1352$numk), na.rm=TRUE),
       sum(as.numeric(data1353$numk), na.rm=TRUE),
       sum(as.numeric(data1354$numk), na.rm=TRUE),
       sum(as.numeric(data1355$numk), na.rm=TRUE),
       sum(as.numeric(data1356$numk), na.rm=TRUE),
       sum(as.numeric(data1357$numk), na.rm=TRUE),
       sum(as.numeric(data1358$numk), na.rm=TRUE),
       sum(as.numeric(data1359$numk), na.rm=TRUE))

k13
t13<-c(00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,24,25,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59)
kk13<-cbind(t13, k13)
g13<-ggplot(data.frame(kk13), aes(x=t13, y=k13))+geom_line()
g13



data1400<-data14[data14$m=="00",]
data1401<-data14[data14$m=="01",]
data1402<-data14[data14$m=="02",]
data1403<-data14[data14$m=="03",]
data1404<-data14[data14$m=="04",]
data1405<-data14[data14$m=="05",]
data1406<-data14[data14$m=="06",]
data1407<-data14[data14$m=="07",]
data1408<-data14[data14$m=="08",]
data1409<-data14[data14$m=="09",]
data1410<-data14[data14$m=="10",]
data1411<-data14[data14$m=="11",]
data1412<-data14[data14$m=="12",]
data1413<-data14[data14$m=="13",]
data1414<-data14[data14$m=="14",]
data1415<-data14[data14$m=="15",]
data1416<-data14[data14$m=="16",]
data1417<-data14[data14$m=="17",]
data1418<-data14[data14$m=="18",]
data1419<-data14[data14$m=="19",]
data1420<-data14[data14$m=="20",]
data1421<-data14[data14$m=="21",]
data1422<-data14[data14$m=="22",]
data1423<-data14[data14$m=="23",]
data1424<-data14[data14$m=="24",]
data1425<-data14[data14$m=="25",]
data1426<-data14[data14$m=="26",]
data1427<-data14[data14$m=="27",]
data1428<-data14[data14$m=="28",]
data1429<-data14[data14$m=="29",]
data1430<-data14[data14$m=="30",]
data1431<-data14[data14$m=="31",]
data1432<-data14[data14$m=="32",]
data1433<-data14[data14$m=="33",]
data1434<-data14[data14$m=="34",]
data1435<-data14[data14$m=="35",]
data1436<-data14[data14$m=="36",]
data1437<-data14[data14$m=="37",]
data1438<-data14[data14$m=="38",]
data1439<-data14[data14$m=="39",]
data1440<-data14[data14$m=="40",]
data1441<-data14[data14$m=="41",]
data1442<-data14[data14$m=="42",]
data1443<-data14[data14$m=="43",]
data1444<-data14[data14$m=="44",]
data1445<-data14[data14$m=="45",]
data1446<-data14[data14$m=="46",]
data1447<-data14[data14$m=="47",]
data1448<-data14[data14$m=="48",]
data1449<-data14[data14$m=="49",]
data1450<-data14[data14$m=="50",]
data1451<-data14[data14$m=="51",]
data1452<-data14[data14$m=="52",]
data1453<-data14[data14$m=="53",]
data1454<-data14[data14$m=="54",]
data1455<-data14[data14$m=="55",]
data1456<-data14[data14$m=="56",]
data1457<-data14[data14$m=="57",]
data1458<-data14[data14$m=="58",]
data1459<-data14[data14$m=="59",]

k14<-c(sum(as.numeric(data1400$numk), na.rm=TRUE),
       sum(as.numeric(data1401$numk), na.rm=TRUE),
       sum(as.numeric(data1402$numk), na.rm=TRUE),
       sum(as.numeric(data1403$numk), na.rm=TRUE),
       sum(as.numeric(data1404$numk), na.rm=TRUE),
       sum(as.numeric(data1405$numk), na.rm=TRUE),
       sum(as.numeric(data1406$numk), na.rm=TRUE),
       sum(as.numeric(data1407$numk), na.rm=TRUE),
       sum(as.numeric(data1408$numk), na.rm=TRUE),
       sum(as.numeric(data1409$numk), na.rm=TRUE),
       sum(as.numeric(data1410$numk), na.rm=TRUE),
       sum(as.numeric(data1411$numk), na.rm=TRUE),
       sum(as.numeric(data1412$numk), na.rm=TRUE),
       sum(as.numeric(data1413$numk), na.rm=TRUE),
       sum(as.numeric(data1414$numk), na.rm=TRUE),
       sum(as.numeric(data1415$numk), na.rm=TRUE),
       sum(as.numeric(data1416$numk), na.rm=TRUE), 
       sum(as.numeric(data1417$numk), na.rm=TRUE),
       sum(as.numeric(data1418$numk), na.rm=TRUE),
       sum(as.numeric(data1419$numk), na.rm=TRUE),
       sum(as.numeric(data1420$numk), na.rm=TRUE),
       sum(as.numeric(data1421$numk), na.rm=TRUE),
       sum(as.numeric(data1422$numk), na.rm=TRUE),
       sum(as.numeric(data1423$numk), na.rm=TRUE),
       sum(as.numeric(data1424$numk), na.rm=TRUE),
       sum(as.numeric(data1425$numk), na.rm=TRUE),
       sum(as.numeric(data1426$numk), na.rm=TRUE),
       sum(as.numeric(data1427$numk), na.rm=TRUE),
       sum(as.numeric(data1428$numk), na.rm=TRUE),
       sum(as.numeric(data1429$numk), na.rm=TRUE),
       sum(as.numeric(data1430$numk), na.rm=TRUE),
       sum(as.numeric(data1431$numk), na.rm=TRUE),
       sum(as.numeric(data1432$numk), na.rm=TRUE),
       sum(as.numeric(data1433$numk), na.rm=TRUE),
       sum(as.numeric(data1434$numk), na.rm=TRUE),
       sum(as.numeric(data1435$numk), na.rm=TRUE),
       sum(as.numeric(data1436$numk), na.rm=TRUE),
       sum(as.numeric(data1437$numk), na.rm=TRUE),
       sum(as.numeric(data1438$numk), na.rm=TRUE),
       sum(as.numeric(data1439$numk), na.rm=TRUE),
       sum(as.numeric(data1440$numk), na.rm=TRUE),
       sum(as.numeric(data1441$numk), na.rm=TRUE),
       sum(as.numeric(data1442$numk), na.rm=TRUE),
       sum(as.numeric(data1443$numk), na.rm=TRUE),
       sum(as.numeric(data1444$numk), na.rm=TRUE),
       sum(as.numeric(data1445$numk), na.rm=TRUE),
       sum(as.numeric(data1446$numk), na.rm=TRUE),
       sum(as.numeric(data1447$numk), na.rm=TRUE),
       sum(as.numeric(data1448$numk), na.rm=TRUE),
       sum(as.numeric(data1449$numk), na.rm=TRUE),
       sum(as.numeric(data1450$numk), na.rm=TRUE),
       sum(as.numeric(data1451$numk), na.rm=TRUE),
       sum(as.numeric(data1452$numk), na.rm=TRUE),
       sum(as.numeric(data1453$numk), na.rm=TRUE),
       sum(as.numeric(data1454$numk), na.rm=TRUE),
       sum(as.numeric(data1455$numk), na.rm=TRUE),
       sum(as.numeric(data1456$numk), na.rm=TRUE),
       sum(as.numeric(data1457$numk), na.rm=TRUE),
       sum(as.numeric(data1458$numk), na.rm=TRUE),
       sum(as.numeric(data1459$numk), na.rm=TRUE))

k14
t14<-c(00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,24,25,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59)
kk14<-cbind(t14, k14)
g14<-ggplot(data.frame(kk14), aes(x=t14, y=k14))+geom_line()


##시간별 시각화 자료 보기 
g9
g10
g11
g12
g13
g14


