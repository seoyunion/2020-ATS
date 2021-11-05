import pandas as pd
import matplotlib.pyplot as plt
df = pd.read_csv('./data/donations.csv')
print(df.iloc[1:4])

df.set_index(pd.to_datetime(df.timestamp), inplace=True)
print(df.iloc[1:4])
df.sort_index(inplace=True)
print(df.iloc[1:4])
df.groupby(pd.Grouper(freq='M')).amount.sum().plot()
plt.show()
