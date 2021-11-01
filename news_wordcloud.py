#이전 코드 불러오기
from news_crawling import *
from news_preprocessing import *

# 필요한 패키지 임포트
import inline as inline
import sys
from konlpy.tag import Okt
from collections import Counter
from wordcloud import WordCloud
import pandas as pd
import numpy as np
import os as os

import matplotlib.font_manager as fm
from matplotlib import rc
import matplotlib.pyplot as plt
#%matplotlib inline

from PIL import Image
from tqdm import tqdm

# 워드클라우드 세팅
fontpath = '/usr/share/fonts/truetype/nanum/NanumBarunGothic.ttf'
font = fm.FontProperties(fname=fontpath, size=9)
fm._rebuild()
#%config InlineBackend.figure_format = 'retina'
plt.rc('font', family='NanumBarunGothic')


