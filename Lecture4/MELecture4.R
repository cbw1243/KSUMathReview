# Lecture 4: Calculus II
library(scatterplot3d)
library(rgl)
# 1. Convex and concave functions.
# Plot functions.
x <- seq(-5, 5, by = 0.01)

# Concave function
y1 <- sapply(x, function(i) -i^2+i+30)   # y = -x^2+x+30
plot(x, y1, type = 'l', col = 'purple', lwd = 3, xlab = 'x', ylab = 'y')
text(-3.5, 25, labels = 'y = -x^2 + x + 30', cex = 1.5)


# Convex function.
plot(x, -y1, type = 'l', col = 'purple', lwd = 3, xlab = 'x', ylab = 'y')
text(-3.5, -25, labels = 'y = -(-x^2 + x + 30)', cex = 1.5)


# 2. Three-dimensional convex function.
x <- rep(seq(-3, 3, by = 0.05), each = 121)
y <- rep(seq(-3, 3, by = 0.05), time = 121)

z <- mapply(function(x, y) x^2 + y^2, x, y)

plot3d(x, y, z, col = 'grey50', main = 'Function: z = x^2 + y^2')

# 3. Unconstrained optimization problem.
## Example 1
x <- seq(0, 50, by = 0.01)
y1 <- sapply(x, function(i) -2*(i^3) - 30*(i^2) + 3600*i -5000)   # y = -2x^3 - 30x^2 + 3600x - 5000

plot(x, y1, type = 'l', col = 'purple', lwd = 3, xlab = 'x', ylab = 'y')
points(x = c(20), y = c(39000), col = 'red', cex = 1.5, type = 'p', pch = 16)


## Example 2
x <- seq(-20, 30 , by = 0.01)
y1 <- sapply(x, function(i) 2*(i^3) - 30*(i^2) + 126*i + 59)   # y = 2x^3 - 30x^2 + 126x + 59

plot(x, y1, type = 'l', col = 'purple', lwd = 3, xlab = 'x', ylab = 'y')
points(x = c(3), y = c(221), col = 'red', cex = 1.5, type = 'p', pch = 16)
points(x = c( 7), y = c(157), col = 'blue', cex = 1.5, type = 'p', pch = 16)
text(0, 3000, labels = 'local max', cex = 1.5, col = 'red')
text(10, -2000, labels = 'local min', cex = 1.5, col = 'blue')


