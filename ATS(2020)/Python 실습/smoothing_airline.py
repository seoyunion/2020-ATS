import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

air = pd.read_csv('data/AirPassengers.csv', parse_dates = True, header = None)
air.columns = ['Date', 'Passengers']

air.reindex(columns=list(air.columns)+['Smooth.1', 'Smooth.5', 'Smooth.9'], fill_value=0)
print(air.head())

air['Smooth.5'] = air.ewm(alpha=.5).mean().Passengers
air['Smooth.9'] = air.ewm(alpha=.9).mean().Passengers
air['Smooth.1'] = air.ewm(alpha=.1).mean().Passengers
print(air.head())
print(air.Passengers.mean())
print(air['Smooth.1'].mean())
print(air['Smooth.5'].mean())
print(air['Smooth.9'].mean())

# t = np.arange(pd.to_datetime('1949-01'))
air.plot()
plt.show()

