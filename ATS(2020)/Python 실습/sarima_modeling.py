
import warnings
import itertools
import pandas as pd
import numpy as np
import statsmodels.api as sm
import matplotlib.pyplot as plt
#plt.style.use('fivethirtyeight')

path = "C:/Users/mia1211/Documents/Py-workspace/data/AirPassengers.csv"

df = pd.read_csv(path)
df['Month'] = pd.to_datetime(df['Month'])
print(df.head())

y = pd.Series(data=df['#Passengers'].values, index=df['Month'])
print(y.head())
log_y = np.log(y)
#log_y.plot(figsize=(15, 6))
#plt.show()

# Define the p, d and q parameters to take any value between 0 and 2
d = [1]
p = q = range(0, 3)

# Generate all different combinations of p, q and q triplets
pdq = list(itertools.product(p, d, q))

# Generate all different combinations of seasonal p, q and q triplets
seasonal_pdq = [(x[0], x[1], x[2], 12) for x in list(itertools.product(p, d, q))]

warnings.filterwarnings("ignore") # specify to ignore warning messages

# best_result = [0, 0, 10000000]
best_result = [(0, 1, 1), (1, 1, 2, 12), 825.6737919396066]
"""
for param in pdq:
    for param_seasonal in seasonal_pdq:
        try:
            model = sm.tsa.statespace.SARIMAX(y,
                                            order=param,
                                            seasonal_order=param_seasonal,
                                            enforce_stationarity=False,
                                            enforce_invertibility=False)

            results = model.fit()
            
            print('ARIMA{} x {} - AIC: {}'.format(param, param_seasonal,
                                                  results.aic))

            if results.aic < best_result[2]:
                if sum(param) + sum(param_seasonal[:-1]) <7:
                    best_result = [param, param_seasonal, results.aic]
        except:
            continue
"""    
print('\nBest Result:', best_result)
 
model = sm.tsa.statespace.SARIMAX(y,
                                order= best_result[0],
                                seasonal_order=best_result[1],
                                enforce_stationarity=False,
                                enforce_invertibility=False)

results = model.fit()
print(results.summary().tables[1])

results.plot_diagnostics(figsize=(15, 12))
#plt.show()

# Prediction 
pred = results.get_prediction(start=pd.to_datetime('1958-01-01'), dynamic=False)
pred_ci = pred.conf_int()
ax = y['1949':].plot(label='Observed', figsize=(15, 12))
pred.predicted_mean.plot(ax=ax, label='One-Step Ahead Forecast', alpha=.7)

ax.fill_between(pred_ci.index,
                pred_ci.iloc[:, 0],
                pred_ci.iloc[:, 1], color='k', alpha=.25)

ax.fill_betweenx(ax.get_ylim(), pd.to_datetime('1958-01-01'), y.index[-1],
                 alpha=.1, zorder=-1)

ax.set_xlabel('Date')
ax.set_ylabel('Airline Passengers')
plt.legend()
plt.show()


# Extract the predicted and true values of our time series
y_forecasted = pred.predicted_mean
y_truth = y['1958-01-01':]

# Compute the mean square error
mse = ((y_forecasted - y_truth) ** 2).mean()
print('The Mean Squared Error of our forecasts is {}'.format(round(mse, 2)))

