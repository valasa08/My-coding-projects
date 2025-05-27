clear all

cd "C:\Users\tbsko\sciebo\Lehre\Uni Bonn\Empirical_Banking\Tutorials\2_Interaction effects - Körner2011"

*------------------------------------
// 2. Baseline regression without interactions
*------------------------------------

* 2 b)
use  dataEmpBF_Tutorial2
reg gdpgrowth public_banks_1970 loggdp_1960, robust
est store reg2b
esttab reg2b using "C:\Users\tbsko\sciebo\Lehre\Uni Bonn\Empirical_Banking\Tutorials\2_Interaction effects - Körner2011/Discussion/2024/tab_reg1b.tex",  tex replace stats(N r2, labels("Number Observations" "$ R^2 $"))

*2 e)

reg gdpgrowth public_banks_1970 loggdp_1960, robust beta 

*------------------------------------
//3. Motivating the Interaction Term
*------------------------------------

*3 c) 
xtile private_credit_1960_terciles  = private_credit_1960,nquantiles(3)
local title1 "Low development"
local title2 "Medium development"
local title3 "High development"


*3 d) 
forval i = 1/3 {
twoway (scatter gdpgrowth public_banks_1970 if private_credit_1960_terciles==`i') (lfitci gdpgrowth public_banks_1970 if private_credit_1960_terciles==`i', title("`title`i''") name(g`i', replace) graphregion(color(white)) plotregion(color(white)) )
}

grc1leg g1 g2 g3, graphregion(color(white)) plotregion(color(white)) 
graph rename scatterplots_credite_quantiles, replace
graph drop g1 g2 g3
graph export "C:\Users\tbsko\sciebo\Lehre\Uni Bonn\Empirical_Banking\Tutorials\2_Interaction effects - Körner2011/Discussion/2024/scatterplots_credite_quantiles.png", replace as(png) 


*------------------------------------
// 4. Regression with interaction terms
*------------------------------------

** First we generate the interaction terms
gen pub_banks_1970_int_credit = c.public_banks_1970#c.private_credit_1960
gen loggdp1960_int_credit = c.loggdp_1960#c.private_credit_1960

*4 b)

** original regression equation
reg gdpgrowth pub_banks_1970_int_credit loggdp_1960, robust
est store reg4b_1

** including all constitutive terms
reg gdpgrowth pub_banks_1970_int_credit  private_credit_1960 public_banks_1970 loggdp_1960, robust
est store reg4b_2

** interact control with public bank variable
reg gdpgrowth pub_banks_1970_int_credit loggdp1960_int_credit  private_credit_1960 public_banks_1970 loggdp_1960, robust
est store reg4b_3
 
** Compare all regression results in one table
esttab reg4b_* using "C:\Users\tbsko\sciebo\Lehre\Uni Bonn\Empirical_Banking\Tutorials\2_Interaction effects - Körner2011/Discussion/2024/tab_reg2_int.tex",  tex replace stats(N r2, labels("Number Observations" "$ R^2 $")) varlabels(pub_banks_1970_int_credit "Interaction private credit w/ public banks" loggdp1960_int_credit "Interaction private credit w/ Log GDP 1960" loggdp_1960 "Log GDP 1960" private_credit_1960 "Private credit 1960" public_banks_1970 "Public bank share 1970") 

* 4 c)
reg gdpgrowth c.public_banks_1970##c.private_credit_1960 loggdp_1960, robust
margins, dydx(public_banks_1970)

reg gdpgrowth c.public_banks_1970##c.private_credit_1960 c.loggdp_1960##c.private_credit_1960, robust
margins, dydx(public_banks_1970)

* 4 d) 

** First we get the different percentile values
su private_credit_1960, d
local p5 = `r(p5)'
local p25 =  `r(p25)'
local p50 =   `r(p50)'
local p75 =  `r(p75)'
local p95 =  `r(p95)'
local meaner = `r(mean)'

** The regression with all constitutive terms but without gdp interacted with share of public banks
reg gdpgrowth c.public_banks_1970##c.private_credit_1960 loggdp_1960, robust
margin, dydx(public_banks_1970) at(private_credit_1960 = (`p5' `p25' `p50' `p75'  `p95' `meaner')) 
marginsplot, name(g1, replace) graphregion(fcolor(white)) bgcolor(white)   yline(0) level(90) ytitle("") xlabel(`p5' "P5" `p25' "P25" `p50' "P50" `p75' "P75"  `p95' "P95" `meaner' "Mean" )

** Instead we use the regression with gdp interacted with share of public banks
reg gdpgrowth c.public_banks_1970##c.private_credit_1960 c.loggdp_1960##c.private_credit_1960, robust

margin, dydx(public_banks_1970) at(private_credit_1960 = (`p5' `p25' `p50' `p75'  `p95' `meaner')) 
marginsplot, name(g2, replace) graphregion(fcolor(white)) bgcolor(white)   yline(0) level(90) ytitle("") xlabel(`p5' "P5" `p25' "P25" `p50' "P50" `p75' "P75"  `p95' "P95" `meaner' "Mean" )

graph rename margin_plot_pb_int_credit
graph export "C:\Users\tbsko\sciebo\Lehre\Uni Bonn\Empirical_Banking\Tutorials\2_Interaction effects - Körner2011/Discussion/2024/margin_plots_pub_banks_int_credit.png", replace as(png) 

*------------------------------------
//  5. Regression with Europe Dummy
*------------------------------------
* 5 a) 
reg gdpgrowth   loggdp_1960 public_banks_1970 europe c.loggdp_1960#i.europe  c.public_banks_1970#i.europe , robust

* 5 d) 
reg gdpgrowth   loggdp_1960 public_banks_1970  c.loggdp_1960#i.europe  c.public_banks_1970#i.europe, robust


