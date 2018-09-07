#Problem Set 2
#Name - Navarurh Kumar
#NetID - NXK180010
#Class - BA with R Friday 4-7PM


#home directory definition
setwd("C:\\Users\\navar\\OneDrive\\Documents\\UTD\\assignments\\businessanalytics-R\\assgn-2")
#packages used for the assignment
library(data.table)
library(DBI)
library(RSQLite)
library(tidyverse)
library(ggplot2)


#sql connection function to ease life
datafetch <- function(table_name){
  con <- SQLite() %>% dbConnect('wooldridge.db')
  con %>% dbListTables
  read_table <- con %>% dbReadTable(table_name) %>% data.table
  con %>% dbDisconnect
  return(read_table)
}

####start of assignment

