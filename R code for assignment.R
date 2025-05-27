install.packages("haven")
install.packages("survey")
library(haven)
library(stargazer)
library(tidyverse)
library(survey)

Data_block1 <- read_dta('C:/Users/CHANDRA MAHARSHI/Downloads/Block - 1 Identification of sample household - level 1.dta')
View(Data_block1)
Data_block3 <- read_dta('C:/Users/CHANDRA MAHARSHI/Downloads/Block - 3 Household characteristics - level 2.dta')
View(Data_block3)
Data_block4 <- read_dta('C:/Users/CHANDRA MAHARSHI/Downloads/Block - 4 Particulars of living facilities - drinking water, bathroom, sanitation etc - level 4.dta')
View(Data_block4)
Data_block3L3 <- read_dta('C:/Users/CHANDRA MAHARSHI/Downloads/Block - 3  Household characteristics - level 3.dta')
View(Data_block3L3)



#Merging the data
intersect(names(Data_block3), names(Data_block4))
dot <- list(Data_block1, Data_block3, Data_block3L3, Data_block4)
f1 <- function(x){x <- subset(x, select = -c(`Centre_Round`,`Round`, `Sch_no`,              
                                               `Sample`, `Sector`,`State_region`,`District`,`Stratum`, 
                                               `Sub_Stratum_No`, `Sub_Round`, `Sub_Sample`,           
                                               `FOD_Sub_region`, `Hg_sb_no`,`Level`, 
                                               `NSS`, `NSC`,`SSC`))
}


dot <- lapply(dot, f1)

dot <- dot %>% reduce(full_join)
View(dot)
glimpse(dot)
summary(dot)
sum(dot$Combined_Weight)

data <- svydesign(ids = ~1, data = dot, weights= dot$Combined_Weight)


#####################################

a1 <-Merged %>% 
  drop_na(Sector) %>% 
  select(Sector) %>% 
  filter(Sector==1)
a1
count(a1)
a2 <-Merged %>% 
  drop_na(Sector) %>% 
  select(Sector) %>% 
  filter(Sector==2)

a3 <- dot %>% 
  drop_na(b3_q12) %>% 
  select(b3_q12) %>% 
  filter(b3_q12==3)

a4 <-b1 %>% 
  drop_na(b4_q6) %>% 
  select(b4_q6) %>% 
  filter(b4_q6==5)


c1 <-Merged %>% 
  drop_na(b3_q24) %>% 
  select(b3_q24)

#Subsetting the data form dot data set
b1 <- dot %>%
  drop_na(b4_q7,b4_q8,b3_q12,b4_q6, b3_q22, Combined_Weight) %>% 
  select(b4_q7,b4_q8, b3_q12, b4_q6, b3_q22, Combined_Weight)

Time_taken_access_water <- b1[,1] + b1[,2]
b1$Time_taken_access_water <- Time_taken_access_water
b1
b1 %>% 
  filter(b4_q6 == 5)
plot(b1$b4_q6, Time_taken_access_water)


ST <- as.numeric(b1$b3_q12 == 1,1,0)
SC <- as.numeric(b1$b3_q12 ==2,1,0)
Other_backward <- as.numeric(b1$b3_q12 ==3,1,0)
Other_caste <- as.numeric(b1$b3_q12 == 9,1,0)
Male_below_18 <- as.numeric(b1$b4_q6 ==1,1,0)
Male_above_18 <- as.numeric(b1$b4_q6 ==2,1,0)
Female_below_18 <- as.numeric(b1$b4_q6 ==3,1,0)
Female_above_18 <- as.numeric(b1$b4_q6 ==4,1,0)
non_mem_of_house <- as.numeric(b1$b4_q6 ==5,1,0)
Others <-  as.numeric(b1$b4_q6 ==6,1,0)


dot$b4_q6 <- as.numeric(dot$b4_q6)
w <- b1$Combined_Weight

v <- dot$b4_q6
hist(v, xlab= "Who goes for fetching")

dot$b4_q1 <- as.numeric(dot$b4_q1)
v1 <- Merged$b4_q1
hist(v1, xlab= "Prin")

Merged %>%
  ggplot(aes(factor(Merged$b4_q1), fill = factor(Merged$b4_q1)))+ 
  geom_bar()+ 
  labs(title= "Prinicpal source of driniking water",
       x = "Principal sources of drinking water",
       y = "Count")
  

#Basic model

model1 <-lm(Time_taken_access_water$b4_q7 ~ Male_below_18+ Male_above_18
          + Female_above_18 +non_mem_of_house +Others ,  data = b1 , weights= b1$Combined_Weight)
summary(model1)
abline(model1)

# Multiple regression
model2 <- lm(Time_taken_access_water$b4_q7 ~ SC + ST + Other_backward + Male_below_18 + Male_above_18 +Female_below_18
          + Female_above_18 + non_mem_of_house ,  data = b1, weights=b1$Combined_Weight)
summary(model2)

#With interaction term
model3 <-lm(Time_taken_access_water$b4_q7 ~ SC + ST + Other_backward+ Male_below_18+Male_above_18 +Female_below_18
          +non_mem_of_house +Female_above_18 + SC*Female_below_18 + SC*Male_below_18,  data = b1 , weights=b1$Combined_Weight)
summary(model3)
abline(model3)

plot(b1$b3_q12, Time_taken_access_water$b4_q7)
b1$b3_q12 <- as.numeric(b1$b3_q12)
cor(Time_taken_access_water$b4_q7, b1$b3_q12)
hist(model1$residuals, xlab= "Residuals", title = "Histogram of Residuals")
plot(model1$residuals, Time_taken_access_water$b4_q7)


stargazer(model1,model2,model3, type = "html", out = "Time spent for drinking water access.html")

stargazer(model1, model2, model3, type = "html",
          title = "models",
          header = T,
          column.labels = c("OLS","Including caste variables","Including interaction terms"),
          df= T,
          fontsize = "small",
          digits = 3,
          out = "timespent-wateraccess.html")
#1 
abline(plot(model1$residuals, model1$fitted.values))
hist(model1$residuals)


