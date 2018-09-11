capture log close
log using wf4-loops, replace text

//  program:    wf4-loops.do
//  task:       examples of loops
//  project:    workflow  4

//  #0
//  setup

version 10
set linesize 80
set trace off
clear all
macro drop _all

//  #1
//  create binary variables using a loop

use wf-loops, clear

* without loop
generate y_lt2 = y<2 if !missing(y)
generate y_lt3 = y<3 if !missing(y)
generate y_lt4 = y<4 if !missing(y)

* drop these do I can create them another way
drop y_lt2 y_lt3 y_lt4

* with foreach loop
foreach cutpt in 2 3 4 {
    generate y_lt`cutpt' = y<`cutpt' if !missing(y)
}

* drop these do I can create them another way
drop y_lt2 y_lt3 y_lt4

* with forvalues loop
forvalues cutpt = 2(1)4 {
    generate y_lt`cutpt' = y<`cutpt' if !missing(y)
}

//  #2
//  estimate models using a loop

local rhs "yr89 male white age ed prst"

* without a loop
logit y_lt2 `rhs'
logit y_lt3 `rhs'
logit y_lt4 `rhs'

* with foreach loop
foreach lhs in y_lt2 y_lt3 y_lt4 {
        logit `lhs' `rhs'
}

* with additional commands
foreach lhs in y_lt2 y_lt3 y_lt4 {
    tabulate `lhs'
    logit    `lhs' `rhs'
    probit   `lhs' `rhs'
}

//  #3 - not shown in text
//  expanding the loop to add labels

use wf-loops, clear

foreach cutpt in 2 3 4 {

    * create binary outcome
    generate y_lt`cutpt' = y<`cutpt' if !missing(y)
    * add labels
    label var y_lt`cutpt' "y is less than `cutpt'?"
    label define y_lt`cutpt' 0 "Not<`cutpt'" 1 "Is<`cutpt'"
    label val y_lt`cutpt' y_lt`cutpt'
    * tabulate outcome
    tabulate y_lt`cutpt' y
    * estimate models
    logit  y_lt`cutpt' `rhs'
    probit y_lt`cutpt' `rhs'

}

//  #4 - Loop Example 1
//  listing variables and value labels

use wf-loops, clear

* illustrate an extended macro function
local varlabel : variable label warm
display "Variable label for warm: `varlabel'"

* loop through variables and print results
foreach varname of varlist warm yr89 male white age ed prst {
    local varlabel : variable label `varname'
    display "`varname'" _col(12) "`varlabel'"
}

//  #5 - Loop Example 2
//  creating interactions

* interactions with simple variable labels
use wf-loops, clear
foreach varname of varlist yr89 white age ed prst {
    generate  maleX`varname' = male*`varname'
    label var maleX`varname'  "male*`varname'"
}
codebook maleX*, compact

* interactions with detailed variable labels
use wf-loops, clear
foreach varname of varlist yr89 white age ed prst {
    local varlabel : variable label `varname'
    generate  maleX`varname' = male*`varname'
    label var maleX`varname'  "male*`varlabel'"
}
codebook maleX*, compact

* interactions with detailed variable labels and names
use wf-loops, clear
foreach varname of varlist yr89 white age ed prst {
    local varlabel : variable label `varname'
    generate  maleX`varname' = male*`varname'
    label var maleX`varname'  "male*`varname' (`varlabel')"
}
codebook maleX*, compact

//  #6 - Loop Example 3
//  models with alternative measures of education

use wf-loops, clear
local edvars "edyrs edgths edgtcol edsqrtyrs edlths"
local rhs "male white age prst yr89"

foreach edvarname of varlist `edvars' {
    display _newline "==> education variable: `edvarname'"
    ologit warm `edvarname' `rhs'
}

//  #7 - Loop Example 4
//  recoding variables

* recode social distance measures
use wf-loops, clear
local sdvars "sdneighb sdsocial sdchild sdfriend sdwork sdmarry"

foreach varname of varlist `sdvars' {
    generate B`varname' = `varname'
    label var B`varname' "`varname': (1,2)=0 (3,4)=1"
    replace  B`varname' = 0 if `varname'==1 | `varname'==2
    replace  B`varname' = 1 if `varname'==3 | `varname'==4
}
codebook B*, compact

* transform income from five panels using loops over names
use wf-loops, clear
foreach varname of varlist incp1 incp2 incp3 incp4 incp5 {
    generate  ln`varname' = ln(`varname'+.5)
    label var ln`varname' "Log(`varname'+.5)"
}

