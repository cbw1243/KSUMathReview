# Comformable matrix mulplication
A <- matrix(c(3, 6, 7,
              12, 9, 11), 
            ncol = 3, byrow = TRUE)


B <- matrix(c(6, 12, 
              5, 10,
              13, 2), 
            ncol = 2, byrow = TRUE)

A %*% B

# Non-comformable matrix mulplication
B <- matrix(c(6, 12, 
              5, 10,
              13, 2), 
            ncol = 3, byrow = TRUE)
A %*% B # Error expected. 

# Idempotent matrix
A <- matrix(c(5, -5, 
              4, -4), 
            ncol = 2, byrow = TRUE)

A %*% A

# Taking the inverse
A <- matrix(c(4, -2, 
              2, -6), 
            ncol = 2, byrow = TRUE)

solve(A)

# Cramer's rule
A <- matrix(c(1, 1, 1,
              12, 2, -3,
              3, 4, 1), 
            ncol = 3, byrow = TRUE)
B <- matrix(c(0, 
              5, 
             -4), 
            ncol = 1, byrow = TRUE)

A1 <- A
A1[, 1] <- B[,1]
x1 <- det(A1)/det(A)

A2 <- A
A2[, 2] <- B[,1]
x2 <- det(A2)/det(A)

A3 <- A
A3[, 3] <- B[,1]
x3 <- det(A3)/det(A)

x1; x2; x3

solve(A, B)
