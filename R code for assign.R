library(tidyverse)
library(readr)
Suicides_data <- read_csv("C:/Users/CHANDRA MAHARSHI/Downloads/crimedata_suicides.csv")
View(Suicides_data)
names(Suicides_data)
attributes(Suicides_data)
attach(Suicides_data)

MAHARASHTRA <-Suicides_data %>% 
  filter(STATE.UT == 'MAHARASHTRA')
View(MAHARASHTRA)

length(MAHARASHTRA)
MAHARASHTRA %>% 
  select(STATE.UT,Year, CAUSE,Male.upto.14.years,Male.15.29.years,Male.30.44.years,Male.45.59.years,
         Male.60.years.and.above,Total.Male, Female.upto.14.years,Female.15.29.years,Female.30.44.years,Female.45.59.years,
         Female.60.years.and.above,Total.Female,Grand.Total) %>% 
  View()

Y1 <- MAHARASHTRA %>% 
  filter(Year == 2001)
R1 <-Y1[12,]

library(ggplot2)

Gender <- c("Male", "Female", "Transgenders")
Total_Suicides <- c(145474, 67841, 3)
df5 <- data.frame(Gender,Total_Suicides)

df5 %>% 
  ggplot(aes(x = reorder(Gender, -Total_Suicides), y = Total_Suicides))+
  geom_bar(stat = "identity", width = 0.5,  colour = "#111DDF")+
  geom_text(aes(label = Total_Suicides), vjust = -0.3)+
  labs(title = "Suicides by Gender from 2001 to 2014",
       x = "Causes for Suicides",
       y = "Total Suicides")



##220 
unique(CAUSE)
library(pastecs)
stat.desc(MAHARASHTRA)
MAHARASHTRA %>% 
  filter(Year == 2002) %>%
  View()

a2 <-MAHARASHTRA %>% 
  filter(Year == 2003)
a2

MAHARASHTRA %>% 
  filter(Year == 2004) %>% 
  View()

MAHARASHTRA %>% 
  filter(Year == 2005) %>% 
  View()

MAHARASHTRA %>% 
  filter(Year == 2006) %>% 
  View()
max(MAHARASHTRA$Grand.Total)
unique(MAHARASHTRA$transgender.60.years.and.above)
sum(MAHARASHTRA$Grand.Total)
a1 <-head(MAHARASHTRA)
a1

#Question 1
#Which gender's suicides are higher?
attach(MAHARASHTRA)

D1 <-MAHARASHTRA %>% 
  filter(CAUSE == 'Total')
View(D1)
T1 <-sum(D1$Grand.Total)
sum(D1$Total.Female)
sum(D1$Total.Male)
D1 %>% 
  drop_na(total.transgender)
unique(CAUSE)

D2 <-MAHARASHTRA %>% 
  filter(CAUSE == 'Farming/Agriculture Activity')
sum(D2$Grand.Total)

D3 <-MAHARASHTRA %>% 
  filter(CAUSE == 'Housewife')
sum(D3$Grand.Total)

D4 <-MAHARASHTRA %>% 
  filter(CAUSE == 'Student')
sum(D4$Grand.Total)

D5 <-MAHARASHTRA %>% 
  filter(CAUSE == 'Retired Person')
sum(D5$Grand.Total)

D6 <-MAHARASHTRA %>% 
  filter(CAUSE == 'Agricultural Labourers')
sum(D6$Grand.Total)

D7 <-MAHARASHTRA %>% 
  filter(CAUSE == 'Professional Activity')
sum(D7$Grand.Total)

D8 <-MAHARASHTRA %>% 
  filter(CAUSE == 'Public Sector Undertaking')
sum(D8$Grand.Total)

D9 <-MAHARASHTRA %>% 
  filter(CAUSE == 'Self-employed (Business activity)')
sum(D9$Grand.Total)

D10 <-MAHARASHTRA %>% 
  filter(CAUSE == 'Service (Government)')
sum(D10$Grand.Total)

D11 <-MAHARASHTRA %>% 
  filter(CAUSE == 'Service (Private)')
sum(D11$Grand.Total)

D12 <-MAHARASHTRA %>% 
  filter(CAUSE == 'Unemployed')
sum(D12$Grand.Total)

D13 <-MAHARASHTRA %>% 
  filter(CAUSE == 'Central/UT Govt. Servants')
sum(D13$Grand.Total)