* transform income from five panels using loops over panel
use wf-loops, clear
foreach panelnum in 1 2 3 4 5 {
    generate  lnincp`panelnum' = ln(incp`panelnum'+.5)
    label var lnincp`panelnum' "Log(incp`panelnum'+.5)"
}

//  #8 - Loop Example 5
//  creating a macro that holds accumulated information

local varlist ""
forvalues panelnum = 1/20 {
    local varlist "`varlist' incp`panelnum'"
}
display "varlist is: `varlist'"

* expanded version
local varlist ""
forvalues panelnum = 1/20 {
    local varlist "`varlist' incp`panelnum'"
    display _newline "panelnum is: `panelnum'"
    display          "varlist  is: `varlist'"
}

//  #9 - Loop Example #6
//  retrieving information returned by Stata

//  computing the percent of ones

* first, recreate the binary variables
use wf-loops, clear
local sdvars "sdneighb sdsocial sdchild sdfriend sdwork sdmarry"

foreach varname of varlist `sdvars' {
    generate B`varname' = `varname'
    replace  B`varname' = 0 if `varname'==1 | `varname'==2
    replace  B`varname' = 1 if `varname'==3 | `varname'==4
}

* compute the mean and see what is returned
summarize Bsdneighb
return list

* compute the percent of one's
local pct1 = r(mean)*100
display "The percent of ones is: `pct1'"

* using a loop to examine multiple variables

foreach varname of varlist `sdvars' {
    quietly summarize B`varname'
    local samplesize = r(N)
    local pct1 = r(mean)*100
    display "B`varname':" _col(14) "Pct1 = " %5.2f `pct1' ///
        _col(30) "N = `samplesize'"
}

//  computing the coefficient of variation

use wf-loops, clear
* note that the variables differ but the CV are the same
foreach varname of varlist incp1 incp2 incp3 incp4 {
    quietly summarize `varname'
    local cv = r(sd)/r(mean)
    display "CV for `varname': " %8.3f `cv'
}

//  #10 - extending Loop Example 1
//  counters

* version 1
use wf-loops, clear
local counter = 0
foreach varname of varlist warm yr89 male white age ed prst {
    local counter = `counter' + 1
    local varlabel : variable label `varname'
    display "`counter'. `varname'" _col(12) "`varlabel'"
}

* version 2
use wf-loops, clear
local counter = 0
foreach varname of varlist warm yr89 male white age ed prst {
    local ++counter
    local varlabel : variable label `varname'
    display "`counter'. `varname'" _col(12) "`varlabel'"
}

//  #11 - Loop Example #6
//  loops for saving results to matrices

* first, recreate the binary variables
use wf-loops, clear
local sdvars "sdneighb sdsocial sdchild sdfriend sdwork sdmarry"

foreach varname of varlist `sdvars' {
    generate B`varname' = `varname'
    replace  B`varname' = 0 if `varname'==1 | `varname'==2
    replace  B`varname' = 1 if `varname'==3 | `varname'==4
}

* compute percent 1s and N for each variable
local sdvars "Bsdneighb Bsdsocial Bsdchild Bsdfriend Bsdwork Bsdmarry"
local nvars : word count `sdvars'
matrix stats = J(`nvars',2,.)
matrix list stats
matrix colnames stats = Pct1s N
matrix rownames stats = `sdvars'
matrix list stats

local irow = 0
foreach varname of varlist `sdvars' {
    local ++irow
    quietly summarize `varname'
    local samplesize = r(N)
    local pct1 = r(mean)*100
    matrix stats[`irow',1] = `pct1'
    matrix stats[`irow',2] = `samplesize'
}

matrix list stats, format(%9.3f)

//  #12
//  nested loops

use wf-loops, clear
foreach yvar of varlist ya yb yc yd { // loop 1 begins
    foreach cutpt in 2 3 4 { // loop 2 begins
        * create binary variable
        generate `yvar'_lt`cutpt' = y<`cutpt' if !missing(y)
        * add labels
        label var    `yvar'_lt`cutpt' "y is less than `cutpt'?"
        label define `yvar'_lt`cutpt' 0 "Not<`cutpt'" 1 "Is<`cutpt'"
        label val  `yvar'_lt`cutpt' `yvar'_lt`cutpt'
    } // loop 2 ends
} // loop 1 ends

tab1 ya ya_lt2 ya_lt3 ya_lt4
tab1 yb yb_lt2 yb_lt3 yb_lt4

log close
exit
