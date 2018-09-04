setwd('C:/BWCHEN/2_Course/MathReview/Bowen2018/KSUMathReview/RMaterials')
rm(list=ls())
library(datasets)


setwd('C:/BWCHEN/2_Course/MathReview/Bowen2018/Lecture11')

# Return the working directory.
getwd()

# Remove everything saved in R.
rm(list = ls())
# or to remove the single object
x <- 3 # Assign the numeric value 3 to the object called x.
rm('x')

# Install packages
install.packages('dplyr')
# Call the package
library(dplyr)
# Or, you can use the function below.
require(dplyr)

plot

?systemfit

# Read CSV data.
dat1 <- data.table::fread('comtrade_trade_data.csv')
# Read Excel data
dat2 <- readxl::read_xls('UN Comtrade Country List.xls',
                         sheet = 1, range = 'A1:I294')
# Write the data in CSV format.
# You should see a csv file in your working directory
# after running the codes below.
write.csv(dat1, file = 'comtrade_trade_data_test.csv')
# Write the data in excel format.
xlsx::write.xlsx(dat2, file = 'comtrade_trade_data_test.csv',
                 sheetName = 'Sheet1')


# Use R as an calculator
234/432
7392347983 + 378923749
39749*203023

# Use R to print something
'Hello, world'
print('Hello, world')
cat('Hello, world')


x <- 3 # a numerical value
x
x + 1 # Add 1 to the value in x
x <- 'Kansas State University' # a character
x
x + 1 # Encounter an error, because x is an character
x <- TRUE # a logical value
x
y


data(cars)
head(cars)
tail(cars)

ncol(cars) # Number of columns in the dataset
nrow(cars) # Number of rows in the dataset
colnames(cars) <- c('SPEED', 'DISTANCE') # Specify the column names.
summary(cars) # Summary stats of the data
cars$type <- 'Chevy' # Make an another column.
cars[1, 2]


func <- function(x) {
  y = ...
  return(y)
}

func <- function(x) {
  y = x^2  # square of x.
  return(y)
}
y <- func(x = 2)
y


func2 <- function(x1, x2){
  y = (x1 + x2)^2
  return(y)
}
y <- func2(x1 = 2, x2 = 4)
y


func <- function(x) {
  is.character(x) # Is the input a character?
}
func('J')
func(1)
func(TRUE)

func <- function(x) {
  max(x) # What is the maximum number in the vector?
}

set.seed(101)
y <- rnorm(100, 0, 1)
func(y)

func_max <- function(x) {
  max(x[-which(x == max(x))]) # What is the second-largest number in the vector?
}

y <- rnorm(10, 0, 1)
func_max(y)


func_max <- function(x) {
  sort(x, decreasing = TRUE)[2] # What is the second-largest number in the vector?
}

set.seed(101)
y <- rnorm(10, 0, 1)
func_max(y)


func <- function(x1, x2) {
  y = x1 + x2
  out <- list(y = y, x1 = x1, x2 = x2)
  return(out)
}

y <- func(2, 3)
y[[1]]; y[['y']]
y[[2]];y[['x1']]


guessfunc <- function(i){
  computerguess <- sample(c('head', 'tail'), 1)
  if(i == computerguess){
    print('You win')
  }else{
    print('You loss')
  }
}
set.seed(1011)
guessfunc('head')
guessfunc('tail')


set.seed(1012) # Now we play with another machine.
guessfunc2 <- function(i){
  computerguess <- sample(c('head', 'tail'), 1)
  cost <- 6
  if(i == computerguess){
    revenue <- 10
  }else{
    revenue <- 0
  }
  netincome <- revenue - cost
  return(netincome)
}
guessfunc2('head')
guessfunc2('tail')


set.seed(1012)
guessfunc3 <- function(i){
  computerguess <- sample(c('head', 'tail'), 1)
  cost <- 6
  revenue <- ifelse(i == computerguess, 10, 0) # simplified version of if-else.
  netincome <- revenue - cost
  return(netincome)
}
guessfunc3('head')
guessfunc3('tail')


StringSample <- c('I like Kansas State University. I am proud of being a Wildcat.')
test <- strsplit(StringSample, split = ' ') # Split the string by space.
test[[1]]

paste(test[[1]], collapse = ' ') # Return to original format.

test <- strsplit(StringSample, split = 'a') # Split the string by the letter "a".
test[[1]]



nchar(StringSample) # Number of characters in the string
grep('Kansas', StringSample) # Returns the index of element where "Kansas" is
grepl('Kansas', StringSample) # Is "Kansas" in the vector?
sub('I', 'i', StringSample) # Replace "I" by "i", for the first time that "I" appears.
gsub('I', 'i', StringSample) # Replace all "I"s by "i".
substr(StringSample, 1, 4) # Choose the string from 1 to 4.
toupper(StringSample) # Capitalize all the letters
tolower(StringSample) # De-capitalize all the letters



set.seed(10)
A = matrix(sample(c(1:20), 9), nrow = 3, ncol = 3, byrow = TRUE)
A
set.seed(11)
B = matrix(sample(c(1:20), 9), nrow = 3, ncol = 3, byrow = TRUE)
B

# Matrix operations
A + B
A - B
A %*% B # Note that it is different to A*B
solve(A) # The inverse of A
B2 <- matrix(sample(c(1:20), 3), nrow = 3, ncol = 1, byrow = TRUE)
solve(A, B2) # Solve Ax= B2
crossprod(A, B) # = A'B
crossprod(A) # = A'A
t(A) # Transpose of A
diag(A) # diagonal matrix with diagonal elements in A
eigen(A) # eigenvalues of A



set.seed(101)
dat <- data.frame(matrix(rnorm(100, 0, 1), 20, 5)) # Create a matrix with 20 rows and 5 columns.
# The data are from a standard normal distribution.
apply(dat, 2, sd) # Compute column means


out1 <- lapply(c(1: ncol(dat)), function(i) sd(dat[, i]))
out1


out2 <- sapply(c(1: ncol(dat)), function(i) sd(dat[, i]))
out2


for (i in 1:ncol(dat)){
  print(sd(dat[, i]))
}


colValues <- dat[, 1] # Values in the first column

for (i in 1:length(colValues)){
  print(colValues[i])
  if(colValues[i] > 0.1) break
}

for (i in 1:length(colValues)){
  print(colValues[i])
  stopifnot(colValues[i] <= 0.1)
}