D14 <-MAHARASHTRA %>% 
  filter(CAUSE == 'Daily Wage Earner')
sum(D14$Grand.Total)

D15 <-MAHARASHTRA %>% 
  filter(CAUSE == 'Have Own Land')
sum(D15$Grand.Total)

D16 <-MAHARASHTRA %>% 
  filter(CAUSE == 'On Contract/Lease')
sum(D16$Grand.Total)

D17 <-MAHARASHTRA %>% 
  filter(CAUSE == 'Others')
sum(D17$Grand.Total)

D18 <-MAHARASHTRA %>% 
  filter(CAUSE == 'Private Sector Enterprises')
sum(D18$Grand.Total)

D19 <-MAHARASHTRA %>% 
  filter(CAUSE == 'State Govt. Servants')
sum(D19$Grand.Total)

D20 <-MAHARASHTRA %>% 
  filter(CAUSE == 'Vendor')
sum(D20$Grand.Total)

D21 <-MAHARASHTRA %>% 
  filter(CAUSE == 'Tradesmen')
sum(D21$Grand.Total)

D22 <-MAHARASHTRA %>% 
  filter(CAUSE == 'Other Statutory Body/etc.')
sum(D22$Grand.Total)

D23 <-MAHARASHTRA %>% 
  filter(CAUSE == 'Others (Please Specify)')
sum(D23$Grand.Total)



C1 <- MAHARASHTRA %>% 
  filter(CAUSE == 'Total')
sum(C1$Male.upto.14.years)

sum(C1$Male.15.29.years)
sum(C1$Male.30.44.years)
sum(C1$Male.45.59.years)
sum(C1$Male.60.years.and.above)


sum(C1$Female.upto.14.years)

sum(C1$Female.15.29.years)
sum(C1$Female.30.44.years)
sum(C1$Female.45.59.years)
sum(C1$Female.60.years.and.above)

Categories <- c("Farming/Agriculture Activity","Housewife","Others (Please Specify)","Service (Private)","Unemployed","Student","Professional Activity","Self-employed (Business activity)","Service (Government)","Others","Daily Wage Earner",
                "Public Sector Undertaking","Retired Person","Private Sector Enterprises","State Govt. Servants","Tradesmen","Vendor","Other Statutory Body/etc.","Central/UT Govt. Servants")             
Total_Suicides <- c(51919,48328,37139,22038,13464,12773,7095,6487,3144,2584,2239,2213,2060,1183,195,137,115,114,91)
df6 <- data.frame(Categories,Total_Suicides)

Graph1 <-df6 %>% 
  ggplot(aes(x= reorder(Categories, -Total_Suicides), y= Total_Suicides))+
  geom_bar(stat = "identity", colour= "#111DDF")+
  theme(axis.text.x = element_text(angle = 90))+
    labs(title = "Total Suicides by categories(2001-14)",
       x = "Categories",
       y = "Total Suicides")
Graph1



age_groups_for_males <- c("Male.upto.14.years", "Male.15.29.years", "Male.30.44.years",
                "Male.45.59.years", "Male.60.years.and.above")
Male_Suicides <- c(1000, 44714,54398,31928,13434)
df5 <- data.frame(age_groups_for_males, Male_Suicides)

Graph2 <- df5 %>% 
  ggplot(aes(age_groups_for_males, Male_Suicides))+
  geom_bar(stat = "identity", colour = "#111DDF")+
  theme(axis.text.x = element_text(angle = 90))+
  geom_text(aes(label = scales::percent(Male_Suicides/145474)), vjust = -0.3)+
  labs(title = "Distribution of male suicides by age group",
       x = "Age groups",
       y = "Total Male Suicides")
Graph2


age_groups_for_Females <- c("Female.upto.14.years", "Female.15.29.years", "female.30.44.years",
                          "Female.45.59.years", "Female.60.years.and.above")
Female_Suicides <- c( 1229, 35921,19093,7460,4138)
df4 <- data.frame(age_groups_for_males, Female_Suicides)

Graph3 <- df4 %>% 
  ggplot(aes(age_groups_for_Females, Female_Suicides))+
  geom_bar(stat = "identity", colour = "#111DDF")+
  theme(axis.text.x = element_text(angle = 90))+
  geom_text(aes(label = scales::percent(Female_Suicides/67841)), vjust = -0.3)+
  labs(title = "Distribution of female suicides by age group",
       x = "Age groups",
       y = "Total Female Suicides")
