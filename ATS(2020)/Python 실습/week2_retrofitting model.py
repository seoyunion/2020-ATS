# -*- encoding: utf-8 -*-

import pandas as pd
import os
folder = './data/'
#print(os.listdir(folder))
emails = pd.read_csv(folder+'emails.csv')

complete_idx = pd.MultiIndex.from_product((set(emails.week), set(emails.user)))
all_email = emails.set_index(['week','user']).reindex(complete_idx, fill_value=0).reset_index()
all_email.columns = ['week', 'user', 'emailsOpened']

cutoff_dates = emails.groupby('user').week.agg(['min','max']).reset_index()
cutoff_dates = cutoff_dates.reset_index()

for _, row in cutoff_dates.iterrows():
    user = row['user']
    start_date = row['min']
    end_date = row['max']
    all_email.drop(all_email[all_email.user == user][all_email.week < start_date].index, inplace = True)
    all_email.drop(all_email[all_email.user == user][all_email.week > end_date].index, inplace = True)
print('email work done ... ')


donations = pd.read_csv(folder +'donations.csv')
#print(donations.head())
donations.timestamp = pd.to_datetime(donations.timestamp)
donations.set_index('timestamp', inplace = True)
agg_don = donations.groupby('user').apply(lambda df: df.amount.resample("W-MON").sum().dropna())

## HERE

merged_df = pd.DataFrame()

for user, user_email in all_email.groupby('user'):
    # print(user)
    user_donations = pd.DataFrame(agg_don[agg_don.index.get_level_values('user')==user])
    user_donations = user_donations.droplevel(0)
    """
    여기에서, 아마 예전 버전에서는 멀티 인덱스라도 인덱스 내 'user' 변수에 접근이 가능했던 것 같습니다. 
    최근 버전에서는, multi index 일 경우, index 함수를 사용하여 multi index 자체에 접근한 후, 
    다시 get_level_values 함수를 사용하여 접근 한다고 합니다. 
    그리고 user_donation은, reset_index를 해 줄 필요없이, index 레벨 level0인 user id를 drop 한 것입니다. 
    multi index에 level이라는 개념을 도입하여, 첫 인덱스는 level-0, 다음 인덱스는 level-1로 표기합니다. 
    """

    #user_email = all_email[all_email.user==user]
    user_email = user_email.sort_values('week').set_index('week')
    df = pd.merge(user_email, user_donations, how='left', left_index=True, right_index=True)

    merged_df = merged_df.append(df.reset_index()[['user', 'week', 'emailsOpened', 'amount']])
    merged_df = merged_df.fillna(0)

print(merged_df[merged_df['user']==998])
