require(data.table)
require(zoo)

unemp <- fread("./Ch02/data/UNRATE.csv")
unemp[, DATE := as.Date(DATE)]

head(unemp)
unemp.jan = unemp[seq.int(from=1, to=nrow(unemp), by=12)]
# seq: sequence generator 
# seq.int: integer sequence generator
head(unemp.jan)
unemp.avg <- unemp[, round(mean(UNRATE),2), by=format(DATE, "%Y")]
head(unemp.avg)

# Upsampling
all.dates <- seq(from=unemp$DATE[1], to=tail(unemp$DATE, 1), by='day')
head(all.dates)

daily.unemp = unemp[J(all.dates),  on='DATE',roll=31]
head(daily.unemp)