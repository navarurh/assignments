#install.packages('data.table')
library(data.table)
#install.packages('tidyverse')
library(tidyverse)
#install.packages('RSQLite')
library(RSQLite)
#install.packages('DBI')
library(DBI)

setwd('~/Dropbox/Semester3/BA_with_R/Assignment_1')
list.files()

#Problem 1.1 -  WAGE: 
con <- SQLite() %>%
  dbConnect('wooldridge.db')
con %>% dbListTables()
wage <- con %>% dbReadTable('wage1') %>% data.table
con %>% dbReadTable('wage1_labels')
con %>% dbDisconnect()
summary(wage)
summary(wage$educ) #Q1a.
summary(wage$wage) #Q1b. 
wage2010 <- mean(wage$wage)*(218.056/56.9) 
wage2010 #Q1d. 
sum(wage$female) #Q1e.
count(wage)-sum(wage$female) #Q1e. 

#Q1a. The min = 0 (No education) and max = 18 year of Education. The average mean is 12.56 years of education. 
#Q1b. The min and max hourly earnings are 0.53$ and 25$ respectively. Both the minimum and maximum wage seems relatively low for a real world scenario
#Q1c. The CPI in 1976 was 56.9 and the CPI in 2010 was 218.056
#Q1d. The mean wage in 1976 is 5.90$. And the same wage in 2010 will be 22.64$. This seems reasonable. 
#Q1e. The total of females in the given data is 252 and the no.of men are 274. A total of 526 people. 

# ----------------------------------------------------------------------------------------------------------------------------

#Problem 1.2 - meop: 
con <- SQLite() %>%
  dbConnect('wooldridge.db')
con %>% dbListTables()
meap <- con %>% dbReadTable('meap01') %>% data.table
con %>% dbReadTable('meap01_labels')
con %>% dbDisconnect()

summary(meap$math4) #2a. 
sum(as.numeric(meap$math4==100)) #2b. 
mean(as.numeric(meap$math4==100)) #2b in percentage
sum(as.numeric(meap$math4==50)) #2c. 
summary(meap$math4)
summary(meap$read4) #2d.
cor(meap$math4, meap$read4) #2e. 
mean(meap$exppp)
sd(meap$exppp) #2f. 
(6000-5500)/5500
log(6000)-log(5500) #2g. 

#Q2a. The min and max values of math4 are 0 and 100 respectively. And this data makes sense.
#Q2b. There are 38 schools that have a perfect pass rate on maths. It constitutes to about 20.8%. 
#Q2c. There are 17 schools that have a pass rate of exactly 50 in maths. 
#Q2d. The mean for math is 71% and for reading it is 60%. Hence reading is harder to pass.
#Q2e. There is a strong correlation of 84% between math and reading. 
#q2f. The mean = 5194 and Std. Dev = 1091. This is very high. 
#q2g. The perventage increase is about 9% and in log its about 8.7% 


# ----------------------------------------------------------------------------------------------------------------------------

#problem 1.3 - 401k: 
con <- SQLite() %>%
  dbConnect('wooldridge.db')
con %>% dbListTables()
prob3 <- con %>% dbReadTable('401k') %>% data.table
con %>% dbReadTable('401k_labels')

summary(prob3$prate)
summary(prob3$mrate) #Q3a. 
model <- lm(prate ~ mrate, data=prob3)
summary(model) #Q3b. 
nrow(model.frame(model)) #Q3b. 

predict(model, data.frame(mrate=3.5)) #Q3d. 

#Q3a. The average participation and match rate are 87.36 and 0.73 respectively. 
#Q3b. The Sample size of the model= 1534. R-Squared value of 0.0747. 
#Q3c.# prate = 83.0755 + 5.8611 mrate
     #INTERCEPT: With no contribution from the worker, the contribution of the firm is 83$. 
     #MARTE: WIth 1$ contribution from the worker is matched by 5.8$ contribution by the firm. 
#Q3d. The value of prate when mrate is 3.5 is 103.5892
#Q3e. The value of R-Square states the variation in prate explained by mrate which is 0.074. 
     # More closer to 1 indicates a strong model. Hence, the model above is not a good estimate. 
     # We could bring in more factors that affect the prate along with mrate to increase the R-square value. 

# ----------------------------------------------------------------------------------------------------------------------------

#Problem 1.4 - Ceosal2:
con <- SQLite() %>%
  dbConnect('wooldridge.db')
con %>% dbListTables()

ceosal2 <- con %>% dbReadTable('ceosal2') %>% data.table
con %>% dbReadTable('ceosal2_labels')

summary(ceosal2$salary)
summary(ceosal2$comten) #Q4a. 
sum(as.numeric(ceosal2$ceoten==0)) #Q4b. 
summary(ceosal2$ceoten) #Q4b.
model4 <- lm(log(salary) ~ ceoten, data=ceosal2)
summary(model4) #Q4c. 

