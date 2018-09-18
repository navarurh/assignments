# Problem Set 3
# Name - Navarurh Kumar
# NetID - NXK180010
# Class - BA with R Friday 4-7PM


#home directory definition
setwd("/home/navarurh/documents/assignments/businessanalytics-R/assgn-3/")

#packages used for the assignment
library(data.table)
library(DBI)
library(RSQLite)

#sql connection function to ease life
datafetch <- function(table_name){
  con <- dbConnect(SQLite(),'wooldridge.db')
  read_table <- data.table(dbReadTable(con,table_name))
  dbDisconnect(con)
  return(read_table)
}

####start of assignment


########################
#     Question 3.1     #
########################

#Q3.1.i.
#Q3.1.ii.
#Q3.1.iii.
#Q3.1.iv.

mlb <- datafetch('mlb1')
mlb_lab <- datafetch('mlb1_labels')
