# Problem Set 4
# Name - Navarurh Kumar
# NetID - NXK180010
# Class - BA with R Friday 4-7PM


#home directory definition
setwd("/home/navarurh/documents/assignments/businessanalytics-R/assgn-4/")

#packages used for the assignment
library(data.table)
library(DBI)
library(RSQLite)
library(sandwich)
library(lmtest)
library(plyr)
library(tseries)
library(broom)
library(reshape)
library(vars)
library(plm)
library(margins)
library(tidyverse)

#sql connection function to ease life
datafetch <- function(table_name){
  con <- dbConnect(SQLite(),'wooldridge.db')
  read_table <- data.table(dbReadTable(con,table_name))
  dbDisconnect(con)
  return(read_table)
}

####start of assignment


########################
#     Question 4.1     #
########################

#Q4.1

hprice <- datafetch('hprice1')
hprice_lab <- datafetch('hprice1_labels')

wage1 <- datafetch("wage1")
model3 <- lm(log(wage)~I(educ^2)+exper+I(exper^2)+tenure,data=wage1)
model3 %>% coeftest(.vcov=vcovHC)
modelx <- lm(log(wage)~educ+exper+tenure+I(educ^2)+I(exper^2)+I(tenure^2)+I(educ^3)+I(exper^3)+I(tenure^3),data=wage1)
summary(step(modelx)) # AIC
summary(step(modelx,k=log(nrow(wage1)))) #BIC even if says AIC, it's a lie
ic <- function(x){
  return(c(AIC(x),BIC(x)))
}
step(modelx,k=log(nrow(wage1))) %>% ic
model3 %>% ic

########################
#     Question 4.2     #
########################

#Q4.2


########################
#     Question 4.3     #
########################

#Q4.3


########################
#     Question 4.4     #
########################

#Q4.4.i.    y90 coeff shows that for a change in the decade the rent has increased
#           by 26% keeping all the other factors constant
#           as for b-pctstu we see a very significant p-val of 2.4e-6 and we can interpret that
#           a 1%-point increase in pctstu will lead to a 0.5% increase in the rent
#Q4.4.ii.   The equation in part i does not have the ai term in the model. As a result if we include
#           ai in the error term then there is a very obvious correlation between the error terms across
#           the two time periods, invalidating the error terms from the first model
#Q4.4.iii.  In this model a 1%-point increase in pctstu will cause a 1.1% increase in the rent
#           pctstu is not as significant as the last model with a p-val of 0.008726
#Q4.4.iv.   

rent <- datafetch("rental")
rent_l <- datafetch("rental_labels")
rent <- pdata.frame(rent, index = c('city','year'))

model1 <- plm(data = rent, log(rent) ~ y90 + log(pop) + log(avginc) + pctstu, model = 'pooling')
summary(model1)

model2 <- plm(data = rent, log(rent) ~ log(pop) + log(avginc) + pctstu, model = 'fd')
summary(model2)

model3 <- plm(data = rent, log(rent) ~ log(pop) + log(avginc) + pctstu, model = 'within')
summary(model3)


########################
#     Question 4.5     #
########################

#Q4.5.i.    
#Q4.5.ii.   
#Q4.5.iii.  
#Q4.5.iv.   
#Q4.5.v.    
#Q4.5.vi.   
#Q4.5.vii.  

murder <- datafetch("murder")
labs <- datafetch("murder_labels")
murder <- pdata.frame(murder,index = c("state","year"))

model1 <- plm(data = murder, mrdrte ~ d93 + exec + unem, model = 'pooling')
summary(model1)


########################
#     Question 4.6     #
########################

#Q4.6.i.    
#Q4.6.ii.   
#Q4.6.iii.  
#Q4.6.iv.   
#Q4.6.v.    
#Q4.6.vi.   


########################
#     Question 4.7     #
########################

#Q4.7.i.    
#Q4.7.ii.   


########################
#     Question 4.8     #
########################

#Q4.8.i.    
#Q4.8.ii.   
#Q4.8.iii.  
#Q4.8.iv.   
#Q4.8.v.    
#Q4.8.vi.   
#Q4.8.vii.  
#Q4.8.viii. 


########################
#     Question 4.9     #
########################

#Q4.9.i.    
#Q4.9.ii.   
#Q4.9.iii.  