#Q4a. The average salary = 866k$ and average tenure = 22.5 years
#Q4b. There are 5 new CEO's. The longest tenure in CEO is 37 years. 
#Q4c. log(salary) = 6.505 + 0.0097 ceoten + u. 
      # For every 1 year as CEO, the salary will increase by 0.97 percentage. 

# ----------------------------------------------------------------------------------------------------------------------------

#Problem 1.5 - Wage2: 
con <- SQLite() %>%
  dbConnect('wooldridge.db')
con %>% dbListTables()

wage2 <- con %>% dbReadTable('wage2') %>% data.table
con %>% dbReadTable('wage2_labels') 

summary(wage2$wage)
summary(wage2$IQ)
sd(wage2$IQ) #Q5a. 
model5 <- lm(wage ~ IQ, data = wage2)
summary(model5) #Q5b. 
predict(model5, data.frame(IQ=15)) #Q5b. 
model5b <- lm(log(wage) ~ IQ, data= wage2)
summary(model5b) #Q5c.  

#Q5a. The avg wage monthly are 957.9$. The avg. Iq is 101. The std.dev is 15.05
#Q5b. Wage = 116.99 + 8.303 IQ + e 
      # A one point increase in IQ will increase the wage by 8.3$. 
      # WIth an IQ of 15, the estimated monthly wage will be 241.5$.i.e increase of 15*8.3 = 124.5$ 
      # An R-squared value of 0.095 indicates that it only explains some of the variation in wage.
#Q5c. log(wage) = 5.88 + 0.0088 IQ + e
      # A one point increase in IQ will result in 0.88% increase in wages. 
      # A 15 point increase in IQ will result in 15*0.88=0.132, which is approximate change in predicted wage. 
# ----------------------------------------------------------------------------------------------------------------------------

#Problem 1.6: meap93 
con <- SQLite() %>%
  dbConnect('wooldridge.db')
con %>% dbListTables()
meap93 <- con%>% dbReadTable('meap93') %>% data.table
con%>% dbReadTable('meap93_labels')

model6a <- lm(math10 ~ expend, data = meap93)
summary(model6a)
expendq <- meap93$expend*meap93$expend
model6b <- lm(meap93$math10 ~ expendq, data = meap93)
summary(model6b) #Q6a. 

model6c <- lm(math10 ~ log(expend), data = meap93)
summary(model6c)#Q6b. 
nrow(model.frame(model6c))#Q6c. 
summary(meap93$math10)
max(fitted.values(model6c)) #Q6e. 

#Q6a. Both the models with same effect and diminishing effect are almost similar and equally bad in explaining variation in math10. 
      #However, diminishing effect is effective than same effect by a slight margin.There is an increase of R-square by 0.003
#Q6b this indicates that 1% increase in expenditur
#Q6c.  math10 = -69.341 + 11.164 log(expend) + e. Sample size = 408 and R-Square = 0.0297
#Q6d. For a 10% increase in spending the estimated percentage point increase in math10 is 1.1. This is not a huge effect. 
#Q6e. The max value of math10 in the datset is only 66.7. And the max value in the fitted points is 30.1. Both are far from 100. 

# ----------------------------------------------------------------------------------------------------------------------------

#problem 1.7: Hprice1:
con <- SQLite() %>%
  dbConnect('wooldridge.db')
con %>% dbListTables()
hprice <- con%>% dbReadTable('hprice1') %>% data.table
con%>% dbReadTable('hprice1_labels')

model7a <- lm(price ~ sqrft+bdrms, data = hprice)
summary(model7a) #Q7a. 
predict(model7a, data.frame(bdrms=1, sqrft=140)) #Q7c
predict(model7a, data.frame(bdrms=4, sqrft=2438))#Q7d.


#Q7a. price = -19.315 + 0.12844 Sqrft + 15.1981 bdrms + e 
#Q7b. The increase in price of house for 1 aditional bedroom is 15,198$. 
#Q7c. The price of house wirh 140sqft and 1 additional bedroom will be 13,864$. Thus, increase of 33,179$. 
#Q7d. About 63% of variation in house price is explained by bedrooms and Sqrt. 
#Q7e. The price of 4 bedroom house with 2438, sqft is 354,605$. 
#Q7f. Based on above factors the price estimate of the house is 354,605$. 
      # If the buyer had paid 300,000$, He has underpaid for the house. 
      # But this underpayment is assessed only based on the No.of bedrooms and Sqrt. 

# ----------------------------------------------------------------------------------------------------------------------------------

#Problem 1.8: Ceosal2: 
con <- SQLite() %>%
  dbConnect('wooldridge.db')
con %>% dbListTables()
model8a <- lm(log(salary) ~ log(sales)+log(mktval), data = ceosal2)
summary(model8a) #Q8a. 

summary(ceosal2$profits)
model8b <- lm(log(salary) ~ log(sales)+log(mktval)+profits, data = ceosal2)
summary(model8b) #Q8b.

model8c <- lm(log(salary) ~ log(sales)+log(mktval)+profits+ceoten, data = ceosal2)
summary(model8c) #Q8c. 
cor(log(ceosal2$mktval), ceosal2$profits) #Q8d. 

