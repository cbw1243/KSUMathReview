capture log close
log using wf4-returned, replace text

//  program:    wf4-returned.do
//  task:       using returned results
//  project:    workflow 4

//  #0
//  setup

version 10
set linesize 80
clear all
macro drop _all

//  #1
//  centering age by hand

use wf-lfp, clear
summarize age
generate age_mean = age - 42.53785
label var age_mean "age - mean(age)"
summarize age_mean

//  #2
//  centering with return results

summarize age
return list
generate age_meanV2 = age - r(mean)
label var age_meanV2 "age - mean(age)"
summarize age_mean age_meanV2

summarize age
generate double age_meanV3 = age - r(mean)
label var age_meanV3 "age - mean(age) using double precision"
summarize age_mean age_meanV2 age_meanV3

//  #3
//  adding returns to a local

summarize age
local mean_age = r(mean)
local sd_age = r(sd)
display "The mean of age `mean_age' (sd=`sd_age')."

* rounding the result
local mean_agefmt = string(r(mean),"%8.3f")
local sd_agefmt = string(r(sd),"%8.3f")
display "The mean of age `mean_agefmt' (sd=`sd_agefmt')."

* if you don't want to use locals, you can do this
display "The mean of age " %8.3f as result r(mean) ///
    " (sd=" %8.3f as result r(sd) ")"

log close
exit
