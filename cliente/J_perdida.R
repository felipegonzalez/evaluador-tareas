#Tarea 1 ejercicio 2
# Cid Reyes

J.perdida <- function(y,X){
  function(theta){
    h <- g(X %*% as.matrix(theta))
    -(1/nrow(X))*(sum(y*log(h)) + sum((1-y)*log(1-h)))
  }
}
