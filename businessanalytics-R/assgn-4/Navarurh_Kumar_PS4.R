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

#sql connection function to ease life
datafetch <- function(table_name){
  con <- dbConnect(SQLite(),'wooldridge.db')
  read_table <- data.table(dbReadTable(con,table_name))
  dbDisconnect(con)
  return(read_table)
}

ic <- function(x){
  return(c(AIC(x),BIC(x)))
}


####start of assignment


########################
#     Question 4.1     #
########################

#Q4.1 the best fit model in this case is 
#     lm(formula =  log(price) ~ bdrms + lotsize + sqrft + I(bdrms^2) + 
#                   I(lotsize^2) + bdrms:lotsize + bdrms:sqrft + lotsize:sqrft, data = hprice)

hprice <- datafetch('hprice1')
hprice_lab <- datafetch('hprice1_labels')

model1 <- lm(log(price)~bdrms+lotsize+sqrft,data=hprice)
model2 <- lm(log(price)~bdrms+lotsize+I(sqrft^2),data=hprice)
model3 <- lm(log(price)~bdrms+I(lotsize^2)+sqrft,data=hprice)
model4 <- lm(log(price)~I(bdrms^2)+lotsize+sqrft,data=hprice)
model5 <- lm(log(price)~bdrms+lotsize+sqrft+I(bdrms^2)+I(lotsize^2)+I(sqrft^2),data=hprice)
model6 <- lm(log(price)~(bdrms+lotsize+sqrft)^2+I(bdrms^2)+I(lotsize^2)+I(sqrft^2),data=hprice)
model7 <- lm(log(price)~bdrms+lotsize+sqrft+I(bdrms^2)+I(lotsize^2)+I(sqrft^2)+I(bdrms^3),data=hprice)

ic(model1) # -36.76454 -24.37786
ic(model2) # -34.60981 -22.22312
ic(model3) # -32.10376 -19.71707
ic(model4) # -37.30824 -24.92155
ic(model5) # -43.36454 -23.54584
ic(model6) # -46.23184 -18.98113 - lowest
ic(model7) # -41.46099 -19.16496

best <- step(model6)
best

########################
#     Question 4.2     #
########################

#Q4.2 the best fit model in this case is
#     lm(formula =  colgpa ~ sat + tothrs + verbmath + hsperc + I(hsperc^2) + 
#                   sat:tothrs + sat:hsperc + tothrs:hsperc + verbmath:hsperc,data = gpa)

gpa <- datafetch('gpa2')

model1 <- lm(colgpa~sat+tothrs+verbmath+hsperc,data=gpa)
model2 <- lm(colgpa~I(sat^2)+tothrs+verbmath+hsperc,data=gpa)
model3 <- lm(colgpa~sat+I(tothrs^2)+verbmath+hsperc,data=gpa)
model4 <- lm(colgpa~sat+tothrs+I(verbmath^2)+hsperc,data=gpa)
model5 <- lm(colgpa~sat+tothrs+verbmath+I(hsperc^2),data=gpa)
model6 <- lm(colgpa~I(sat^2)+I(tothrs^2)+I(verbmath^2)+I(hsperc^2),data=gpa)
model7 <- lm(colgpa~(sat+tothrs+verbmath+hsperc)^2+I(sat^2)+I(tothrs^2)+I(verbmath^2)+I(hsperc^2),data=gpa)
model8 <- lm(colgpa~I(sat^2)+I(tothrs^2)+I(verbmath^2)+I(hsperc^2)+I(sat^3),data=gpa)

ic(model1) # 6913.909 6951.875
ic(model2) # 6895.831 6933.797
ic(model3) # 6919.732 6957.699
ic(model4) # 6913.915 6951.881
ic(model5) # 7134.979 7172.945
ic(model6) # 7117.609 7155.576
ic(model7) # 6729.287 6830.530 - lowest
ic(model8) # 7109.695 7153.989

best <- step(model7)
best

########################
#     Question 4.3     #
########################

#Q4.3 the best fit model in this case is
#     lm(formula =  log(salary) ~ years + gamesyr + bavg + hrunsyr + 
#                   rbisyr + runsyr + fldperc + allstar + frstbase + scndbase + 
#                   thrdbase + shrtstop + catcher + I(years^2) + I(gamesyr^2) + 
#                   I(allstar^2) + years:gamesyr + years:hrunsyr + years:rbisyr + 
#                   years:runsyr + years:catcher + gamesyr:hrunsyr + gamesyr:rbisyr + 
#                   gamesyr:runsyr + gamesyr:frstbase + gamesyr:scndbase + gamesyr:shrtstop + 
#                   bavg:rbisyr + hrunsyr:runsyr + hrunsyr:fldperc + hrunsyr:thrdbase + 
#                   hrunsyr:shrtstop + rbisyr:runsyr + rbisyr:scndbase + rbisyr:shrtstop + 
#                   runsyr:allstar + runsyr:thrdbase + fldperc:allstar + fldperc:frstbase + 
#                   fldperc:shrtstop + fldperc:catcher + allstar:frstbase + allstar:scndbase, 
#         data = mlb)

mlb <- datafetch('mlb1')

