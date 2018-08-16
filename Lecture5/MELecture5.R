library(scatterplot3d)
library(rgl)


# Example 1. 
## Specify the function 
func <- function(x, y) 3*x^2*y^3

## Specify the domain.
xdomain <- seq(-3, 3, by = 0.05)
ydomain <- seq(-3, 3, by = 0.05)

## Calibrate the x values.
x <- rep(xdomain, each = length(xdomain))
y <- rep(ydomain, time = length(ydomain))

## Calculate the z values.
z <- mapply(func, x, y)

## Plot the function. 
plot3d(x, y, z, col = 'grey50')


# Linear approximation. 
AllFunc <- function(func = NULL, PartialFunc = NULL, OriginalPoint, xdomain, ydomain){

## Calibrate the x values.
x <- rep(xdomain, each = length(xdomain))
y <- rep(ydomain, time = length(ydomain))

z <- mapply(func, x, y)

zapprox <- mapply(function(dx, dy) func(OriginalPoint[1], OriginalPoint[2]) + PartialFunc(dx, dy), x - OriginalPoint[1], y - OriginalPoint[2])

plot3d(x, y, z, col = 'red')
plot3d(x, y, zapprox, col = 'grey50', add = TRUE)
}


## Change the domain.
xdomain <- seq(-3, -1, by = 0.05)
ydomain <- seq(-3, -1, by = 0.05)

PartialFunc <- function(dx, dy) 6*(-3)*((-3)^3)*dx + 9*((-3)^2)*((-3)^2)*dy

AllFunc(func = func, PartialFunc = PartialFunc, OriginalPoint = c(-3, -3), xdomain = xdomain, ydomain = ydomain)


# Example 2. 
## Specify the function 
func <- function(x, y) 4*x^(0.75)*y^0.25

## Specify the domain.
xdomain <- seq(10, 50, by = 0.05)
ydomain <- seq(10, 50, by = 0.05)

## Calibrate the x values.
x <- rep(xdomain, each = length(xdomain))
y <- rep(ydomain, time = length(ydomain))

## Calculate the z values.
z <- mapply(func, x, y)

## Plot the function. 
plot3d(x, y, z, col = 'grey50')


# Linear approximation. 
OriginalPoint = c(10, 10)
PartialFunc <- function(dx, dy) 3*(OriginalPoint[2]/OriginalPoint[1])^(.25)*dx + (OriginalPoint[1]/OriginalPoint[2])^(.75)*dy
AllFunc(func = func, PartialFunc = PartialFunc, OriginalPoint = OriginalPoint, xdomain = xdomain, ydomain = ydomain)



