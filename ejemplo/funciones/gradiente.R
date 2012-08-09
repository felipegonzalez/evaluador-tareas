J.grad <- function(y, X){
  salida.fun <- function(theta){
    h <- (g(X %*% theta))
    (1/length(y))*t(X)%*%(h-y)
  }
  salida.fun
}