library(data.table)
library(dplyr)
library(partykit)

n <- 500
set.seed(75080)

z   <- rnorm(n)
w   <- rnorm(n)
x   <- 5*z + 50
y   <- -100*z+ 1100 + 50*w
y   <- 10*round(y/10)
y   <- ifelse(y<200,200,y)
y   <- ifelse(y>1600,1600,y)
dt1 <- data.table('id'=1:500,'sat'=y,'income'=x,'group'=rep(1,n))

z   <- rnorm(n)
w   <- rnorm(n)
x   <- 5*z + 80
y   <- -80*z+ 1200 + 50*w
y   <- 10*round(y/10)
y   <- ifelse(y<200,200,y)
y   <- ifelse(y>1600,1600,y)
dt2 <- data.table('id'=501:1000,'sat'=y,'income'=x,'group'=rep(2,n))

z   <- rnorm(n)
w   <- rnorm(n)
x   <- 5*z + 30
y   <- -120*z+ 1000 + 50*w
y   <- 10*round(y/10)
y   <- ifelse(y<200,200,y)
y   <- ifelse(y>1600,1600,y)
dt3 <- data.table('id'=1001:1500,'sat'=y,'income'=x,'group'=rep(3,n))

dtable <- merge(dt1    ,dt2, all=TRUE)
dtable <- merge(dtable ,dt3, all=TRUE)
dtable$group <- as.factor(dtable$group)
dtable$iid <- 1:1500

pooled <- lm(sat~income,data=dtable)
within <- lm(sat~income+group-1,data=dtable)
model1 <- lm(sat~income,data=dtable[group==1])
model2 <- lm(sat~income,data=dtable[group==2])
model3 <- lm(sat~income,data=dtable[group==3])

summary(pooled)
summary(within)
summary(model1)
summary(model2)
summary(model3)

library(plm)
ptable <- pdata.frame(dtable,index=c('group','iid'))
plm(sat~income,model='within',data=ptable)
lm(sat~income+group-1,data=dtable)
plm(sat~income,model='pooling',data=ptable)
