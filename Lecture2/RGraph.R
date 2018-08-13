# Lecture 2: Elementary algebras
# Plot functions. 
x <- seq(0, 10, by = 0.01)

# Linear
y1 <- sapply(x, function(i) 2*i + 1)   # y = 2x + 1
plot(x, y1, type = 'l', col = 'purple')

# Quadratic
y2 <- sapply(x, function(i) 2*i^2 - 4*i + 1)  # y = 2x^2 - 4x + 1 
plot(x, y2, type = 'l', col = 'purple')

# Polynomial function
y3 <- sapply(x, function(i) 2*i^4 - i^3 + 5*i - 5) # y = 2x^4 - x^3 + 5x - 5
plot(x, y3, type = 'l', col = 'purple')

# Power function
y4 <- sapply(x, function(i) 2*i^.5) # y = 2x^(.5)
plot(x, y4, type = 'l', col = 'purple')

# Plot all the functions
plot(x, y1, type = 'l', col = 'purple', lwd = 3, xlim = c(0, 10), ylim = c(-10, 50), xlab = 'x', ylab = 'y')
lines(x, y2, col = 'blue', lwd = 3)
lines(x, y3,  col = 'red', lwd = 3)
lines(x, y4,  col = 'black', lwd = 3)
legend('topright', legend=c("Linear", "Quadratic", "Polynomial", 'Power'),
                   col=c("purple", "blue", 'red', 'black'), 
                   lwd = 3, cex = 0.8, ncol = 2, text.width = 1)


