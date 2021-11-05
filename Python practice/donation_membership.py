#기부 데이터 시뮬레이션 생성

import numpy as np
import pandas as pd

NUM_EMAILS_SENT_WEEKLY = 3

years = ['2014', '2015', '2016', '2017', '2018']
memberStatus = ['bronze', 'silver', 'gold', 'inactive']
memberYears = np.random.choice(years, 50, #샘플링. 5개 연도 중 p의 확률로  50개를 만들 것임
                               p=[0.1,0.1,0.15,0.3,0.35])  # 50 datapoints
memberStats = np.random.choice(memberStatus, 50,
                                p=[0.5,0.3,0.1,0.1])

yearJoined = pd.DataFrame({'yearJoined':memberYears,
                           'memberStats': memberStats})


def never_opens(period_rng):
    return []


def constant_open_rate(period_rng):
    n, p = NUM_EMAILS_SENT_WEEKLY, np.random.uniform(0,1)
    num_opened = np.random.binomial(n, p, len(period_rng))
    return num_opened


def increasing_open_rate(period_rng):
    return open_rate_with_factor_change(period_rng,
                                        np.random.uniform(1.01, 1.30))  # increasing


def decreasing_open_rate(period_rng):
    return open_rate_with_factor_change(period_rng,
                                        np.random.uniform(0.5, 0.99))


def open_rate_with_factor_change(period_rng, fac):
    if len(period_rng) < 1:
        return []

    times = np.random.randint(0, len(period_rng),
                               int(0.1 * len(period_rng)))  # 10% times
    num_opened = np.zeros(len(period_rng))
    for prd in range(0, len(period_rng), 2):
        n, p = NUM_EMAILS_SENT_WEEKLY, np.random.uniform(0, 1)
        try:
            num_opened[prd:(prd+2)] = np.random.binomial(n, p, 2)  ## number of trials, probability of each trial, no of testment
            p = max(min(1, p*fac), 0)
        except:
            num_opened[prd] = np.random.binomial(n, p, 1)  # data set has odd numbers of dtpoints
    for t in range(len(times)):
        num_opened[times[t]] = 0
    return num_opened


def random_weekly_time_delta():
    days_of_week = [d for d in range(7)]
    hours_of_day = [h for h in range(11, 23)]
    minute_of_hour = [m for m in range(60)]
    second_of_minute = [s for s in range(60)]
    return pd.Timedelta(str(np.random.choice(days_of_week))+"days") + \
           pd.Timedelta(str(np.random.choice(hours_of_day)) +'hours') +\
           pd.Timedelta(str(np.random.choice(minute_of_hour))+'minutes')+ \
           pd.Timedelta(str(np.random.choice(second_of_minute))+'seconds')


def produce_donations(period_rng, member_behavior, num_emails,
                      use_id, member_join_year):
    donation_amounts = np.array([0, 25, 50, 75, 100, 250, 500,
                                 1000, 1500, 2000])
    member_has = np.random.choice(donation_amounts)

    email_fraction = num_emails / (NUM_EMAILS_SENT_WEEKLY* len(period_rng)) # opened rate
    member_gives = member_has * email_fraction
    member_gives_idx = np.where(member_gives >= donation_amounts)[0][-1]
    num_times_gave = np.random.poisson(2)*(2018-member_join_year)  # poisson distribution -- how many times member gives
    times = np.random.randint(0, len(period_rng), num_times_gave)  # which week member give donation

    dons = pd.DataFrame({'member':[],
                         'amount':[],
                         'timestamp':[]})
    for n in range(num_times_gave):
        donation = donation_amounts[member_gives_idx + np.random.binomial(1, .3)]
        ts = str(period_rng[times[n]] + random_weekly_time_delta())  # ramdom day in the week
        dons = dons.append(pd.DataFrame({
            'member':[use_id],
            'amount':[donation],
            'timestamp':[ts] }))

    if dons.shape[0] >0:
        dons = dons[dons.amount != 0]
    return dons

#이메일 오픈 횟수와 기부 금액 간의 상관관계를 알아보고자 했었다..
## run it
behaviors = [never_opens, constant_open_rate, increasing_open_rate, decreasing_open_rate]

# numpy.random.choice(a, size=None, replace=True, p=None) #sampling
member_behaviors = np.random.choice(behaviors, size=50, p=[0.2, 0.5, 0.1, 0.2])
rng = pd.date_range('2015-02-04', '2018-06-01', freq='W')

emails = pd.DataFrame({'member':[],
                       'week':[],
                       'emailsOpened':[]})

donations = pd.DataFrame({'member':[],
                          'amount':[],
                          'timestamp':[]})

print(yearJoined.iloc[0])
for idx in range(yearJoined.shape[0]):

    # time stamp + time delta
    join_date = pd.Timestamp(yearJoined.iloc[idx].yearJoined) + \
                pd.Timedelta(str(np.random.randint(0, 365)) + 'days') # randomly add some days

    join_date = min(join_date, pd.Timestamp('2018-06-01')) # max_range is 2018-06-02

    member_rng = rng[rng >join_date]

    if len(member_rng) <1:
        continue

    info = member_behaviors[idx](member_rng)  # generate member opened email numbers

    if len(info) == len(member_rng):
        emails = emails.append(pd.DataFrame({
            'member': [idx] *len(info),
            'week': [str(r) for r in member_rng],
            'emailsOpened': info
        }))
        donations = donations.append(
            produce_donations(member_rng, member_behaviors[idx],
                              sum(info), idx, join_date.year)
        )


## get rid of zero donations and zero emails
emails = emails[emails.emailsOpened != 0]
yearJoined.index.name = 'user'

yearJoined.to_csv('data/year_joined.csv', index=False)
donations.to_csv('data/donations.csv',   index=False)
emails.to_csv('data/emails.csv',  index=False)


