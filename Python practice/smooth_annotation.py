import pandas as pd
# pandas 패키지를 pd로 불러온다
import numpy as np
# numpy 패키지를 np로 불러온다
import matplotlib.pyplot as plt
# matplotlib.pyplot 패키지를 plt로 불러온다

air = pd.read_csv('data/AirPassengers.csv', parse_dates = True, header = None)
# pd로 불러온 pandas 패키지의 read_csv 명령어를 이용해 csv데이터파일을 air로 받아 읽어온다
# parse_date=True: 각 컬럼을 날짜 데이터로 parsing해준다
# header = None: 파일에 컬럼명이 없거나 직접 컬럼명을 지정하고 싶을 경우 header인자를 None으로 부여하면 pandas는 자동으로 인덱스를 만들어낸다
air.columns = ['Date', 'Passengers']
# 컬럼명을 리스트로 입력해준다

air.reindex(columns=list(air.columns)+['Smooth.1', 'Smooth.5', 'Smooth.9'], fill_value=0)
# reindex 명령으로 air로 불러온 데이터파일에 컬럼명을 reindexing한다.
# list함수를 사용해 아까 컬럼명을 받았던 air.cllumns를 리스트로 만들고 ['Smooth.1', 'Smooth.5', 'Smooth.9']도 추가해 총 5개의 컬럼명을 부여해준다
# fill_value=0 명령으로 빈 값을 모두 0으로 채운다

print(air.head())
# air 데이터의 상위 5개 데이터를 출력해 확인해본다

#[지수 평활]
air['Smooth.5'] = air.ewm(alpha=.5).mean().Passengers
# 알파 값을 0.5로 한 지수 평활 값을 'Smooth.5'컬럼에 넣어준다
air['Smooth.9'] = air.ewm(alpha=.9).mean().Passengers
# 알파 값을 0.9로 한 지수 평활 값을 'Smooth.9'컬럼에 넣어준다
air['Smooth.1'] = air.ewm(alpha=.1).mean().Passengers
# 알파 값을 0.1로 한 지수 평활 값을 'Smooth.1'컬럼에 넣어준다
print(air.head())
# air 데이터의 상위 5개 데이터를 출력해 확인해본다
print(air.Passengers.mean())
# air 데이터의 Passengers 컬럼의 평균을 구해 출력한다
print(air['Smooth.1'].mean())
# air 데이터의 'Smooth.1' 컬럼의 평균을 구해 출력한다
print(air['Smooth.5'].mean())
# air 데이터의 'Smooth.5' 컬럼의 평균을 구해 출력한다
print(air['Smooth.9'].mean())
# air 데이터의 'Smooth.9' 컬럼의 평균을 구해 출력한다

# t = np.arange(pd.to_datetime('1949-01'))
air.plot()
# 완성된 air 데이터의 그래프를 그려본다
plt.show()
# 화면에 그래프를 표시하는 기능을 한다

