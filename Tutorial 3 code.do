*Tutorial 3
*Setting the working directory
cd "C:\Users\CHANDRA MAHARSHI\Desktop\Tutorial 3"

*Loading the dataset
use "C:\Users\CHANDRA MAHARSHI\Desktop\Tutorial 3\dataEmpBF_Tutorial3.dta", replace
 
br

*Question 2(a)
*Individual plots for all the legor categories
catplot legor_uk

catplot legor_fr

catplot legor_so

catplot legor_ge

catplot legor_sc

*This gives the bar graph of frequencies for all legor categories 
graph bar (sum) legor_uk (sum) legor_fr (sum) legor_so (sum) legor_ge (sum) legor_sc, blabel(bar)


*Question 2(b)

gen liq_uk = liq_liab_t_gdp_1960  if legor_uk == 1

gen liq_fr = liq_liab_t_gdp_1960  if legor_fr == 1

gen liq_so = liq_liab_t_gdp_1960  if legor_so == 1

gen liq_ge = liq_liab_t_gdp_1960  if legor_ge == 1

gen liq_sc = liq_liab_t_gdp_1960  if legor_sc == 1

*This gives the summary statistics of liquid liabilities to GDP in 1960 for all legor categories
sum liq_uk liq_fr liq_so liq_ge liq_sc

*Question 3(a)

reg gdpgrowth liq_liab_t_gdp_1960

*Question 3(b)

*Equation 1
mean(gdpgrowth) if legor_fr == 1

*Equation 2 
mean(gdpgrowth) if legor_fr == 0

*Equation 3
mean(liq_liab_t_gdp_1960) if legor_fr == 1

*Equation 4  
mean(liq_liab_t_gdp_1960) if legor_fr == 0

*Wald estimator is equal to (equation 1-equation 2)/ (equation 3 - equation 4)

*Question 3(c)

*Step 1
reg gdpgrowth liq_liab_t_gdp_1960, robust

*Step 2
ivregress 2sls gdpgrowth (liq_liab_t_gdp_1960 =legor_fr)

*Question 3(e)
reg liq_liab_t_gdp_1960 legor_fr, robust 
 
*Question 4(a)

ivregress 2sls gdpgrowth loggdp_1960 (liq_liab_t_gdp_1960 =legor_fr), robust

*Question 4(c)

reg liq_liab_t_gdp_1960 legor_uk legor_fr legor_so legor_ge loggdp_1960, robust

*Question 4(e)

*Modified regression
reg gdpgrowth liq_liab_t_gdp_1960 loggdp_1960 c.liq_liab_t_gdp_1960#c.loggdp_1960, robust

*2SLS version
ssc install ivreg2
ssc install ranktest 

*2SLS version of modified regression
ivreg2 gdpgrowth (c.liq_liab_t_gdp_1960#c.loggdp_1960 liq_liab_t_gdp_1960 = c.loggdp_1960#c.legor_fr legor_fr), robust

*Question 5(a)
ivreg2 gdpgrowth (liq_liab_t_gdp_1960 = legor_uk legor_fr legor_so legor_ge), robust

*Question 5(b)



