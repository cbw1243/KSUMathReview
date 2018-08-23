# Lecture 3: Calculus I
# Linear approximation of functions.

# Plot functions. 
x <- seq(2, 3, by = 0.01)

# Actual function
y1 <- sapply(x, function(i) 2*log(i))   # y = 2log(x)
plot(x, y1, type = 'l', col = 'purple', lwd = 3, ylim = c(1, 3), xlab = 'x', ylab = 'y')

# Approximated function
y2 <- sapply(x, function(i) 2*log(2) + i - 2)  # y = 2log(2) - (x-2) 
lines(x, y2, col = 'red', lwd = 3)
legend('topleft', legend=c("Actual", "Approximated"),
       col=c("purple", 'red'), 
       lwd = 3, cex = 0.8, ncol = 1)

# Higher-order approximition
y3 <- sapply(x, function(i) 2*log(2) + (i - 2) - (2^(-2))*((i-2)^2))  
lines(x, y3, col = 'blue', lwd = 3)


