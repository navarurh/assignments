setwd("/home/navarurh/documents/utd/bawr/lec1/")
library(data.table)
library(DBI)
library(RSQLite)
library(tidyverse)

## Read the BWGHT.csv example into the variable churn
con <- SQLite() %>% dbConnect('wooldridge.db')
con %>% dbListTables
wage <- con %>% dbReadTable('wage1') %>% data.table
con %>% dbReadTable('wage1_labels')
con %>% dbDisconnect

#start of assignment


#1.1 Use the data in WAGE1.RAW for this exercise.
#(i) Find the average education level in the sample. What are the lowest and highest years of education?
mean(wage$educ) #the mean years of education is 12.56  years pointing to the fact that most people stopped after getting a high school education
min(wage$educ) #the minimum is 12 years of education
max(wage$educ) #the maximum is 18 years of education


summary(wage$wage)
#(ii) Find the average hourly wage in the sample. Does it seem high or low?
mean(wage$wage) #the mean wage is $5.90/hr which is 250% higher than the reported $2.3/hr for 1976 as per www.dol.gov

#--------------------------------------------------------------------------------------#
#(iii) The wage data are reported in 1976 dollars. Using the Economic Report of the
#President (2011 or later), obtain and report the Consumer Price Index (CPI) for
#the years 1976 and 2010.

#--------------------------------------------------------------------------------------#  
#(iv) Use the CPI values from part (iii) to find the average hourly wage in 2010 dollars.
#Now does the average hourly wage seem reasonable?

#(v) How many women are in the sample? How many men?
table(wage$female)
# 0   1 
# 274 252 
# the given sample has 252 women and 274 men





con <- SQLite() %>% dbConnect('wooldridge.db')
meap <- con %>% dbReadTable('meap01') %>% data.table
con %>% dbReadTable('meap01_labels')
con %>% dbDisconnect

# 1.2 The data in MEAP01.RAW are for the state of Michigan in the year 2001. Use these
# data to answer the following questions.
# (i) Find the largest and smallest values of math4. Does the range make sense?
# Explain.
min(meap$math4) #0
max(meap$math4) #100
# the min value is 0 and the max value 100; the range is sensible as it is measuring the pass rate for 4th grade math for schools in michigan

# (ii) How many schools have a perfect pass rate on the math test? What percentage is
# this of the total sample?
cnt_school <- nrow(meap) #1823 total schools in the sample
cnt_school_perfect_math4 <- nrow(meap[which(meap$math4 == 100),]) #38 schools have a perfect pass rate in math4
cnt_school_perfect_math4/cnt_school*100 # approx 2.08% of the schools have a perfect math4 pass rate in michigan

# (iii) How many schools have math pass rates of exactly 50%?
nrow(meap[which(meap$math4 == 50),]) #17 schools have an exact 50% pass rate in math4

# (iv) Compare the average pass rates for the math and reading scores. Which test is
# harder to pass?
mean(meap$math4) #71.91%
mean(meap$read4) #60.06%
# looking at the average pass rates in the two subjects across 1823 michigan schools, we could argue a case for read4/reading to be a harder course to pass

# (v) Find the correlation between math4 and read4. What do you conclude?
cor(meap$read4,meap$math4) #0.8427281
# a high correlation of 0.843 argues that schools with a good math pass rate will also boast a good reading pass rate

# (vi) The variable exppp is expenditure per pupil. Find the average of exppp along
# with its standard deviation. Would you say there is wide variation in per pupil
# spending?
summary(meap$exppp) #min is 1207, max is 11960
mean(meap$exppp) #5194.865
sd(meap$exppp) #1091.89

#--------------------------------------------------------------------------------------#
# (vii) Suppose School A spends $6,000 per student and School B spends $5,500 per
# student. By what percentage does School A’s spending exceed School B’s? Com-
#   pare this to 100 · [log(6,000) – log(5,500)], which is the approximation percent-
#   age difference based on the difference in the natural logs. (See Section A.4 in
#                                                                Appendix A.)




con <- SQLite() %>% dbConnect('wooldridge.db')
k401 <- con %>% dbReadTable('401k') %>% data.table
con %>% dbReadTable('401k_labels')
con %>% dbDisconnect

summary(k401)

# 1.3 The data in 401K.RAW are a subset of data analyzed by Papke (1995) to study the rela-
#   tionship between participation in a 401(k) pension plan and the generosity of the plan.
# The variable prate is the percentage of eligible workers with an active account; this is
# the variable we would like to explain. The measure of generosity is the plan match rate,
# mrate. This variable gives the average amount the firm contributes to each worker’s
# plan for each $1 contribution by the worker. For example, if mrate 5 0.50, then a $1
# contribution by the worker is matched by a 50¢ contribution by the firm.
# (i) 	Find the average participation rate and the average match rate in the sample of
# plans.
mean(k401$prate) # 87.36% - average participation rate
mean(k401$mrate) # 0.732% - average match rate

# (ii) Now, estimate the simple regression equation
#  prate
#     5 b̂ 0 1 b̂ 1 mrate,
# and report the results along with the sample size and R-squared.

x <- lm(prate~mrate,k401)
summary(x)
# beta-0[y intercept] is at 83.0755 and beta-1[slope] is 5.8611
# r-squared is at 7.47% which is a really bad 
plot(k401$mrate,k401$prate)
#


# (iii) Interpret the intercept in your equation. Interpret the coefficient on mrate.