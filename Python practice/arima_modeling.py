path = 'C:/Users/김서윤/Documents/2020 2학기 강의/응용시계열분석(임미영)/Python 실습/AirPassengers (2).csv'

import pandas as pd
import numpy as np

import matplotlib.pylab as plt
from matplotlib.pylab import rcParams
from statsmodels.tsa.stattools import acf, pacf
from statsmodels.tsa.arima_model import ARIMA

rcParams['figure.figsize'] = 15, 6

air_passengers = pd.read_csv(path, header = 0, parse_dates = [0],
                             names = ['Month', 'Passengers'], index_col = 0)
print('data shape:', air_passengers.shape)


# log transformation
log_air_passengers = np.log(air_passengers.Passengers)
print(log_air_passengers[1:5])

# differencing 
log_air_passengers_diff = log_air_passengers - log_air_passengers.shift()

log_air_passengers_diff.dropna(inplace=True)
print(log_air_passengers_diff[1:5])

# get acf & pacf
lag_acf = acf(log_air_passengers_diff.values, nlags = 15,fft=False)
lag_pacf = pacf(log_air_passengers_diff.values, nlags = 15)

print('lag_acf shape:', lag_acf.shape)
print(lag_acf[:5])

print('lag_pacf shape:', lag_pacf.shape)
print(lag_pacf[:5])
def plot_acfs():
    plt.subplot(121) 
    plt.plot(lag_acf)
    plt.axhline(y=0,linestyle='--')
    plt.axhline(y=-1.96/np.sqrt(len(log_air_passengers_diff)),linestyle='--')
    plt.axhline(y=1.96/np.sqrt(len(log_air_passengers_diff)),linestyle='--')

    plt.subplot(122) 
    plt.plot(lag_pacf)
    plt.axhline(y=0,linestyle='--')
    plt.axhline(y=-1.96/np.sqrt(len(log_air_passengers_diff)),linestyle='--')
    plt.axhline(y=1.96/np.sqrt(len(log_air_passengers_diff)),linestyle='--')
    plt.show()

#plot_acfs()

def plot_model(values, color='black'):
    plt.plot(values, color=color)
    #plt.title('RSS: %.4f'% sum((values-log_air_passengers_diff)**2))

plt.plot(log_air_passengers_diff)
# ar model, fix the order as 1 according to the pacf 
model = ARIMA(log_air_passengers, order=(2, 1, 0))
results_AR = model.fit(disp=-1)
print('plotting ar...', 'AR RSS: %.4f'%
      sum((results_AR.fittedvalues-log_air_passengers_diff)**2))
plot_model(results_AR.fittedvalues, color='red')

# ma model, fix
model = ARIMA(log_air_passengers, order=(0, 1, 2))  
results_MA = model.fit(disp=-1)
print('plotting ma...', 'MA RSS: %.4f'% sum((results_MA.fittedvalues-log_air_passengers_diff)**2))
plot_model(results_MA.fittedvalues, color='pink')


# ARIMA model
model = ARIMA(log_air_passengers, order=(2, 1, 2))  
results_ARIMA = model.fit(disp=-1)
print('plotting ARIMA...', 'ARIMA RSS: %.4f'% sum((results_ARIMA.fittedvalues-log_air_passengers_diff)**2))
plot_model(results_ARIMA.fittedvalues, color='black')
#plt.show()

# predictions 
predictions_ARIMA_diff = pd.Series(results_ARIMA.fittedvalues, copy=True)
print(predictions_ARIMA_diff.head())

predictions_ARIMA_diff_cumsum = predictions_ARIMA_diff.cumsum()
print(predictions_ARIMA_diff_cumsum.head())

predictions_ARIMA_log = pd.Series(log_air_passengers.iloc[0],
                                  index=log_air_passengers.index)
predictions_ARIMA_log = predictions_ARIMA_log.add(predictions_ARIMA_diff_cumsum,fill_value=0)
predictions_ARIMA_log.head()

predictions_ARIMA = np.exp(predictions_ARIMA_log)
plt.plot(air_passengers)
plt.plot(predictions_ARIMA)
plt.show()
