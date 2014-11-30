library(data.table)


dt <- data.table(read.csv("~/workspace/forecast/data/transaction_data.csv",header = TRUE,sep = ','))

day_sum = dt[,.(sales=sum(SALES_VALUE)),by=.(DAY)]
plot(ts(day_sum[,sales],start=1990,frequency=365),ylab = 'week total sales')

plot(dt[,.(week.sales.sum=sum(SALES_VALUE)),by=WEEK_NO],col='red',type = 'line')
lines(dt[,.(retail.disc=sum(-RETAIL_DISC)),by=WEEK_NO],col='blue')

plot(dt[,.(retail.disc=sum(-RETAIL_DISC*SALES_VALUE),week.sales.sum=sum(SALES_VALUE)),
        by=WEEK_NO])