#Q8a. log(salary) = 4.62092 + 0.16213 log(sales) + 0.10671 log(mktval)
#Q8b. Profits contain negative values, hence cannot use log. 
      #R-Squared value is 0.2933. Most of variation is not explained. 
#Q8c. This indicates that each additional year of CEO increases the salary by 1.16%
#Q8d. Correlation = 0.77. This is fairly high. Also, this is why upon adding profits to the model there was no significant improvement to R-Squared value.
      #However, this causes no bias in the model. 

# ----------------------------------------------------------------------------------------------------------------------------------

#Problem 1.9: Attend.RAW: 
con <- SQLite() %>%
  dbConnect('wooldridge.db')
con %>% dbListTables()
attend <- con%>% dbReadTable('attend')%>% data.table
con %>% dbReadTable('attend_labels')

summary(attend) #Q9a. 
model9a <- lm(atndrte~priGPA+ACT, data = attend)
summary(model9a) #Q9b. 

StudA <-predict(model9a, data.frame(priGPA=3.1, ACT=21)) 
StudB <- predict(model9a, data.frame(priGPA=2.1, ACT=26))
StudA - StudB #Q9d.


#Q9a. atndrte - min = 6.25; max= 100. Avg = 81.71. 
    #priGPA - min=0.857, max=3.930, Avg = 2.587. 
    #ACT min = 13, max=32, Avg= 22.51. 
#Q9b. atndrte = 75.7 + 17.261priGPA - 1.717ACT. 
     #The intercept of 75.7 indicates that the attendace percentage is 75.7 when priGPA and ACT scores are 0. 
#Q9c. The slope coefficient priGPA indicates that for every one point increase in prior GPA, attendance percentage increase by 17.2%. 
     #However, The ACT scores indicate that for every mark increase in the test score, the attendance percentage decreases by 1.7%. 
     # This is surprising as it suggests that people who do well in ACT exams tend to have lower attendance.
#Q9d. StudA = 93.16. StudB = 67.31. Thus difference in attendance rates is 25.84. 

# ----------------------------------------------------------------------------------------------------------------------------------

#Problem 1.10: HTV. RAW: 

htv <- con%>% dbReadTable('htv')%>% data.table
con%>% dbReadTable('htv_labels')

summary(htv$educ)
sum(as.numeric(htv$educ==12))/nrow(data.frame(htv$educ))
summary(htv$fatheduc)
summary(htv$motheduc) #Q10a. 

model10a <- lm(educ ~ motheduc+fatheduc, data = htv)
summary(model10a)#Q10b. 

model10b <- lm(educ ~ motheduc+fatheduc+abil, data = htv)
summary(model10b)#Q10c. 

abilq= htv$abil*htv$abil
model10c <-lm(educ ~ motheduc+fatheduc+abil+abilq, data = htv) 
summary(model10c) #Q10d. 

sum(as.numeric(htv$abil <=-4.01)) #Q10e. 




#Q10a. Highest grade completed ranges from the number 6 to 20. 
      # Percentage of people with completed 12th grade is 41.6%. 
      # Men have mean of 13 years of educ while fathers = 12.45 and mothers = 12.18
#Q10b. educ = 6.964 + 0.3042 motheduc + 0.1909 fatheduc + e. 
      # R-squared = 0.24. About 24% of sample variation is explained by father and mother education. 
#Q10c. educ = 8.44 + 0.189 motheduc + 0.111 fatheduc + 0.502 abil+ e. 
     # Abil explains the variation in education. This is seen from the significance rating as well as the improvement in the R-Squared value. 
#Q10d. educ = 8.240 + 0.1901 motheduc + 0.1089 fatheduc + 0.4014 abil + 0.0505 abilq 
       #d(educ) = 0. and  d(abil) = 0.4014 + 2*0.0505 abilq 
       #d(abil) = 0.401 + 0.10 abil 
       # abil* = -4.01. 

#Q10e. # There are only 14 people with ability less than -4.01.
#Q10f. #.educ = 8.240 + 0.190*12.18 + 0.108*fatheduc + 0.401 abil  + 0.0505 abilq. 
       # educ = 12.01 + 0.401 abil + 0.0505 abilq. 

educ1 <- as.vector(htv$educ)
abil1 <- as.vector(htv$abil)
plot(abil1,12.01+0.401*abil1+0.0505*I(abil1^2))

x <- ggplot(htv,aes(x=abil, y=educ)) + geom_point(shape=1)
x <- x + geom_line(data = htv,aes(x=abil,y = 12.01+0.401*abil1+0.0505*I(abil1^2)))
x
y <- ggplot(htv,aes(x=abil,y = 12.01+0.401*abil1+0.0505*I(abil1^2))) + geom_line()
y

remove(x)
#educ1 <- as.vector(htv$educ)
#abil1 <- as.vector(htv$abil)
#plot(abil1,12.01+0.401*abil1+0.0505*I(abil1^2))


