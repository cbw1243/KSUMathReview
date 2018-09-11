capture log close
log using wf4-macros-graph, replace text

//  program:    wf4-macros-graph.do
//  task:       macros for setting graph options
//  project:    workflow  4

//  #0
//  setup

version 10
set linesize 80
clear all
macro drop _all
set scheme s2manual

//  #1
//  load data

use wf-macros, clear

//  #2
//  complicated graph without using macros

graph twoway ///
  (connected pr_women articles, lpattern(solid) lwidth(medthick) ///
      lcolor(black) msymbol(i)) ///
  (connected pr_men articles,   lpattern(dash)  lwidth(medthick) ///
      lcolor(black) msymbol(i)) ///
  , ylabel(0(.2)1., grid glwidth(medium) glpattern(dash)) xlabel(0(10)50) ///
    ytitle("Probability of tenure") ///
    legend(pos(11) order(2 1) ring(0) cols(1))
graph export wf4-macros-graph.eps, replace

//  #3
//  options defined in locals

* line characteristics
local opt_linF   "lpattern(solid) lwidth(medthick) lcolor(black) msymbol(i)"
local opt_linM   "lpattern(dash)  lwidth(medthick) lcolor(black) msymbol(i)"
* grid options
local opt_ygrid  "grid glwidth(medium) glpattern(dash)"
* legend options
local opt_legend "pos(11) order(2 1) ring(0) cols(1)"

graph twoway ///
  (connected pr_women articles,     `opt_linF')   ///
  (connected pr_men   articles,     `opt_linM')   ///
  , xlabel(0(10)50) ylabel(0(.2)1., `opt_ygrid')  ///
    ytitle("Probability of tenure")               ///
    legend(`opt_legend')
	graph export wf4-macros-graph2.eps, replace


//  #4
//  change to colored lines

* line characteristics
local opt_linF   "lpattern(solid) lwidth(medthick) lcolor(red)  msymbol(i)"
local opt_linM   "lpattern(dash)  lwidth(medthick) lcolor(blue) msymbol(i)"

graph twoway ///
  (connected pr_women articles,     `opt_linF')   ///
  (connected pr_men   articles,     `opt_linM')   ///
  , xlabel(0(10)50) ylabel(0(.2)1., `opt_ygrid')  ///
    ytitle("Probability of tenure")               ///
    legend(`opt_legend')
    local opt_linF "clpat(solid) clwidth(medthick) clcolor(blue)"
    local opt_linM "clpat(solid) clwidth(medthick) clcolor(red) "

log close
exit
