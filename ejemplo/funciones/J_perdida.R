J.perdida <- function(y, X){
  
  fun.salida <- function(theta){
    h <- (g(X %*% theta))
    J <- - sum(y*log(h) + (1-y)*log(1-h))
    J
  }
  fun.salida
}