Graph3


H1 <- MAHARASHTRA %>% 
  filter(CAUSE == 'Housewife')
H1
Y2 <- H1$Grand.Total
X1 <- c("2001",2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014)
df2 <- data.frame(X1,Y2)
Graph4 <- df2 %>% 
  ggplot(aes(X1,Y2))+
  geom_bar(stat="identity", colour="#111DDF")+
  labs(title = "Trend of Housewives Suicides in Maharashtra",
       x = "Years",
       y = "Total Suicides")
Graph4

S1 <- MAHARASHTRA %>% 
  filter(CAUSE == 'Student')
S1
Y2 <- S1$Grand.Total
X1 <- c(C1$Year)
df2 <- data.frame(X1,Y2)

plot(X1, Y2, type = "b", pch = 19, main= "Trend of Student Suicides in Maharashtra(2001-14)",
     ylab= "Total Student Suicides", xlab= "Year", xaxt = "n")
axis(1, at = seq(round(min(X1)), round(max(X1))), labels = 2001:2014)

F2 <- MAHARASHTRA %>% 
  filter(CAUSE == 'Farming/Agriculture Activity'| CAUSE == 'Agriculture (Total)')
F2
Y2 <- F2$Grand.Total
X1 <- c(F2$Year)
df2 <- data.frame(X1,Y2)

plot(X1, Y2, type = "b", pch = 19, main= "Trend of Farmer Suicides in Maharashtra(2001-13)",
     ylab= "Total Farmer Suicides", xlab= "Year", xaxt = "n")
axis(1, at = seq(round(min(X1)), round(max(X1))), labels = 2001:2014)

mean(F2$Grand.Total)
mean(S1$Grand.Total)




Y2 <- C1$Total.Male
X1 <- c(C1$Year)
df2 <- data.frame(X1,Y2)
plot(X1, Y2, type = "b", pch = 19, main= "Trend of total Male Suicides(2001-14)",
     ylab= "Total Male Suicides", xlab= "Year", xaxt = "n")
axis(1, at = seq(round(min(X1)), round(max(X1))), labels = 2001:2014)



Y2 <- C1$Total.Female
X1 <- c(C1$Year)
df2 <- data.frame(X1,Y2)
plot(X1, Y2, type = "b", pch = 19, main= "Trend of total Female Suicides(2001-14)",
     ylab= "Total Female Suicides", xlab= "Year", xaxt = "n")
axis(1, at = seq(round(min(X1)), round(max(X1))), labels = 2001:2014)


#Table
Categories <- c("Farming/Agriculture Activity","Housewife","Others (Please Specify)","Service (Private)","Unemployed","Student","Professional Activity","Self-employed (Business activity)","Service (Government)","Others","Daily Wage Earner",
                "Public Sector Undertaking","Retired Person","Private Sector Enterprises","State Govt. Servants","Tradesmen","Vendor","Other Statutory Body/etc.","Central/UT Govt. Servants", "TOTAL SUICIDES(2001-14)")             
Total_Suicides <- c(51919,48328,37139,22038,13464,12773,7095,6487,3144,2584,2239,2213,2060,1183,195,137,115,114,91, 213318)
df9 <- data.frame(Categories,Total_Suicides)

#For age groups

age_groups <- c("People.upto.14.years", "People.15.29.years", "people.30.44.years",
                            "people.45.59.years", "people.60.years.and.above")
Total_Suicides <- c( 2229, 80637,73492,39388,17572)
df10 <- data.frame(age_groups, Male_Suicides)

Graph7 <- df10 %>% 
  ggplot(aes(age_groups, Total_Suicides))+
  geom_bar(stat = "identity", colour = "#111DDF")+
  theme(axis.text.x = element_text(angle = 90))+
  geom_text(aes(label = scales::percent(Total_Suicides/213318)), vjust = -0.3)+
  labs(title = "Distribution of total suicides by age group",
       x = "Age groups",
       y = "Total Suicides")
Graph7

Sub1 <- Suicides_data %>% 
  filter(STATE.UT == 'TOTAL (ALL INDIA)')

Sub2 <- Sub1 %>% 
  filter(CAUSE =='Total')
sum(Sub2$Grand.Total)
sum(C1$Grand.Total)

New_Maharashtra <- MAHARASHTRA %>%
  mutate(CAUSE = recode(CAUSE,
                        "Agriculture (Total)" = "Farming/Agriculture Activity"))







  

