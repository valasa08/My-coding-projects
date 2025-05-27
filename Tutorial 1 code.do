*Working Directory
*Student IDs: 50202698, 

*Working directory
cd "C:\Users\CHANDRA LEKHA\Desktop\data for T1"

*Loading the required dataset
use "C:\Users\CHANDRA LEKHA\Desktop\data for T1\dataEmpBF_Tutorial1.dta"

*Question 1
*1(a) histogram of LHS variable
hist gdpgrowth, density title("Histogram of gdpgrowth")
 
*histogram of RHS variable
hist dbagdp, density title("Histogram of dbagdp")
 
*1(c) Regression 1
reg gdpgrowth dbagdp

*1(e) Plotting the Regression line with data
twoway (scatter gdpgrowth dbagdp) (lfit gdpgrowth dbagdp), name(Graph1, replace) 

*1(f) We notice there are outliers and a boxplot would portray the outliers clearly. We can also see how far the outliers are from the mean of the data. There are several ways to deal with outliers but in this case as there are typically only two outliers, an easy fix could be removing the outliers from the data.

*Boxplot for gdpgrowth
graph box gdpgrowth, title(Boxplot gdpgrowth)

*Boxplot for dbagdp
graph box dbagdp, title(Boxplot dbagdp)
 
*Labeling the outliers
graph box gdpgrowth, mark(1, mlabel(country)) name(graph2, replace)

graph box dbagdp, mark(1, mlabel(country)) name(graph3, replace)

*Dropping the outliers
drop if country== "CHN" | country== "JPN"

*1(g) Plotting the regression line without outliers in the data
twoway (scatter gdpgrowth dbagdp) (lfit gdpgrowth dbagdp)
 
**Question 2
*2(a) Regression 1 without any adjustments to standard errors
reg gdpgrowth dbagdp

*2(b) Regression 1 with robust option
reg gdpgrowth dbagdp, robust 

*2(c) Regression with vce(hc2) option
reg gdpgrowth dbagdp, vce(hc2)

**Question 3
*3(a) Auxiliary regression with stmktcap as control variable
reg dbagdp stmktcap

*3(b) Regression 2 (With adding another independent variale, stmktcap to Regression 1)
reg gdpgrowth dbagdp stmktcap

*3(c) Two step procedure
reg dbagdp stmktcap, robust
predict r, resid
reg gdpgrowth r, robust

**Question 4 - Rescaling variables
*4(a)
ge dbagdp2 = dbagdp*2
 
 *4(b)
reg gdpgrowth dbagdp2
 
 *4(c)
 ge dbagdp3 = dbagdp*3
 reg gdpgrowth dbagdp3
 
 *4(d)
 ge dbagdp4 = dbagdp*4
 reg gdpgrowth dbagdp4
 
 *4(e)
 ge gdpgrowth2 = gdpgrowth*2
 reg gdpgrowth2 dbagdp
 
 *4(f)
 ge gdpgrowth3 = gdpgrowth*3
 reg gdpgrowth3 dbagdp


 
 