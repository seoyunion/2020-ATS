## vscode 
## install.packages(devtools) 
## library(devtools) 

require(data.table)
require(zoo)

unemp <- fread("./Ch02/data/UNRATE.csv")
unemp[, DATE := as.Date(DATE)]

## generate a data set where data is randomly missing
rand.unemp.idx <- sample(1:nrow(unemp), .1*nrow(unemp))
rand.unemp <- unemp[-rand.unemp.idx]

## generate a data set 
## where data is more likely to be missing if it's high
high.unemp.idx <- which(unemp$UNRATE > 8) 
high.unemp.idx <- sample(high.unemp.idx, 
        .5 * length(high.unemp.idx))
bias.unemp <- unemp[-high.unemp.idx]

all.dates <- seq(from = unemp$DATE[1], to=tail(unemp$DATE, 1), 
        by="month" )

rand.unemp = rand.unemp[J(all.dates), on='DATE', roll=0]
bias.unemp = bias.unemp[J(all.dates), on='DATE', roll=0]
rand.unemp[, rpt := is.na(UNRATE)]

## --------------DONATION DATA AS EXAMPLE------------------------
donations <- data.table(
        amt = c(99, 100, 5, 15, 11, 1200), 
        dt = as.Date(c("2019-2-27", "2019-3-2", "2019-6-13", 
        "2019-8-1", "2019-8-31", "2019-9-15"))
)

publicity <- data.table(
        identifier = c("q4q42", "4299hj", "bbg2"), 
        dt = as.Date(c("2019-1-1", "2019-4-1", "2019-7-1"))
)

setkey(publicity, 'dt')
setkey(donations, 'dt')
publicity[donations, roll=TRUE]
## --------------------------------------


## ---- FORWARD fill ------
rand.unemp[, impute.ff := na.locf(UNRATE, na.rm=FALSE)]
bias.unemp[, impute.ff := na.locf(UNRATE, na.rm=FALSE)]

unemp[350:400, plot(DATE, UNRATE, col=1, lwd=2, type='b')]
rand.unemp[350:400, lines(DATE, impute.ff, col=1, lwd=2, lty=2)]
rand.unemp[350:400][rpt==TRUE, points(DATE, impute.ff, 
                        col=2, pch=6, cex=2)]


## ---- Simple MA ------

rand.unemp <- rand.unemp[, impute.rm.nolkh := rollapply(c(NA,NA,UNRATE), 3, 
                function(x) {
                        if (!is.na(x[3])) x[3] else mean(x, na.rm = TRUE)
                })]
bias.unemp <- bias.unemp[, impute.rm.nolkh := rollapply(c(NA,NA,UNRATE), 3, 
                function(x) {
                        if (!is.na(x[3])) x[3] else mean(x, na.rm = TRUE)
                })]

## ----- Lookahead MA -----
rand.unemp[, complete.rm := rollapply(c(NA, UNRATE, NA), 3, 
                function(x) {
                        if (!is.na(x[2]))
                                x[2]
                        else {
                           mean(x, na.rm=TRUE)
                        }
                })]


## ----- Linear Interpolation -----
rand.unemp[, impute.li := na.approx(UNRATE)]
bias.unemp[, impute.li := na.approx(UNRATE)]

## ----- Polynomial interpolation -----
rand.unemp[, impute.sp := na.spline(UNRATE)]
bias.unemp[, impute.sp := na.spline(UNRATE)]

use.idx = 90:120
unemp[use.idx, plot(DATE, UNRATE, col=1, type='b')]
rand.unemp[use.idx, lines(DATE, impute.li, col=2, lwd =2, lty = 2)]
rand.unemp[use.idx, lines(DATE, impute.sp, col=3, lwd =2, lty = 3)]


##rand.unemp[which(rand.unemp$rpt == TRUE)]

sort(rand.unemp[, lapply(.SD, 
                         function(x) 
                         mean((x -unemp$UNRATE)^2, na.rm =TRUE)),
                         .SDcols = c("impute.ff", "impute.rm.nolkh", "impute.li", "impute.sp", "complete.rm")
                         ])