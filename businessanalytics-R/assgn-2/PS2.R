# Problem Set 2
# Name - Navarurh Kumar
# NetID - NXK180010
# Class - BA with R Friday 4-7PM


#home directory definition
setwd("/home/navarurh/documents/assignments/businessanalytics-R/assgn-2/")
#packages used for the assignment
library(data.table)
library(DBI)
library(RSQLite)
library(ggplot2)


#sql connection function to ease life
datafetch <- function(table_name){
  con <- dbConnect(SQLite(),'wooldridge.db')
  read_table <- data.table(dbReadTable(con,table_name))
  dbDisconnect(con)
  return(read_table)
}

####start of assignment

#Question 1

#i.   a 1% increase in expendA will lead to a beta1/100 change in the number of votes for candidate A
#ii.  H0: beta1 + beta2 = 0
#iii. voteA = 45.08788 + 6.08136*log(expendA) - 6.61563*log(expendB) + 0.15201*prtystrA
#     log(expendA) is a significant factor in the estimation of voteA
#     log(expendB) is again significant hence B's expenditures also have a significant impact on voteA
#     <>
#iv.  

vote <- datafetch("vote1")
model1 <- lm(data = vote, voteA ~ log(expendA) + log(expendB) + prtystrA)
summary(model1)


#Question 2

#i.

law <- datafetch("lawsch85")
model <- lm(data = law, salary ~ rank + I(rank^2) + I(rank^3))
summary(model)
