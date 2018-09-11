*********************************
capture log close
log using NameofLogFile, replace text

//  program:    name of the program
//  task:       Name of the task
//  project:    Name of the project
//  author:     Name of the author

//  setup

version 10
set linesize 80
set trace off
clear all
macro drop _all

cd "\path"



*********************************



// Your Program Here





log close
exit
