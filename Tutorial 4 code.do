cd "C:\Users\CHANDRA MAHARSHI\Desktop\Tutorial 4"

use "C:\Users\CHANDRA MAHARSHI\Desktop\Tutorial 4\dataEmpBF_Tutorial4.dta", clear

**Question 1(a)

twoway (line private_credit_past year if c== "United States") (line private_credit_past year if c== "United Kingdom"), scheme(s1color) name(graph1, replace) ///
title("plot 1") legend(label(1 "United States") label(2 "United Kingdom")) ytitle(private_credit_past) xtitle(year)

twoway (line private_credit_past year if c== "Netherlands") (line private_credit_past year if c== "Hong Kong"), scheme(s1color) name(graph1, replace) ///
title("plot 2") legend(label(1 "Netherlands") label(2 "Hong Kong")) ytitle(private_credit_past) xtitle(year)

**Question 2(a)

reg unrate_Fd3 household_credit_past, cluster(CountryCode)

**Question 2(b)

reg unrate_Fd3 household_credit_past unrate_d1 unrate_d2 unrate_d3 unrate_d4 unrate_d5, vce(cluster CountryCode) 

**Question 2(c)

reghdfe unrate_Fd3 household_credit_past unrate_d1 unrate_d2 unrate_d3 unrate_d4 unrate_d5, absorb(CountryCode)

reghdfe unrate_Fd3 firm_credit_past unrate_d1 unrate_d2 unrate_d3 unrate_d4 unrate_d5, absorb(CountryCode)

**Question 2(f)

reghdfe lnGDP_Fd1 household_credit_past lnGDP_d1 lnGDP_d2 lnGDP_d3 lnGDP_d4 lnGDP_d5, absorb(CountryCode) cluster(CountryCode)
est store reg1

reghdfe lnGDP_Fd2 household_credit_past lnGDP_d1 lnGDP_d2 lnGDP_d3 lnGDP_d4 lnGDP_d5, absorb(CountryCode) cluster(CountryCode)
est store reg2

reghdfe lnGDP_Fd3 household_credit_past lnGDP_d1 lnGDP_d2 lnGDP_d3 lnGDP_d4 lnGDP_d5, absorb(CountryCode) cluster(CountryCode)
est store reg3

reghdfe lnGDP_Fd4 household_credit_past lnGDP_d1 lnGDP_d2 lnGDP_d3 lnGDP_d4 lnGDP_d5, absorb(CountryCode) cluster(CountryCode)
est store reg4

reghdfe lnGDP_Fd5 household_credit_past lnGDP_d1 lnGDP_d2 lnGDP_d3 lnGDP_d4 lnGDP_d5, absorb(CountryCode) cluster(CountryCode)
est store reg5

reghdfe lnGDP_Fd6 household_credit_past lnGDP_d1 lnGDP_d2 lnGDP_d3 lnGDP_d4 lnGDP_d5, absorb(CountryCode) cluster(CountryCode)
est store reg6

reghdfe lnGDP_Fd7 household_credit_past lnGDP_d1 lnGDP_d2 lnGDP_d3 lnGDP_d4 lnGDP_d5, absorb(CountryCode) cluster(CountryCode)
est store reg7

reghdfe lnGDP_Fd8 household_credit_past lnGDP_d1 lnGDP_d2 lnGDP_d3 lnGDP_d4 lnGDP_d5, absorb(CountryCode) cluster(CountryCode)
est store reg8

reghdfe lnGDP_Fd9 household_credit_past lnGDP_d1 lnGDP_d2 lnGDP_d3 lnGDP_d4 lnGDP_d5, absorb(CountryCode) cluster(CountryCode)
est store reg9

reghdfe lnGDP_Fd10 household_credit_past lnGDP_d1 lnGDP_d2 lnGDP_d3 lnGDP_d4 lnGDP_d5, absorb(CountryCode) cluster(CountryCode)
est store reg10

esttab reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 reg9 reg10, se

**Question 3(a)

reg logGDP_future private_credit_past, robust

reghdfe logGDP_future private_credit_past, absorb(CountryCode) cluster(CountryCode)

reghdfe logGDP_future private_credit_past, absorb(CountryCode year) vce(cluster CountryCode year)

egen country_year = group(CountryCode year)
reg logGDP_future private_credit_past, cluster(country_year)

**Question 4(a)

reghdfe unrate_Fd3 household_credit_past unrate_d1 unrate_d2 unrate_d3 unrate_d4 unrate_d5 , absorb(CountryCode year) vce(cluster CountryCode)