model1 <- lm(log(salary)~years+gamesyr+bavg+hrunsyr+rbisyr+runsyr+fldperc+allstar+frstbase+scndbase+thrdbase+shrtstop+catcher,data=mlb)
model2 <- lm(log(salary)~I(years^2)+gamesyr+bavg+hrunsyr+rbisyr+runsyr+fldperc+allstar+frstbase+scndbase+thrdbase+shrtstop+catcher,data=mlb)
model3 <- lm(log(salary)~years+I(gamesyr^2)+bavg+hrunsyr+rbisyr+runsyr+fldperc+allstar+frstbase+scndbase+thrdbase+shrtstop+catcher,data=mlb)
model4 <- lm(log(salary)~years+gamesyr+I(bavg^2)+hrunsyr+rbisyr+runsyr+fldperc+allstar+frstbase+scndbase+thrdbase+shrtstop+catcher,data=mlb)
model5 <- lm(log(salary)~years+gamesyr+bavg+I(hrunsyr^2)+rbisyr+runsyr+fldperc+allstar+frstbase+scndbase+thrdbase+shrtstop+catcher,data=mlb)
model6 <- lm(log(salary)~years+gamesyr+bavg+hrunsyr+I(rbisyr^2)+runsyr+fldperc+allstar+frstbase+scndbase+thrdbase+shrtstop+catcher,data=mlb)
model7 <- lm(log(salary)~years+gamesyr+bavg+hrunsyr+rbisyr+I(runsyr^2)+fldperc+allstar+frstbase+scndbase+thrdbase+shrtstop+catcher,data=mlb)
model8 <- lm(log(salary)~years+gamesyr+bavg+hrunsyr+rbisyr+runsyr+I(fldperc^2)+allstar+frstbase+scndbase+thrdbase+shrtstop+catcher,data=mlb)
model9 <- lm(log(salary)~years+gamesyr+bavg+hrunsyr+rbisyr+runsyr+fldperc+I(allstar^2)+frstbase+scndbase+thrdbase+shrtstop+catcher,data=mlb)
model10 <- lm(log(salary)~years+gamesyr+bavg+hrunsyr+rbisyr+runsyr+fldperc+allstar+I(frstbase^2)+scndbase+thrdbase+shrtstop+catcher,data=mlb)
model11 <- lm(log(salary)~years+gamesyr+bavg+hrunsyr+rbisyr+runsyr+fldperc+allstar+frstbase+I(scndbase^2)+thrdbase+shrtstop+catcher,data=mlb)
model12 <- lm(log(salary)~years+gamesyr+bavg+hrunsyr+rbisyr+runsyr+fldperc+allstar+frstbase+scndbase+I(thrdbase^2)+shrtstop+catcher,data=mlb)
model13 <- lm(log(salary)~years+gamesyr+bavg+hrunsyr+rbisyr+runsyr+fldperc+allstar+frstbase+scndbase+thrdbase+I(shrtstop^2)+catcher,data=mlb)
model14 <- lm(log(salary)~years+gamesyr+bavg+hrunsyr+rbisyr+runsyr+fldperc+allstar+frstbase+scndbase+thrdbase+shrtstop+I(catcher^2),data=mlb)
model15 <- lm(log(salary)~I(years^2)+I(gamesyr^2)+I(bavg^2)+I(hrunsyr^2)+I(rbisyr^2)+I(runsyr^2)+I(fldperc^2)+I(allstar^2)+I(frstbase^2)+I(scndbase^2)+I(thrdbase^2)+I(shrtstop^2)+I(catcher^2),data=mlb)
model16 <- lm(log(salary)~I(years^2)+I(gamesyr^2)+I(bavg^2)+I(hrunsyr^2)+I(rbisyr^2)+I(runsyr^2)+I(fldperc^2)+I(allstar^2)+I(frstbase^2)+I(scndbase^2)+I(thrdbase^2)+I(shrtstop^2)+I(catcher^2)+I(years^3),data=mlb)
model17 <- lm(log(salary)~I(years^2)+I(gamesyr^2)+I(bavg^2)+I(hrunsyr^2)+I(rbisyr^2)+I(runsyr^2)+I(fldperc^2)+I(allstar^2)+I(frstbase^2)+I(scndbase^2)+I(thrdbase^2)+I(shrtstop^2)+I(catcher^2)+I(gamesyr^3),data=mlb)
model18 <- lm(log(salary)~(years+gamesyr+bavg+hrunsyr+rbisyr+runsyr+fldperc+allstar+frstbase+scndbase+thrdbase+shrtstop+catcher)^2+I(years^2)+I(gamesyr^2)+I(bavg^2)+I(hrunsyr^2)+I(rbisyr^2)+I(runsyr^2)+I(fldperc^2)+I(allstar^2)+I(frstbase^2)+I(scndbase^2)+I(thrdbase^2)+I(shrtstop^2)+I(catcher^2),data=mlb)

ic(model1) # 774.9215 832.9185
ic(model2) # 795.6623 853.6593
ic(model3) # 783.4971 841.4941
ic(model4) # 775.0302 833.0272
ic(model5) # 776.4031 834.4001
ic(model6) # 772.3854 830.3824
ic(model7) # 781.6443 839.6413
ic(model8) # 774.9158 832.9129
ic(model9) # 778.4923 836.4894
ic(model10) # 774.9215 832.9185
ic(model11) # 774.9215 832.9185
ic(model12) # 774.9215 832.9185
ic(model13) # 774.9215 832.9185
ic(model14) # 774.9215 832.9185
ic(model15) # 844.2513 902.2483
ic(model16) # 782.3599 844.2234
ic(model17) # 794.0655 855.9290
ic(model18) #  703.484 1055.333 - lowest

best <- step(model18)
best


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



