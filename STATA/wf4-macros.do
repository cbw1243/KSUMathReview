capture log close
log using wf4-macros, replace text

//  program:    wf4-macros.do
//  task:       macro examples
//  project:    workflow  4

//  #0
//  setup

version 10
set linesize 80
clear all
macro drop _all

//  #1
//  examples of simple macros

* defining and displaying local macros
local rhs "var1 var2 var3 var4"
display "The local macro rhs contains: `rhs'"

local ncases = 198
display "The local ncases equals: `ncases'"


* defining and displaying global macros
global rhs "var1 var2 var3 var4"
display "The local macro rhs contains: $rhs"

global ncases = 198
display "The local ncases equals: $ncases"

* using double quotes
local myvars "y x1 x2"
display ">`myvars'<"

local myvars y x1 x2
display ">`myvars'<"

//  #2
//  entering long strings

* create the macros in one step
local demogvars "female black hispanic age agesq edhighschl edcollege edpostgrad incdollars childsqrt"
display "Start of macro=>`demogvars'<=End of macro"

* creating a long macro in steps
local demogvars "female black hispanic age agesq"
local demogvars "`demogvars' edhighschl edcollege edpostgrad"
local demogvars "`demogvars' incdollars childsqrt"

//  #3
//  using macros for a list of variables

use wf-macros, clear

summarize lfp k5 k618 age wc hc lwg inc
logit     lfp k5 k618 age wc hc lwg inc

summarize lfp k5 k618 age agesquared wc lwg inc
logit     lfp k5 k618 age agesquared wc lwg inc

local myvars "lfp k5 k618 age wc hc lwg inc"
summarize `myvars'
logit     `myvars'

local myvars "lfp k5 k618 age agesquared wc lwg inc"
summarize `myvars'
logit     `myvars'

//  #3
//  using macros to specify nested models

* create locals with sets of variables
local set1_age   "age agesquared"
local set2_educ  "wc hc"
local set3_kids  "k5 k618"
local set4_money "lwg inc"

display "  set1_age: `set1_age'"
display " set2_educ: `set2_educ'"
display " set3_kids: `set3_kids'"
display "set4_money: `set4_money'"

* specify nested models
local model_1 "`set1_age'"
local model_2 "`model_1' `set2_educ'"
local model_3 "`model_2' `set3_kids'"
local model_4 "`model_3' `set4_money'"

* check the model specifications
display "model_1: `model_1'"
display "model_2: `model_2'"
display "model_3: `model_3'"
display "model_4: `model_4'"

* run the nested models
logit lfp `model_1'
logit lfp `model_2'
logit lfp `model_3'
logit lfp `model_4'

log close
exit
