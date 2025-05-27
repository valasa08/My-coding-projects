clear all
set more off
cd "C:\Users\tbsko\sciebo\Lehre\Uni Bonn\Empirical_Banking\Tutorials\"


use "5_DiD - Jayarathne1996/2024/dataEmpBF_Tutorial5", replace

xtset  state year

*-------------------------------------
// 2 b) Replicate Paper Result
*-------------------------------------

** As in Jayarathne and Strahan we exclude the year of the deregulation (exclude ind_deregYear==1).
reghdfe GDPgr ind_dereg if ind_deregYear==0,   absorb(state year) vce(robust)
est store baseline
esttab baseline, tex drop(_cons) not se mtitle stats(N r2 r2_within)

*-------------------------------------
// 2 f) Test for parallel trends: parallel pre-trends
*-------------------------------------

xtset state year

* just lead 
reghdfe GDPgr  f1.ind_dereg, absorb(state year) vce(robust)
est store r2f0, title("1 lead only")

* lead and actual treatment 
reghdfe GDPgr  f(0/1).ind_dereg, absorb(state year) vce(robust)
est store r2f1, title("1 lead")

* two leads and actual treatment 
reghdfe GDPgr  f(0/2).ind_dereg, absorb(state year) vce(robust)
est store r2f2, title("2 leads")

* leads and lags 
reghdfe GDPgr l(0/1).ind_dereg f(1/1).ind_dereg, absorb(state year) vce(robust)
est store r2f3, title("lead \& lag")

esttab r2f0 r2f1  r2f3, tex drop(_cons) not se mtitle stats(N r2 r2_within)

*r2f2

* this is different: event study
reghdfe GDPgr l(-2/2).ind_deregYear, absorb(state year) vce(robust)
est store r2f5, title("event study")

esttab r2f5, tex drop(_cons) not se mtitle stats(N r2 r2_within)

coefplot, vertical drop(_cons) recast(connected) cirecast(rarea) yline(0, lcolor(black)) /// 
		lpattern(solid) mcolor(blue) lcolor(blue) ciopts(color(none) lpattern(dot) lcolor(blue)) /// 
		graphregion(color(white)) plotregion(color(white)) /// 
		ylab(,angle(0)) /// 
		rename(	F2.ind_deregYear = "-2" /// 
				F.ind_deregYear = "-1" /// 
				   ind_deregYear = "0" /// 
				L.ind_deregYear = "1" /// 
				L2.ind_deregYear = "2") /// 
		xtitle("Years to Deregulation", margin(top)) /// 
		ytitle("Change in %", margin(top)) ///
		title("Change in GDP per capita (in %)", color(black) size(small)) /// 
		name(Event_Study_GDP, replace)

graph export "C:\Users\tbsko\sciebo\Lehre\Uni Bonn\Empirical_Banking\Tutorials\5_DiD - Jayarathne1996\Discussion\2024\Graphs\Event_Study_GDP.png", replace
*-------------------------------------
// 3 a) Decompose overall effect into 2x2s
*-------------------------------------

bacondecomp GDPgr ind_dereg if ind_deregYear==0, stub(Bacon_) robust // ddetail 
gsort -Bacon_S
graph rename Decomposition
graph export "C:\Users\tbsko\sciebo\Lehre\Uni Bonn\Empirical_Banking\Tutorials\5_DiD - Jayarathne1996\Discussion\2024\Graphs\Decomposition.png", replace































