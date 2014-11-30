library(data.table)
library(forecast)

# Open transcation data as data.table
trans <- data.table(read.csv("~/workspace/forecast/data/transaction_data.csv",header = TRUE,sep = ','))
casual <- data.table(read.csv("~/workspace/forecast/data/causal_data.csv",header = TRUE,sep = ','))

# 
week_sum = trans[,.(sales=sum(SALES_VALUE)),by=.(DAY)]
week_sum_ts<-ts(week_sum[,sales],start=1990,frequency=365)
week_sum_ts2 <- window(week_sum_ts,start = 1990.0,end=1990.5)
ets_fit <- ets(week_sum_ts2)
plot(ets_fit)


tsdisplay(diff(diff(week_sum_ts,1),1))
arima_fit <- auto.arima(week_sum_ts2)

tsdisplay(residuals(arima_fit))
plot(forecast.Arima(arima_fit,h=50))


plot(trans[,.(week.sales.sum=sum(SALES_VALUE)),by=WEEK_NO],col='red',type = 'line')
lines(trans[,.(retail.disc=sum(-RETAIL_DISC)),by=WEEK_NO],col='blue')

plot(trans[,.(retail.disc=sum(-RETAIL_DISC*SALES_VALUE),week.sales.sum=sum(SALES_VALUE)),
        by=WEEK_NO])
