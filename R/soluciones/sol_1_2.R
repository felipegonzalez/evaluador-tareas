sol_1_2 <- function(y, X){
  
  fun.salida <- function(theta){
    h <- (g(X %*% theta))
    J <- -(1/nrow(X))*( sum(y*log(h) + (1-y)*log(1-h)))
    J
  }
  fun.salida
}