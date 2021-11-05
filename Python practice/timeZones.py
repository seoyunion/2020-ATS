import datetime
import pytz

print(datetime.datetime.utcnow())
print(datetime.datetime.now())
print(datetime.datetime.now(datetime.timezone.utc))


western = pytz.timezone('US/Pacific')
print(western.zone)

# here we localize
loc_dt = western.localize(datetime.datetime(2020, 5, 15, 20, 34,0))
print(loc_dt)
print()

london_tz = pytz.timezone('Europe/London')
london_dt = loc_dt.astimezone(london_tz)
print(london_dt)

f = '%Y-%m-%d %H:%M:%S %Z%z'
london_dt = datetime.datetime(2020, 5, 12, 12, 15, 0, tzinfo = london_tz).strftime(f)
print(london_dt)

# generally you want to store data in UTC and convert only when generating human readable output
# you can also do date arithmetic with time zones
event1 = datetime.datetime(2020, 5, 12, 12, 15, 0, tzinfo = london_tz)
event2 = datetime.datetime(2020, 5, 13, 9, 15, 0, tzinfo = western)
event2 - event1
## this will yield the wrong time delta because the time zones haven't been labelled properly
print()

event1 = london_tz.localize( datetime.datetime(2020, 5, 12, 12, 15, 0))
event2 = western.localize(datetime.datetime(2020, 5, 13, 9, 15, 0))
print(event2 - event1)

event1 = london_tz.localize((datetime.datetime(2020, 5, 12, 12, 15, 0))).astimezone(datetime.timezone.utc)
event2 = western.localize(datetime.datetime(2020, 5, 13, 9, 15, 0)).astimezone(datetime.timezone.utc)
print(event2 - event1)

## you also need to apply the normalize function for your time zone
event1 = london_tz.localize( datetime.datetime(2020, 5, 12, 12, 15, 0))
event2 = western.localize(datetime.datetime(2020, 5, 13, 9, 15, 0))
print(event2-event1)

## have a look at pytz.common_timezones
print(pytz.common_timezones)
print(pytz.country_timezones('RU')) ## or country specific
print()



