setwd("~/documents/assignments/database/project/")

library(plyr)
library(RMySQL)

d1 <- read.csv("datasets/BUAN6320-DataSet1.txt",header = T,stringsAsFactors = F,sep = "\t")
d2 <- read.csv("datasets/BUAN6320-DataSet2.txt",header = T,stringsAsFactors = F,sep = "\t")
d3 <- read.csv("datasets/BUAN6320-DataSet3_pytmp.txt",header = T,stringsAsFactors = F,sep = "\t",fileEncoding="utf-8")
d4 <- read.csv("datasets/BUAN6320-DataSet4.txt",header = T,stringsAsFactors = F,sep = "\t")

colnames(d1)
colnames(d2)
colnames(d3)
colnames(d4)

brand <- d3[c(12,2,9)]
brand <- unique(brand)
customer <- d1[c(2,3,5,6,8,10,12,14)]
customer <- unique(customer)
department <- d4[c(12,13,14,15,16)]
department <- unique(department)
employee <- d4[c(1,2,3,4,5,6,7,8,12)]
employee <- unique(employee)
invoice <- d1[c(13,16,2,9,15)]
invoice <- unique(invoice)
line1 <- d1[c(13,11,7,4,1)]
line2 <- d2[c(12,13,14,15,16)]
line <- rbind(line1,line2)
line <- unique(line)
product <- d3[c(1,4,5,17,7,11,14,16,12)]
product <- unique(product)
salary_history <- d4[c(1,9,10,11)]
salary_history <- unique(salary_history)
supplies <- d3[c(1,13)]
supplies <- unique(supplies)
vendor <- d3[c(13,6,3,10,8,15)]
vendor <- unique(vendor)

invoice <- invoice[!duplicated(invoice$INV_NUM),]
vendor <- vendor[which(vendor$VEND_NAME != ""),]
colnames(invoice)[5] <- "EMP_NUM"

employee$EMP_HIREDATE <- as.Date(employee$EMP_HIREDATE, origin = "1900-01-01")
invoice$INV_DATE <- as.Date(invoice$INV_DATE, origin = "1900-01-01")
salary_history$SAL_FROM <- as.Date(salary_history$SAL_FROM, origin = "1900-01-01")
salary_history$SAL_END[which(salary_history$SAL_END == " - ")] <- NA
salary_history$SAL_END <- as.integer(salary_history$SAL_END)
salary_history$SAL_END <- as.Date(salary_history$SAL_END, origin = "1900-01-01")

con <- dbConnect(MySQL(), user='root', password='n', dbname='project', host='localhost')

# dbWriteTable(con, name='brand', brand, overwrite=T, row.names = F)
# dbWriteTable(con, name='customer', customer, overwrite=T, row.names = F)
# dbWriteTable(con, name='department', department, overwrite=T, row.names = F)
# dbWriteTable(con, name='employee', employee, overwrite=T, row.names = F)
# dbWriteTable(con, name='invoice', invoice, overwrite=T, row.names = F)
# dbWriteTable(con, name='line', line, overwrite=T, row.names = F)
# dbWriteTable(con, name='product', product, overwrite=T, row.names = F)
# dbWriteTable(con, name='salary_history', salary_history, overwrite=T, row.names = F)
# dbWriteTable(con, name='supplies', supplies, overwrite=T, row.names = F)
# dbWriteTable(con, name='vendor', vendor, overwrite=T, row.names = F)
dbWriteTable(con, name='brand', brand, append=T, row.names = F)
dbWriteTable(con, name='customer', customer, append=T, row.names = F)
dbWriteTable(con, name='department', department, append=T, row.names = F)
dbWriteTable(con, name='employee', employee, append=T, row.names = F)
dbWriteTable(con, name='invoice', invoice, append=T, row.names = F)
dbWriteTable(con, name='line', line, append=T, row.names = F)
dbWriteTable(con, name='product', product, append=T, row.names = F)
dbWriteTable(con, name='salary_history', salary_history, append=T, row.names = F)
dbWriteTable(con, name='supplies', supplies, append=T, row.names = F)
dbWriteTable(con, name='vendor', vendor, append=T, row.names = F)
