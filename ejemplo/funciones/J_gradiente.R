J.grad <- function(y, X){
  salida.fun <- function(theta){
    h.1 <- ((X %*% theta))
    h <- 1/(1+exp(-h.1))
    (1/length(y))*t(X)%*%(h-y)
  }
  salida.fun
}